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

" Navigate splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Map D to redo
nnoremap D :redo<CR>

" Snippets
imap <expr> <C-s>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-s>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

