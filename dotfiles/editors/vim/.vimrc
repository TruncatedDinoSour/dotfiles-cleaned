scriptencoding utf-8

syntax on						" Turn syntax highlighting on
filetype plugin on              " This makes vim invoke Latex-Suite when you open a tex file.

set noerrorbells				" Turn off error sound
set expandtab					" Will make the tab key insert spaces instead of tabs
set smarttab					" Will make the tab key insert spaces or tabs to go to the next indent
set smartindent autoindent		" Automatically indent files
set number						" Show line count in a file
set nowrap						" Turn word wrapping off
set ignorecase					" Turn case-insensitive searching on
set noswapfile					" Turn swap files off
set nobackup					" Don't back files up after saving the file
set undofile					" Let undo get stored in files
set incsearch					" Show results while searching live
set confirm						" Confirm unsaved changes in files
set lazyredraw                  " Remove macro redraws

set encoding=utf-8                      " File encoding
set laststatus=2                        " Set the bar type
set undodir=~/.vim/undodir		        " Where to put undo files
set tabstop=4							" Maximum tab width
set shiftwidth=4						" Indent size
set softtabstop=0						" Insert spaces instead of tabs
set guicursor=a:hor100                  " Set the cursor shape to a _
set clipboard=unnamedplus               " Copy text to clipboard

" Enable spellchecking and wrapping in vim
autocmd BufReadPost,BufNewFile *.md,*.txt,*.1,*.ms,*.tex,*.latex set spell wrap


" Plugins
" after :PlugInstall, install cmake and run the ~/.vim/plugged/youcompleteme/install.py file and
" then run :YcmRestartServer
call plug#begin("~/.vim/plugged")
    Plug 'AlessandroYorba/Alduin'
    Plug 'valloric/youcompleteme'
    Plug 'tpope/vim-surround'
    Plug 'w0rp/ale'
    Plug 'jiangmiao/auto-pairs'
    Plug 'itchyny/lightline.vim'
    Plug 'vim-latex/vim-latex'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }
call plug#end()


colorscheme alduin                  " Set the theme

" Hide the background
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

" Remap ; -> :
map ; :

" Remap lj -> escape
inoremap lj <Esc>
vnoremap lj <Esc>
xnoremap lj <Esc>
snoremap lj <Esc>
onoremap lj <Esc>


let mapleader = ","                 " , = leader


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


" laTeX config
let g:tex_flavor='latex'

" Bar's configuration
let g:lightline = {}
let g:lightline.colorscheme = 'apprentice'      " Set the bar's theme

" Remove bar's background
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle

set noshowmode                                  " Don't show what mode vim is in

