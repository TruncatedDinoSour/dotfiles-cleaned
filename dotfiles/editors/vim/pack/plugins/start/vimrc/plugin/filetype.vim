" Enable spellchecking and wrapping in vim
autocmd Filetype markdown,text,xmath,tex set spell wrap
autocmd BufRead,BufNewFile *.LICENSE set spell wrap

" Make emmet work on HTML
" autocmd Filetype html set notimeout timeoutlen=100 ttimeoutlen=100

" Lisp mode for lisp
autocmd Filetype racket,scheme,lisp,clojure set lisp

" Make it not store some undos
autocmd BufWritePre,BufRead,BufNewFile /mnt/*,/tmp/*,/media/* set noundofile undodir=

" Assembly uses nasm
" autocmd Filetype asm set ft=fasm
autocmd BufWritePre,BufRead,BufNewFile *.asm set filetype=fasm

" Set jinja to html
autocmd BufRead,BufNewFile *.j2 set filetype=html

" Make ebuilds highlight properly
autocmd Filetype ebuild set syntax=ebuildspace

" Buildfile
autocmd BufRead,BufNewFile Buildfile set filetype=sh

" Readline
autocmd BufRead,BufNewFile *.rl set filetype=readline
autocmd BufRead,BufNewFile */bindings/* set filetype=readline
