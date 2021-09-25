setlocal fileformat=unix
setlocal encoding=utf-8

" Spacing
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent

" Buffer limits
setlocal nowrap
setlocal nolinebreak
setlocal textwidth=0
setlocal colorcolumn=100

augroup trailspaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

set makeprg=brownie\ compile
