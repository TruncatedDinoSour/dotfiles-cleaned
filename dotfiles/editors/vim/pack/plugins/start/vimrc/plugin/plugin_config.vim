" laTeX config
let g:tex_flavor = 'latex'

" Lightline
let g:lightline = {
            \ 'colorscheme': 'coffee',
            \ 'active': {
            \     'left': [ [ 'mode', 'paste' ],
            \               [ 'readonly', 'filename', 'buddy', 'modified' ] ],
            \ 'right':    [ [ 'lineinfo' ],
            \               [ 'percent' ],
            \               [ 'linter', 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'inactive': {
            \     'left':   [ [ 'filename', 'buddy' ] ],
            \     'right':  [ [ 'lineinfo' ],
            \                 [ 'percent' ] ]
            \ },
            \ 'component_function': {
            \     'linter': 'LightlineLinterStatus',
            \     'buddy': 'VimBuddy'
            \ }
            \ }

"let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
"let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
"let s:palette.inactive.middle = s:palette.normal.middle
"let s:palette.tabline.middle = s:palette.normal.middle

set noshowmode                                  " Don't show what mode vim is in

" Emmet
let g:user_emmet_install_global = 1

" indentLine
let g:indentLine_char = '·'
let g:indentLine_conceallevel = 1

" CoC
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-snippets',
            \ 'coc-lua',
            \ 'coc-sh',
            \ 'coc-css',
            \ 'coc-html',
            \ 'coc-tsserver',
            \ 'coc-docker',
            \ 'coc-vimlsp'
            \ ]

" ALE
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
            \ 'python': ['flake8', 'pytype', 'mypy']
            \ }

function! LightlineLinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

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

" Markdown
let g:markdown_fenced_languages = [
            \ 'html', 'python', 'py=python',
            \ 'css', 'javascript', 'sh', 'bash=sh',
            \ 'python3=python', 'py3=python',
            \ 'vim', 'vi=vim', 'r',
            \ 'R=r', 'scheme', 'scm=scheme', 'c',
            \ 'cpp', 'asm=nasm', 'nasm',
            \ 'assembly=nasm', 'lua'
            \ ]
let g:markdown_syntax_conceal = 0

" FixEOL
let g:PreserveNoEOL_Function = function('PreserveNoEOL#Python#Preserve')
let g:PreserveNoEOL = 1

" Highlightedyank
let g:highlightedyank_highlight_duration = 500
highlight HighlightedyankRegion cterm=reverse gui=reverse

