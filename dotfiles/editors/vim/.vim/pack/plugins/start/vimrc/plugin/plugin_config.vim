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

