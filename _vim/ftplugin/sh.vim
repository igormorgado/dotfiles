" Line wrap
setlocal wrap
setlocal linebreak
setlocal textwidth=79
setlocal colorcolumn=79
setlocal cursorline

" Ident
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

" File format
setlocal fileformat=unix
setlocal encoding=utf-8

set makeprg=shellcheck\ -f\ gcc\ %
augroup shellsave
    au BufWritePost * :silent make | redraw!
augroup END
