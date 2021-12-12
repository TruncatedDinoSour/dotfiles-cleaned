#lang racket/base
(require (for-syntax racket/base)
         racket/stxparam)

(provide while break continue)

;; The following is adapted from:
;;
;; http://matt.might.net/articles/implementing-exceptions/
;;
;; with a few adjustments so that break and continue are
;; hygienic, and the extent of the break and continue are
;; around the body.
;;
(define-syntax-parameter break
  (lambda (stx) 
    (raise-syntax-error #f "Used outside the context of a while body" stx)))

(define-syntax-parameter continue
  (lambda (stx) 
    (raise-syntax-error #f "Used outside the context of a while body" stx)))

;; This enforces the use of break and continue:
;; you have to use them with parens, or else they should
;; complain at compile time.
(define-for-syntax (force-use-with-parens b)
  (lambda (stx)
    (syntax-case stx ()
      [(_)
       (with-syntax ([b b])
         (syntax/loc stx
           (b)))]
      [(kw arg arg-rest ...)
       (raise-syntax-error #f
                           (format "Must be directly used without arguments [e.g: (~a)]"
                                   (syntax->datum #'kw))
                           stx
                           #'arg)]
      [_
       (identifier? stx)
       (raise-syntax-error #f
                           (format "Must be directly used [e.g: (~a)]"
                                   (syntax->datum stx))
                           stx)])))

        
(define-syntax (while stx)
  (syntax-case stx ()
    [(_)
     (raise-syntax-error #f "missing test and body" stx)]

    [(_ cond)
     (raise-syntax-error #f "missing body" stx)]
    
    [(_ cond body ...)
     (syntax/loc stx
       (let/ec fresh-break 
         (let loop ()
           (when cond
             (let/ec fresh-continue
               (syntax-parameterize 
                   ([break (force-use-with-parens #'fresh-break)]
                    [continue (force-use-with-parens #'fresh-continue)])
                 (begin body ...)))
             (loop)))))]))


;; By the way: it's a bit unclear what should happen if
;; someone tries using break and continue within the
;; context of a nested while loop's test... e.g.
;; (while true
;;    (while (begin (break))
;;      'huh?)
;;    'what?)
;;
;; This particular implementation is implemented such that
;; the call to break will exit the outer loop.  It is an odd
;; thing to think about, isn't it?  :)
;;
;; It should be easy to syntactically restrict if this really
;; becomes an issue, by syntax-parameterizing error productions
;; in the context of evaluating the _cond_ition.