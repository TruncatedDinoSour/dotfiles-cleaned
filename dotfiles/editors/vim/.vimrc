" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1


" turn on syntax highlighting
syntax on
" turn off error bells
set noerrorbells
" make the tab width 4
set tabstop=4 softtabstop=4
" shift text
set shiftwidth=4
" convert tabs to spaes
set expandtab
" auto indentation
set smartindent
" line numbers
set nu
" turn text wrapping off
set nowrap
" case searching
set smartcase
" doesn't create vim.swap files
set noswapfile
" doesn't back up
set nobackup
" undo dirs
set undodir=/home/ari/.vim/undodir
set undofile
" while searching get results
set incsearch

" enable plugins
call plug#begin('/home/ari/.vim/plugged')

" gruvbox theme
Plug 'morhetz/gruvbox'
" autocompletion (after install cmake and run the ~/.vim/plugged/youcompleteme/install.py
" and then run :YcmRestartServer)
Plug 'valloric/youcompleteme'
" brackets
Plug 'tpope/vim-surround'
" better json
Plug 'elzr/vim-json'
" errors
Plug 'w0rp/ale'
" auto bracket pairs
Plug 'jiangmiao/auto-pairs'
" fish support
Plug 'dag/vim-fish'

" file explorer
Plug 'preservim/nerdtree'

" nerdtree plugins
" icons
Plug 'ryanoasis/vim-devicons'

" markdown preview
Plug 'iamcco/markdown-preview.vim'

" nice bar
Plug 'itchyny/lightline.vim'

" emmet:)
Plug 'mattn/emmet-vim'

" initialise plgins
call plug#end()

colorscheme gruvbox
set background=dark

let g:vim_be_good_log_file = 1
let g:vim_apm_log = 1

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = ","

" : -> ;
nnoremap ; :
vnoremap ; :
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

" set the bar
set laststatus=2

" set encoding
set encoding=utf-8

" bar's config
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'

