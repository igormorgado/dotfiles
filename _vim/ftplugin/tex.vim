" Line wrap
setlocal nowrap
setlocal nolinebreak
setlocal textwidth=0
setlocal colorcolumn=79
setlocal cursorline

" Ident
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

" File format
setlocal fileformat=unix
setlocal encoding=utf-8

set makeprg=pdflatex\ %
augroup latexsave
    au BufWritePost * :silent make | redraw!
augroup END
