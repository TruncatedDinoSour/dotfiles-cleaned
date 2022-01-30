#lang racket/base

(require (for-syntax racket/base
                     syntax/parse)
         racket/contract
         racket/match)

(provide
 exn:fail:pool?

 pool?
 make-pool
 pool-take!
 pool-release!
 pool-close!
 call-with-pool-resource

 current-idle-timeout-slack)

(define-logger resource-pool)

(struct exn:fail:pool exn:fail ())

(struct pool (req-ch mgr))

(struct Req (nack-evt res-ch))
(struct Lease Req ())
(struct Release Req (r))
(struct Close Req ())

(define (oops msg . args)
  (exn:fail:pool
   (apply format msg args)
   (current-continuation-marks)))

(define current-idle-timeout-slack
  (make-parameter (* 15 1000)))

(define/contract (make-pool make-resource
                            [destroy-resource void]
                            #:max-size [max-size 8]
                            #:idle-ttl [idle-ttl (* 3600 1000)])
  (->* ((-> any/c))
       ((-> any/c void?)
        #:max-size exact-positive-integer?
        #:idle-ttl (or/c +inf.0 exact-positive-integer?))
       pool?)
  (define req-ch (make-channel))
  (define mgr (make-mgr req-ch make-resource destroy-resource max-size idle-ttl))
  (pool req-ch mgr))

(define (make-mgr req-ch make-resource destroy-resource max-size idle-ttl)
  (thread/suspend-to-kill
   (lambda ()
     (define slack (current-idle-timeout-slack))
     (define deadlines (make-hasheq))
     (define (reset-deadline! r)
       (hash-set! deadlines r (+ (current-inexact-milliseconds) idle-ttl)))
     (define (remove-deadline! r)
       (hash-remove! deadlines r))

     (let loop ([closed? #f]
                [total 0]
                [idle null]
                [busy null]
                [requests null])
       (define idle-timeout-evt
         (if (hash-empty? deadlines)
             never-evt
             (alarm-evt (+ (apply min (hash-values deadlines)) slack))))

       (apply
        sync
        (handle-evt
         req-ch
         (match-lambda
           [`(lease ,nack-evt ,res-ch)
            (define req (Lease nack-evt res-ch))
            (cond
              [(and (null? idle) (< total max-size))
               (define r (make-resource))
               (reset-deadline! r)
               (log-resource-pool-debug "created ~e" r)
               (loop closed? (add1 total) (cons r idle) busy (cons req requests))]

              [else
               (loop closed? total idle busy (cons req requests))])]

           [`(release ,r ,nack-evt ,res-ch)
            (define req (Release nack-evt res-ch r))
            (loop closed? total idle busy (cons req requests))]

           [`(close ,nack-evt ,res-ch)
            (define req (Close nack-evt res-ch))
            (loop closed? total idle busy (cons req requests))]))

        (handle-evt
         idle-timeout-evt
         (lambda (_)
           (define now (current-inexact-milliseconds))
           (define-values (idle* n-destroyed)
             (for/fold ([idle* null]
                        [n-destroyed 0])
                       ([(r deadline) (in-hash deadlines)])
               (cond
                 [(< deadline now)
                  (remove-deadline! r)
                  (with-handlers ([exn:fail?
                                   (lambda (e)
                                     (log-resource-pool-warning "failed to destroy idle resource: ~a~n  resource: ~e" (exn-message e) r))])
                    (destroy-resource r))
                  (values idle* (add1 n-destroyed))]
                 [else
                  (values (cons r idle*) n-destroyed)])))
           (log-resource-pool-debug "destroyed ~s idle resource(s)" n-destroyed)
           (loop closed? (- total n-destroyed) idle* busy requests)))

        (append
         (for/list ([req (in-list requests)])
           (match req
             [(Req _ res-ch)
              #:when closed?
              (handle-evt
               (channel-put-evt res-ch (oops "pool closed"))
               (lambda (_)
                 (loop closed? total idle busy (remq req requests))))]

             [(Lease _ res-ch)
              (cond
                [(null? idle) never-evt]
                [else
                 (define r (car idle))
                 (handle-evt
                  (channel-put-evt res-ch r)
                  (lambda (_)
                    (remove-deadline! r)
                    (log-resource-pool-debug "leased ~e" r)
                    (loop closed? total (cdr idle) (cons r busy) (remq req requests))))])]

             [(Release _ res-ch r)
              (cond
                [(memq r busy)
                 (handle-evt
                  (channel-put-evt res-ch 'released)
                  (lambda (_)
                    (reset-deadline! r)
                    (log-resource-pool-debug "released ~e" r)
                    (loop closed? total (cons r idle) (remq r busy) (remq req requests))))]

                [else
                 (handle-evt
                  (channel-put-evt res-ch (oops "released resource was never leased: ~e" r))
                  (lambda (_)
                    (loop closed? total idle busy (remq req requests))))])]

             [(Close _ res-ch)
              (cond
                [(null? busy)
                 (handle-evt
                  (channel-put-evt res-ch 'closed)
                  (lambda (_)
                    (log-resource-pool-debug "destroying all idle resources")
                    (for-each destroy-resource idle)
                    (loop #t 0 null null null)))]

                [else
                 (handle-evt
                  (channel-put-evt res-ch (oops "attempted to close pool without releasing all the resources"))
                  (lambda (_)
                    (loop closed? total idle busy (remq req requests))))])]))
         (for/list ([req (in-list requests)])
           (handle-evt
            (Req-nack-evt req)
            (lambda (_)
              (loop closed? total idle busy (remq req requests)))))))))))

(define/contract (call-with-pool-resource p f #:timeout [timeout #f])
  (->* (pool? (-> any/c any))
       (#:timeout (or/c #f exact-nonnegative-integer?))
       any)
  (define r #f)
  (dynamic-wind
    (lambda ()
      (set! r (pool-take! p timeout))
      (unless r
        (raise (oops "timed out while taking resource"))))
    (lambda ()
      (f r))
    (lambda ()
      (pool-release! p r))))

(define/contract (pool-take! p [t #f])
  (->* (pool?) ((or/c #f exact-nonnegative-integer?)) (or/c #f any/c))
  (dispatch p lease #:timeout t))

(define/contract (pool-release! p r)
  (-> pool? any/c void?)
  (void (dispatch p release r)))

(define/contract (pool-close! p)
  (-> pool? void?)
  (void (dispatch p close)))

(define-syntax (dispatch stx)
  (syntax-parse stx
    [(_ p id (~optional (~seq #:timeout timeout)) arg ...)
     #'(dispatch* p 'id (~? timeout #f) arg ...)]))

(define (dispatch* p id timeout . args)
  (define res-or-exn
    (sync
     (apply pool-evt p id args)
     (if timeout
         (wrap-evt
          (alarm-evt (+ (current-inexact-milliseconds) timeout))
          (λ (_) #f))
         never-evt)))
  (begin0 res-or-exn
    (when (exn:fail:pool? res-or-exn)
      (raise res-or-exn))))

(define (pool-evt p id . args)
  (nack-guard-evt
   (lambda (nack-evt)
     (define res-ch (make-channel))
     (begin0 res-ch
       (thread-resume (pool-mgr p) (current-thread))
       (channel-put (pool-req-ch p) `(,id ,@args ,nack-evt ,res-ch))))))
