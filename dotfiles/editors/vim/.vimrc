" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

syntax on                           " Turn syntax highlighting on
set noerrorbells                    " Turn off error bells
set tabstop=4 softtabstop=4         " Make the tab 4 of the whitespace selected
set shiftwidth=4                    " Shift text
set expandtab                       " Convert tabs to spaces
set smartindent                     " Automatically indent files
set number
"set relativenumber                  " Relatively show the line number
set nowrap                          " Turn text wrapping off
set smartcase                       " Turn on searching
set noswapfile                      " Turn off vim swap files
set nobackup                        " Don't backup files when saving
set undodir=~/.vim/undodir          " Specify the undo directory
set undofile                        " Let undo happen in files
set incsearch                       " Show results while searching live
set laststatus=2                    " Set the bar mode
set encoding=utf-8                  " Set the encoding
set ignorecase                      " Ignore case in searches
set smarttab                        " Enable smart tabs
set confirm                         " Show confirmation

set nocompatible
filetype off


" after :PlugInstall, install cmake and run the ~/.vim/plugged/youcompleteme/install.py file and
" then run :YcmRestartServer

call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
    Plug 'valloric/youcompleteme'
    Plug 'tpope/vim-surround'
    Plug 'w0rp/ale'
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'iamcco/markdown-preview.vim'
    Plug 'itchyny/lightline.vim'
call plug#end()


" Turn background off
hi Normal guibg=NONE ctermbg=NONE
colorscheme gruvbox                 " Set the theme
set background=dark                 " Set theme mode to dark


let g:vim_be_good_log_file = 1
let g:vim_apm_log = 1

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = ","                 " , = leader


" ; -> :
nnoremap ; :
vnoremap ; :
" : -> ;
nnoremap : ;
vnoremap : ;


" nerdtree shortcuts
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup ari
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END


" close nerdtree if it's the only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" bar's config
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox' " Set the bar's theme
set noshowmode                          " Don't show what mode vim is in

" jj = escape
inoremap jj <Esc>
vnoremap jj <Esc>
nnoremap jj <Esc>

