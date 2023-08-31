" enable spellchecking and wrapping in vim
autocmd Filetype markdown,text,xmath,tex set spell wrap
autocmd BufRead,BufNewFile *.LICENSE set spell wrap

" make emmet work on HTML
" autocmd Filetype html set notimeout timeoutlen=100 ttimeoutlen=100

" lisp mode for lisp
autocmd Filetype racket,scheme,lisp,clojure set lisp

" make it not store some undos
autocmd BufWritePre,BufRead,BufNewFile /mnt/*,/tmp/*,/media/* set noundofile undodir=

" assembly uses nasm
" autocmd Filetype asm set ft=fasm
autocmd BufWritePre,BufRead,BufNewFile *.s,*.asm set filetype=fasm

" set jinja to html
autocmd BufRead,BufNewFile *.j2 set filetype=html

" make ebuilds highlight properly
autocmd Filetype ebuild set syntax=ebuildspace

" buildfile
autocmd BufRead,BufNewFile Buildfile set filetype=sh

" readline
autocmd BufRead,BufNewFile *.rl set filetype=readline
autocmd BufRead,BufNewFile */bindings/* set filetype=readline

" index files for https://etc.ari-web.xyz/
autocmd BufRead,BufNewFile _index.txt set filetype=html

" K language
autocmd BufRead,BufNewFile *.k source /usr/share/vim/vimfiles/syntax/k.vim

" C headers
autocmd BufRead,BufWritePre,BufNewFile *.h set filetype=c

" Enter
autocmd VimEnter * echo 'welcome back,' $USER
