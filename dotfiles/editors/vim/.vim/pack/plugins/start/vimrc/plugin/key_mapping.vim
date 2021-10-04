" Remap ; -> :
map ; :

" Remap lj -> escape
map lj <Esc>
inoremap lj <Esc>

" h, l <=> b, w
nnoremap h b
nnoremap l w
nnoremap b h
nnoremap w l

" Disable arrows keys because I keep using them :(
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
  exec 'map'        key '<Nop>'
  exec 'inoremap'   key '<Nop>'
endfor

let mapleader = ","                 " , = leader

