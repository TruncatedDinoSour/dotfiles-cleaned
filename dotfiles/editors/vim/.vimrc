scriptencoding utf-8

syntax on                       " Turn syntax highlighting on
filetype plugin on              " This makes vim invoke Latex-Suite when you open a tex file.

set nocompatible                " No need for VI
set noerrorbells                " Turn off error sound
set expandtab smarttab          " Will make the tab key insert spaces instead of tabs
set smartindent autoindent      " Automatically indent files
set number relativenumber       " Show line count in a file (dynamic)
set nowrap                      " Turn word wrapping off
set ignorecase                  " Turn case-insensitive searching on
set noswapfile                  " Turn swap files off
set nobackup                    " Don't back files up after saving the file
set undofile                    " Let undo get stored in files
set incsearch                   " Show results while searching live
set confirm                     " Confirm unsaved changes in files
set lazyredraw                  " Remove macro redraws
set autochdir                   " automatically enter a directory if a file is opened
set cursorline                  " Highlight the current line number
set splitright                  " split the terminal to below and split files to right
set timeout                     " let timeout happen

set encoding=utf-8                      " File encoding
set laststatus=2                        " Set the bar type
set undodir=~/.vim/undodir              " Where to put undo files
set tabstop=4                           " Maximum tab width
set shiftwidth=4                        " Indent size
set softtabstop=0                       " Insert spaces instead of tabs
set guicursor=a:hor100                  " Set the cursor shape to a _
set clipboard=unnamedplus               " Copy text to clipboard
set timeoutlen=0 ttimeoutlen=0          " Set timeout to 0s
set virtualedit=all                     " Improve visual block to select past the line

set list listchars=trail:~,extends:»,precedes:«,nbsp:×   " Show indentation


" Enable spellchecking and wrapping in vim
autocmd Filetype markdown,text,xmath,tex set spell wrap

" Make emmet work on HTML
autocmd Filetype html set notimeout timeoutlen=100 ttimeoutlen=100

" Porth
autocmd BufRead,BufNewFile *.porth set filetype=porth

" Make it not store some undos
autocmd BufWritePre,BufRead,BufNewFile /mnt/* set noundofile undodir=


" Plugins
"   To Install the plugins type `:PlugInstall`
" CoC:
"   $ cd ~/.vim/plugged/coc.nvim
"   $ npm install
" Bracey:
"   $ cd ~/.vim/pluggled/bracey
"   $ npm install --prefix server

call plug#begin("~/.vim/plugged")
    Plug 'turbio/bracey.vim'
    Plug 'mattn/emmet-vim'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'AlessandroYorba/Alduin'
    Plug 'tpope/vim-surround'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'w0rp/ale'
    Plug 'jiangmiao/auto-pairs'
    Plug 'itchyny/lightline.vim'
    Plug 'vim-latex/vim-latex'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }
    Plug 'google/vim-maktaba'
    Plug 'google/vim-codefmt'
    Plug 'google/vim-glaive'
    Plug 'Yggdroot/indentLine'
    Plug 'drmingdrmer/vim-tabbar'
    Plug 'lilydjwg/colorizer'
    Plug 'editorconfig/editorconfig-vim'
call plug#end()

call glaive#Install()               " Install glave


colorscheme alduin                  " Set the theme

