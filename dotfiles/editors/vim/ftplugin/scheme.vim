let b:is_chicken=1

if exists("b:is_chicken") || exists("is_chicken")
    nmap <silent> == :call Scheme_indent_top_sexp()<cr>

    syn match schemeChar oneline "#\\return"
    syn match schemeChar oneline "#!eof"

    " multiline comment
    syntax region schemeMultilineComment start=/#|/ end=/|#/ contains=schemeMultilineComment
    syn region schemeSexpComment start="#;(" end=")" contains=schemeComment,schemeTempStruc
    hi def link schemeSexpComment Comment

    syn match schemeOther oneline "##[-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    syn match schemeExtSyntax oneline "#:[-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"

    " suggested by Alex Queiroz
    syn match schemeExtSyntax oneline "#![-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    syn region schemeString start=+#<#\s*\z(.*\)+ end=+^\z1$+

    syn match schemeShebang "^#!/.*csi.*$"
    hi def link schemeShebang Comment

    " Completion
    setl complete+=,k~/.vim/complete/chicken

    " Indentation
    setl lispwords+=let-values,condition-case,with-input-from-string
    setl lispwords+=with-output-to-string,handle-exceptions,call/cc,rec,receive
    setl lispwords+=call-with-output-file
endif

" Indent a toplevel sexp.
fun! Scheme_indent_top_sexp()
    let pos = getpos('.')
    silent! exec "normal! 99[(=%"
    call setpos('.', pos)
endfun
