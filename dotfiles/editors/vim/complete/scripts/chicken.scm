#!/usr/bin/csi -script

(import apropos regex (chicken sort))

(call-with-output-file "scheme-word-list"
  (lambda (port)
    (for-each (lambda (x) (display x port) (newline port))
              (sort (apropos-list (regexp ".*") #:macros? #t)
                    (lambda (a b)
                      (string<? (symbol->string a)
                                (symbol->string b)))))))
