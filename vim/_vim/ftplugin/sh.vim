" Line wrap
setlocal nowrap
setlocal nolinebreak
setlocal textwidth=0
setlocal colorcolumn=79

" Ident
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

" File format
setlocal fileformat=unix
setlocal encoding=utf-8

if executable('shellcheck')
    set makeprg=shellcheck\ -f\ gcc\ %
endif

"augroup shellsave
"    au BufWritePost * :silent make | redraw!
"augroup END
