" Remap ; -> :
map ; :

" Remap lj -> escape
nnoremap lj <Esc>

" h, l <=> b, w
noremap h b
noremap l w
noremap b h
noremap w l

" Disable arrows keys
for key in ['<Up>', '<Down>', '<Left>',
            \ '<Right>', '<PageUp>', '<PageDown>',
            \ 'gh', 'gj', 'gk', 'gl']
    exec 'nnoremap'        key '<Nop>'
endfor

let mapleader = ","                 " , = leader

" Navigate splits (supplied by tmux plugin)
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

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
nnoremap F :FormatCode<CR>

" Trim whitespace
nnoremap T :call TrimWhitespace()<CR>

" Tabs
nnoremap <C-n> <ESC>:tabnew<space>
nnoremap <C-b> <ESC>:tabprevious<CR>
nnoremap <C-c> <ESC>:tabnext<CR>

" Open a file
nnoremap <C-o> <ESC>:open<space>

" Splits
nnoremap <C-s> <ESC>:vsplit<space>
nnoremap <C-d> <ESC>:split<space>

" Tabular
nnoremap U <ESC>:Tabularize<space>

