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
set autochdir                   " Automatically enter a directory if a file is opened
set cursorline                  " Highlight the current line number
set splitright                  " Split the terminal to below and split files to right
set timeout                     " Let timeout happen
set noeol

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
set backspace=0                         " Disable backspace
set t_Co=256                            " Show 256 colours

set list listchars=trail:~,extends:»,precedes:«,nbsp:×   " Show indentation


" Enable spellchecking and wrapping in vim
autocmd Filetype markdown,text,xmath,tex set spell wrap
autocmd BufRead,BufNewFile *.LICENSE set spell wrap

" Make emmet work on HTML
" autocmd Filetype html set notimeout timeoutlen=100 ttimeoutlen=100

" Lisp mode for lisp
autocmd Filetype racket,scheme,lisp,clojure set lisp

" Porth
autocmd BufRead,BufNewFile *.porth set filetype=porth

" Make it not store some undos
autocmd BufWritePre,BufRead,BufNewFile /mnt/*,/tmp/*,/media/* set noundofile undodir=

" Assembly uses nasm
autocmd Filetype asm set ft=nasm

" Set jinja to html
autocmd BufRead,BufNewFile *.j2 set filetype=html

" Make ebuilds highlight properly
autocmd Filetype ebuild set syntax=ebuildspace

" Rys
autocmd BufRead,BufNewFile *.rys set filetype=rys

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
    Plug 'tpope/vim-surround'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'w0rp/ale'
    Plug 'coffee-theme/lightline.vim'
    Plug 'vim-latex/vim-latex'
    " Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }
    Plug 'JamshedVesuna/vim-markdown-preview'
    Plug 'google/vim-maktaba'
    Plug 'TruncatedDinosour/vim-codefmt'
    Plug 'Yggdroot/indentLine'
    Plug 'drmingdrmer/vim-tabbar'
    Plug 'lilydjwg/colorizer'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'wlangstroth/vim-racket'
    Plug 'tpope/vim-surround'
    Plug 'luochen1990/rainbow'
    Plug 'MicahElliott/vrod'
    Plug 'kovisoft/slimv'
    Plug 'tpope/vim-markdown'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'coffee-theme/coffee.vim'
call plug#end()


colorscheme coffee                      " Set the theme


" Plugin config
source ~/.vim/pack/plugins/start/vimrc/plugin/plugin_config.vim
