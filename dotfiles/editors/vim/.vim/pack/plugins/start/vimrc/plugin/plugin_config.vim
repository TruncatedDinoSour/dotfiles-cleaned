" laTeX config
let g:tex_flavor = 'latex'

" Bar's configuration
let g:lightline = {}
let g:lightline.colorscheme = 'apprentice'      " Set the bar's theme

" Remove bar's background
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle

set noshowmode                                  " Don't show what mode vim is in

" Emmet
let g:user_emmet_install_global = 1

" indentLine
let g:indentLine_char = '·'
let g:indentLine_conceallevel = 1

" CoC
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-pyright',
            \ 'coc-snippets',
            \ 'coc-lua',
            \ 'coc-sh',
            \ ]

" Rainbow parenteces
let g:rainbow_active = 1
let g:rainbow_conf = {
            \ 'ctermfgs': [ 'gray', 'darkgray', 'magenta', 'red' ],
            \ 'contains_prefix': 'TOP',
            \ 'parentheses_options': '',
            \ 'parentheses': ['start=/</ end=/>/ fold', 'start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \ 'separately': {
            \         '*': {},
            \         'markdown': {
            \             'parentheses_options': 'containedin=markdownCode contained',
            \         },
            \         'haskell': {
            \             'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
            \         },
            \         'ocaml': {
            \           'parentheses': ['start=/(\ze[^*]/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\[|/ end=/|\]/ fold', 'start=/{/ end=/}/ fold'],
            \         },
            \         'tex': {
            \             'parentheses_options': 'containedin=texDocZone',
            \             'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \         },
            \         'vim': {
            \             'parentheses_options': 'containedin=vimFuncBody,vimExecute',
            \             'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold'],
            \         },
            \         'lua': {
            \             'parentheses': ["start=/(/ end=/)/", "start=/{/ end=/}/", "start=/\\v\\[\\ze($|[^[])/ end=/\\]/"],
            \         },
            \         'perl': {
            \             'syn_name_prefix': 'perlBlockFoldRainbow',
            \         },
            \         'stylus': {
            \             'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
            \         },
            \         'css': 0,
            \         'sh': 0,
            \         'vimwiki': 0,
            \     }
            \ }

