" Trim trailing white-space in files
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup whitespace_trim
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END


" Update CoC and VimPlug
function! s:PackUpdate()
    CocUpdate
    PlugUpdate
    PlugUpgrade
endfunction

com! PackUpdate call s:PackUpdate()


" Show diff in a better way
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

com! Diff call s:DiffWithSaved()
cabbrev diff Diff


" Open the terminal
function! OpenTerminal()
    setlocal splitbelow
    terminal
    resize 14
    setlocal nosplitbelow
endfunction

nnoremap <C-t> :call OpenTerminal()<CR>
tnoremap <C-t> <C-\><C-n>:buf<CR><C-W><C-K>
tnoremap <C-y> <C-\><C-n>:resize +1<CR>i
tnoremap <C-u> <C-\><C-n>:resize -1<CR>i


" Format python
function! FormatPythonCode()
    FormatCode black
    FormatCode isort
endfun

autocmd! filetype python map F :call FormatPythonCode()<CR>

" Convert to spaces
autocmd! bufreadpost * set expandtab | retab!
autocmd! bufwritepre * set expandtab | retab!

