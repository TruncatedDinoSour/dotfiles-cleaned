3532
((3) 0 () 1 ((q lib "net/http-easy.rkt")) () (h ! (equal) ((c def c (c (? . 0) q timeout/c)) q (16215 . 2)) ((c def c (c (? . 0) q exn:fail:http-easy:timeout?)) q (16682 . 3)) ((c def c (c (? . 0) q file-part)) q (15663 . 7)) ((c def c (c (? . 0) q patch)) q (6537 . 28)) ((c def c (c (? . 0) q make-pool-config)) q (13774 . 5)) ((c def c (c (? . 0) q exn:fail:http-easy:timeout-kind)) q (16755 . 4)) ((c def c (c (? . 0) q limit/c)) q (13658 . 2)) ((c def c (c (? . 0) q delete)) q (2581 . 28)) ((c def c (c (? . 0) q response-headers)) q (12557 . 3)) ((c def c (c (? . 0) q bearer-auth)) q (14885 . 3)) ((c def c (c (? . 0) q json-payload)) q (15157 . 3)) ((c def c (c (? . 0) q make-proxy)) q (14038 . 4)) ((c def c (c (? . 0) q response-headers-ref*)) q (12737 . 4)) ((c def c (c (? . 0) q read-response-xexpr)) q (13399 . 3)) ((c def c (c (? . 0) q response-status-code)) q (12411 . 3)) ((c def c (c (? . 0) q timeout-config?)) q (16278 . 3)) ((c def c (c (? . 0) q session?)) q (9564 . 3)) ((c def c (c (? . 0) q response-status-message)) q (12486 . 3)) ((c def c (c (? . 0) q current-user-agent)) q (16881 . 4)) ((c def c (c (? . 0) q pure-payload)) q (15311 . 3)) ((c def c (c (? . 0) q form-payload)) q (15082 . 3)) ((c def c (c (? . 0) q response-status-line)) q (12274 . 3)) ((c def c (c (? . 0) q get)) q (0 . 28)) ((c def c (c (? . 0) q multipart-payload)) q (15958 . 6)) ((c def c (c (? . 0) q part?)) q (15411 . 3)) ((c def c (c (? . 0) q make-session)) q (9618 . 10)) ((c def c (c (? . 0) q post)) q (1284 . 28)) ((c def c (c (? . 0) q form-data/c)) q (9283 . 2)) ((c def c (c (? . 0) q gzip-payload)) q (15228 . 3)) ((c def c (c (? . 0) q session-request)) q (10158 . 32)) ((c def c (c (? . 0) q current-session)) q (9439 . 5)) ((c def c (c (? . 0) q read-response)) q (13251 . 3)) ((c def c (c (? . 0) q pool-config?)) q (13716 . 3)) ((c def c (c (? . 0) q put)) q (7847 . 28)) ((c def c (c (? . 0) q head)) q (3904 . 28)) ((c def c (c (? . 0) q response-history)) q (12837 . 3)) ((c def c (c (? . 0) q response-json)) q (13043 . 3)) ((c def c (c (? . 0) q field-part)) q (15462 . 5)) ((c def c (c (? . 0) q make-https-proxy)) q (14422 . 5)) ((c def c (c (? . 0) q response-close!)) q (13596 . 3)) ((c def c (c (? . 0) q response-http-version)) q (12342 . 3)) ((c def c (c (? . 0) q response-headers-ref)) q (12631 . 4)) ((c def c (c (? . 0) q exn:fail:http-easy?)) q (16617 . 3)) ((c def c (c (? . 0) q response-output)) q (12975 . 3)) ((c def c (c (? . 0) q response?)) q (11813 . 3)) ((c def c (c (? . 0) q make-http-proxy)) q (14211 . 5)) ((c def c (c (? . 0) q session-close!)) q (10098 . 3)) ((c def c (c (? . 0) q response-xml)) q (13188 . 3)) ((c def c (c (? . 0) q make-timeout-config)) q (16339 . 7)) ((c def c (c (? . 0) q query-params/c)) q (9359 . 3)) ((c def c (c (? . 0) q read-response-xml)) q (13466 . 3)) ((c def c (c (? . 0) q response-body)) q (12914 . 3)) ((c def c (c (? . 0) q status-code/c)) q (11766 . 2)) ((c form c (c (? . 0) q response)) q (11868 . 16)) ((c def c (c (? . 0) q proxy?)) q (13986 . 3)) ((c def c (c (? . 0) q response-xexpr)) q (13126 . 3)) ((c def c (c (? . 0) q response-drain!)) q (13534 . 3)) ((c def c (c (? . 0) q method/c)) q (9131 . 3)) ((c def c (c (? . 0) q payload-procedure/c)) q (14976 . 3)) ((c def c (c (? . 0) q basic-auth)) q (14738 . 4)) ((c def c (c (? . 0) q options)) q (5201 . 28)) ((c def c (c (? . 0) q headers/c)) q (9220 . 2)) ((c def c (c (? . 0) q auth-procedure/c)) q (14635 . 3)) ((c def c (c (? . 0) q read-response-json)) q (13311 . 3))))
procedure
(get  uri                               
     [#:close? close?                   
      #:stream? stream?                 
      #:headers headers                 
      #:params params                   
      #:auth auth                       
      #:data data                       
      #:form form                       
      #:json json                       
      #:timeouts timeouts               
      #:max-attempts max-attempts       
      #:max-redirects max-redirects     
      #:user-agent user-agent])     -> response?
  uri : (or/c bytes? string? url?)
  close? : boolean? = #f
  stream? : boolean? = #f
  headers : headers/c = (hasheq)
  params : query-params/c = null
  auth : (or/c false/c auth-procedure/c) = #f
  data : (or/c false/c bytes? string? input-port? payload-procedure/c)
       = #f
  form : query-params/c = unsupplied
  json : jsexpr? = unsupplied
  timeouts : timeout-config? = (make-timeout-config)
  max-attempts : exact-positive-integer? = 3
  max-redirects : exact-nonnegative-integer? = 16
  user-agent : (or/c bytes? string?) = (current-user-agent)
procedure
(post  uri                               
      [#:close? close?                   
       #:stream? stream?                 
       #:headers headers                 
       #:params params                   
       #:auth auth                       
       #:data data                       
       #:form form                       
       #:json json                       
       #:timeouts timeouts               
       #:max-attempts max-attempts       
       #:max-redirects max-redirects     
       #:user-agent user-agent])     -> response?
  uri : (or/c bytes? string? url?)
  close? : boolean? = #f
  stream? : boolean? = #f
  headers : headers/c = (hasheq)
  params : query-params/c = null
  auth : (or/c false/c auth-procedure/c) = #f
  data : (or/c false/c bytes? string? input-port? payload-procedure/c)
       = #f
  form : query-params/c = unsupplied
  json : jsexpr? = unsupplied
  timeouts : timeout-config? = (make-timeout-config)
  max-attempts : exact-positive-integer? = 3
  max-redirects : exact-nonnegative-integer? = 16
  user-agent : (or/c bytes? string?) = (current-user-agent)
procedure
(delete  uri                               
        [#:close? close?                   
         #:stream? stream?                 
         #:headers headers                 
         #:params params                   
         #:auth auth                       
         #:data data                       
         #:form form                       
         #:json json                       
         #:timeouts timeouts               
         #:max-attempts max-attempts       
         #:max-redirects max-redirects     
         #:user-agent user-agent])     -> response?
  uri : (or/c bytes? string? url?)
  close? : boolean? = #f
  stream? : boolean? = #f
  headers : headers/c = (hasheq)
  params : query-params/c = null
  auth : (or/c false/c auth-procedure/c) = #f
  data : (or/c false/c bytes? string? input-port? payload-procedure/c)
       = #f
  form : query-params/c = unsupplied
  json : jsexpr? = unsupplied
  timeouts : timeout-config? = (make-timeout-config)
  max-attempts : exact-positive-integer? = 3
  max-redirects : exact-nonnegative-integer? = 16
  user-agent : (or/c bytes? string?) = (current-user-agent)
procedure
(head  uri                               
      [#:close? close?                   
       #:stream? stream?                 
       #:headers headers                 
       #:params params                   
       #:auth auth                       
       #:data data                       
       #:form form                       
       #:json json                       
       #:timeouts timeouts               
       #:max-attempts max-attempts       
       #:max-redirects max-redirects     
       #:user-agent user-agent])     -> response?
  uri : (or/c bytes? string? url?)
  close? : boolean? = #f
  stream? : boolean? = #f
  headers : headers/c = (hasheq)
  params : query-params/c = null
  auth : (or/c false/c auth-procedure/c) = #f
  data : (or/c false/c bytes? string? input-port? payload-procedure/c)
       = #f
  form : query-params/c = unsupplied
  json : jsexpr? = unsupplied
  timeouts : timeout-config? = (make-timeout-config)
  max-attempts : exact-positive-integer? = 3
  max-redirects : exact-nonnegative-integer? = 16
  user-agent : (or/c bytes? string?) = (current-user-agent)
procedure
(options  uri                               
         [#:close? close?                   
          #:stream? stream?                 
          #:headers headers                 
          #:params params                   
          #:auth auth                       
          #:data data                       
          #:form form                       
          #:json json                       
          #:timeouts timeouts               
          #:max-attempts max-attempts       
          #:max-redirects max-redirects     
          #:user-agent user-agent])     -> response?
  uri : (or/c bytes? string? url?)
  close? : boolean? = #f
  stream? : boolean? = #f
  headers : headers/c = (hasheq)
  params : query-params/c = null
  auth : (or/c false/c auth-procedure/c) = #f
  data : (or/c false/c bytes? string? input-port? payload-procedure/c)
       = #f
  form : query-params/c = unsupplied
  json : jsexpr? = unsupplied
  timeouts : timeout-config? = (make-timeout-config)
  max-attempts : exact-positive-integer? = 3
  max-redirects : exact-nonnegative-integer? = 16
  user-agent : (or/c bytes? string?) = (current-user-agent)
procedure
(patch  uri                               
       [#:close? close?                   
        #:stream? stream?                 
        #:headers headers                 
        #:params params                   
        #:auth auth                       
        #:data data                       
        #:form form                       
        #:json json                       
        #:timeouts timeouts               
        #:max-attempts max-attempts       
        #:max-redirects max-redirects     
        #:user-agent user-agent])     -> response?
  uri : (or/c bytes? string? url?)
  close? : boolean? = #f
  stream? : boolean? = #f
  headers : headers/c = (hasheq)
  params : query-params/c = null
  auth : (or/c false/c auth-procedure/c) = #f
  data : (or/c false/c bytes? string? input-port? payload-procedure/c)
       = #f
  form : query-params/c = unsupplied
  json : jsexpr? = unsupplied
  timeouts : timeout-config? = (make-timeout-config)
  max-attempts : exact-positive-integer? = 3
  max-redirects : exact-nonnegative-integer? = 16
  user-agent : (or/c bytes? string?) = (current-user-agent)
procedure
(put  uri                               
     [#:close? close?                   
      #:stream? stream?                 
      #:headers headers                 
      #:params params                   
      #:auth auth                       
      #:data data                       
      #:form form                       
      #:json json                       
      #:timeouts timeouts               
      #:max-attempts max-attempts       
      #:max-redirects max-redirects     
      #:user-agent user-agent])     -> response?
  uri : (or/c bytes? string? url?)
  close? : boolean? = #f
  stream? : boolean? = #f
  headers : headers/c = (hasheq)
  params : query-params/c = null
  auth : (or/c false/c auth-procedure/c) = #f
  data : (or/c false/c bytes? string? input-port? payload-procedure/c)
       = #f
  form : query-params/c = unsupplied
  json : jsexpr? = unsupplied
  timeouts : timeout-config? = (make-timeout-config)
  max-attempts : exact-positive-integer? = 3
  max-redirects : exact-nonnegative-integer? = 16
  user-agent : (or/c bytes? string?) = (current-user-agent)
value
method/c
 : (or/c 'delete 'head 'get 'options 'patch 'post 'put symbol?)
value
headers/c : (hash/c symbol? (or/c bytes? string?))
value
form-data/c : (listof (cons/c symbol? (or/c false/c string?)))
value
query-params/c
 : (listof (cons/c symbol? (or/c false/c string?)))
parameter
(current-session) -> session?
(current-session session) -> void?
  session : session?
 = (make-session)
procedure
(session? v) -> boolean?
  v : any/c
procedure
(make-session [#:pool-config pool-config     
               #:ssl-context ssl-context     
               #:cookie-jar cookie-jar       
               #:proxies proxies])       -> session?
  pool-config : pool-config? = (make-pool-config)
  ssl-context : ssl-client-context?
              = (ssl-secure-client-context)
  cookie-jar : (or/c false/c (is-a?/c cookie-jar<%>)) = #f
  proxies : (listof proxy?) = null
procedure
(session-close! s) -> void?
  s : session?
procedure
(session-request  s                                 
                  uri                               
                 [#:close? close?                   
                  #:stream? stream?                 
                  #:method method                   
                  #:headers headers                 
                  #:params params                   
                  #:auth auth                       
                  #:data data                       
                  #:form form                       
                  #:json json                       
                  #:timeouts timeouts               
                  #:max-attempts max-attempts       
                  #:max-redirects max-redirects     
                  #:user-agent user-agent])     -> response?
  s : session?
  uri : (or/c bytes? string? url?)
  close? : boolean? = #f
  stream? : boolean? = #f
  method : method/c = 'get
  headers : headers/c = (hasheq)
  params : query-params/c = null
  auth : (or/c false/c auth-procedure/c) = #f
  data : (or/c false/c bytes? string? input-port? payload-procedure/c)
       = #f
  form : form-data/c = unsupplied
  json : jsexpr? = unsupplied
  timeouts : timeout-config? = (make-timeout-config)
  max-attempts : exact-positive-integer? = 3
  max-redirects : exact-nonnegative-integer? = 16
  user-agent : (or/c bytes? string?) = (current-user-agent)
value
status-code/c : (integer-in 100 999)
procedure
(response? v) -> boolean?
  v : any/c
syntax
(response clause ...)
 
    clause = #:status-line e
           | #:status-code e
           | #:status-message e
           | #:http-version e
           | #:history e
           | #:headers heads maybe-rest
           | #:body e
           | #:json e
              
     heads = ([header-id e] ...)
              
maybe-rest = 
           | e
procedure
(response-status-line r) -> bytes?
  r : response?
procedure
(response-http-version r) -> bytes?
  r : response?
procedure
(response-status-code r) -> status-code/c
  r : response?
procedure
(response-status-message r) -> bytes?
  r : response?
procedure
(response-headers r) -> (listof bytes?)
  r : response?
procedure
(response-headers-ref r h) -> (or/c false/c bytes?)
  r : response?
  h : symbol?
procedure
(response-headers-ref* r h) -> (listof bytes?)
  r : response?
  h : symbol?
procedure
(response-history r) -> (listof response?)
  r : response?
procedure
(response-body r) -> bytes?
  r : response?
procedure
(response-output r) -> input-port?
  r : response?
procedure
(response-json r) -> (or/c eof-object? jsexpr?)
  r : response?
procedure
(response-xexpr r) -> xexpr?
  r : response?
procedure
(response-xml r) -> document?
  r : response?
procedure
(read-response r) -> any/c
  r : response?
procedure
(read-response-json r) -> (or/c eof-object? jsexpr?)
  r : response?
procedure
(read-response-xexpr r) -> xexpr?
  r : response?
procedure
(read-response-xml r) -> document?
  r : response?
procedure
(response-drain! r) -> void?
  r : response?
procedure
(response-close! r) -> void?
  r : response?
value
limit/c : (or/c +inf.0 exact-positive-integer?)
procedure
(pool-config? v) -> boolean?
  v : any/c
procedure
(make-pool-config [#:max-size max-size               
                   #:idle-timeout idle-timeout]) -> pool-config?
  max-size : limit/c = 128
  idle-timeout : timeout/c = 600
procedure
(proxy? v) -> boolean?
  v : any/c
procedure
(make-proxy matches? connect!) -> proxy?
  matches? : (-> url? boolean?)
  connect! : (-> http-conn? url? (or/c #f ssl-client-context?) void?)
procedure
(make-http-proxy proxy-url [matches?]) -> proxy?
  proxy-url : (or/c bytes? string? url?)
  matches? : (-> url? boolean?)
           = (λ (u) (equal? (url-scheme u) "http"))
procedure
(make-https-proxy proxy-url [matches?]) -> proxy?
  proxy-url : (or/c bytes? string? url?)
  matches? : (-> url? boolean?)
           = (λ (u) (equal? (url-scheme u) "https"))
value
auth-procedure/c
 : (-> url? headers/c query-params/c (values headers/c query-params/c))
procedure
(basic-auth username password) -> auth-procedure/c
  username : (or/c bytes? string?)
  password : (or/c bytes? string?)
procedure
(bearer-auth token) -> auth-procedure/c
  token : (or/c bytes? string?)
value
payload-procedure/c
 : (-> headers/c (values headers/c (or/c bytes? string? input-port?)))
procedure
(form-payload v) -> payload-procedure/c
  v : form-data/c
procedure
(json-payload v) -> payload-procedure/c
  v : jsexpr?
procedure
(gzip-payload p) -> payload-procedure/c
  p : payload-procedure/c
procedure
(pure-payload v) -> payload-procedure/c
  v : (or/c bytes? string? input-port?)
procedure
(part? v) -> boolean?
  v : any/c
procedure
(field-part name value [content-type]) -> part?
  name : (or/c bytes? string?)
  value : (or/c bytes? string?)
  content-type : (or/c bytes? string?) = #"text/plain"
procedure
(file-part name inp [filename content-type]) -> part?
  name : (or/c bytes? string?)
  inp : input-port?
  filename : (or/c bytes? string?) = (~a (object-name inp))
  content-type : (or/c bytes? string?)
               = #"application/octet-stream"
procedure
(multipart-payload  f                         
                    ...                       
                   [#:boundary boundary]) -> payload-procedure/c
  f : part?
  boundary : (or/c bytes? string?) = unsupplied
value
timeout/c : (or/c false/c (and/c real? positive?))
procedure
(timeout-config? v) -> boolean?
  v : any/c
procedure
(make-timeout-config [#:lease lease           
                      #:connect connect       
                      #:request request]) -> timeout-config?
  lease : timeout/c = 5
  connect : timeout/c = 5
  request : timeout/c = 30
procedure
(exn:fail:http-easy? v) -> boolean?
  v : any/c
procedure
(exn:fail:http-easy:timeout? v) -> boolean?
  v : any/c
procedure
(exn:fail:http-easy:timeout-kind e)
 -> (or/c 'lease 'connect 'request)
  e : exn:fail:http-easy:timeout?
parameter
(current-user-agent) -> (or/c bytes? string?)
(current-user-agent user-agent) -> void?
  user-agent : (or/c bytes? string?)
