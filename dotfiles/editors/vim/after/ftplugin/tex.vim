fun! MakeNewLaTeXFile()
    put ='\documentclass{article}'
    put ='\usepackage[left=1cm,right=1cm,top=1cm,bottom=1cm]{geometry}'
    put ='\usepackage{hyperref}'
    put =''
    put ='\hypersetup{'
    put ='  colorlinks   = true,'
    put ='  urlcolor     = blue,'
    put ='  linkcolor    = blue,'
    put ='  citecolor    = red'
    put ='}'
    put =''
    put =''
    put ='\title{}'
    put ='\author{}'
    put ='\date{\today}'
    put =''
    put =''
    put ='\begin{document}'
    put ='\maketitle'
    put ='\tableofcontents'
    put ='\pagebreak{}'
    put =''
    put ='\end{document}'
    put =''
    norm ggdd
endfun

augroup NewTexFile
    autocmd!
    if line('$') == 1 && col('$') == 1
        call MakeNewLaTeXFile()
    endif
augroup END

