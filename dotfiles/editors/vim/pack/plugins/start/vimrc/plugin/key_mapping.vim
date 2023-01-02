" Remap ; -> :
map ; :

" Remap lj -> escape
noremap lj <Esc>

" h, l <=> b, w
noremap h b
noremap l w
noremap b h
noremap w l

" Disable arrows keys
for key in ['<Up>', '<Down>', '<Left>',
            \ '<Right>', '<PageUp>', '<PageDown>',
            \ 'gh', 'gj', 'gk', 'gl']
    exec 'noremap'        key '<Nop>'
endfor

let mapleader = ","                 " , = leader

" Navigate splits (supplied by tmux plugin)
"noremap <C-J> <C-W><C-J>
"noremap <C-K> <C-W><C-K>
"noremap <C-L> <C-W><C-L>
"noremap <C-H> <C-W><C-H>

" Map D to redo
noremap D :redo<CR>

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
noremap F :FormatCode<CR>

" Trim whitespace
noremap T :call TrimWhitespace()<CR>

" Tabs
noremap <C-n> <ESC>:tabnew<space>
noremap <C-x> <ESC>:tabprevious<CR>
noremap <C-c> <ESC>:tabnext<CR>

" Open a file
noremap <C-o> <ESC>:open<space>

" Splits
noremap <C-s> <ESC>:vsplit<space>
noremap <C-d> <ESC>:split<space>

" Tabular
noremap U <ESC>:Tabularize<space>

" Inc/decrement
noremap X <C-a>
noremap Z <C-x>

" (Un)indent

" >>   Indent line by shiftwidth spaces
" <<   De-indent line by shiftwidth spaces
" 5>>  Indent 5 lines
" 5==  Re-indent 5 lines
"
" >%   Increase indent of a braced or bracketed block (place cursor on brace first)
" =%   Reindent a braced or bracketed block (cursor on brace)
" <%   Decrease indent of a braced or bracketed block (cursor on brace)
" ]p   Paste text, aligning indentation with surroundings
"
" =i{  Re-indent the 'inner block', i.e. the contents of the block
" =a{  Re-indent 'a block', i.e. block and containing braces
" =2a{ Re-indent '2 blocks', i.e. this block and containing block
"
" >i{  Increase inner block indent
" <i{  Decrease inner block indent

noremap > >>
noremap < <<
noremap = ==

noremap [ >i
noremap ] <i
noremap ) =i

" Comments

noremap <C-m> :Commentary<CR>
