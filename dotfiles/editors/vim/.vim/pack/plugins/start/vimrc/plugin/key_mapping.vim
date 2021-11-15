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
inoremap <silent><expr> <C-j>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" vim-codefmt
map F :FormatCode<CR>

" Tabs
map <C-n> <ESC>:tabnew<space>
inoremap <C-t> <ESC>:tabnew<space>

map <C-b> <ESC>:tabprevious<CR>
inoremap <C-t> <ESC>:tabprevious<CR>

" Open a file
map <C-o> <ESC>:open<space>
inoremap <C-o> <ESC>:open<space>

" Splits
map <C-s> <ESC>:vsplit<space>
inoremap <C-s> <ESC>:vsplit<space>
map <C-a> <ESC>:split<space>
inoremap <C-a> <ESC>:split<space>

