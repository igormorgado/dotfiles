" 
filetype indent on

let g:tex_flavor='latex'

" Line wrap
setlocal nowrap
setlocal nolinebreak
setlocal textwidth=0
setlocal colorcolumn=79
setlocal cursorline

" Ident
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

" File format
setlocal fileformat=unix
setlocal encoding=utf-8

setlocal iskeyword+=:
setlocal grepprg=grep\ -nH\ $*
setlocal makeprg=pdflatex\ %
augroup latexsave
    au BufWritePost * :silent make | redraw!
augroup END

