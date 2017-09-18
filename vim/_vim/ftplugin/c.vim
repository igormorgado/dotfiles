" Line wrap
setlocal nocompatible
setlocal nowrap
setlocal textwidth=79
setlocal colorcolumn=79
setlocal cursorline

" Ident
setlocal autoindent
setlocal smartindent
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal showmatch

" Fold
setlocal foldmethod=syntax
setlocal foldnestmax=10
setlocal foldlevel=4

" File format
setlocal fileformat=unix
setlocal encoding=utf-8

compiler gcc
if filereadable('Makefile')
    imap <buffer> <F5> <ESC>:w <bar> :make <CR>
    nmap <buffer> <F5> :w <bar> :make<CR>
else
    imap <buffer> <F5> <ESC>:w <bar> :!gcc -Wall -Wextra -Werror -pedantic % -o %< && ./%< <CR>
    nmap <buffer> <F5> :w <bar> :!gcc -Wall -Wextra -Werror -pedantic % -o %< && ./%< <CR>
endif

let fname = expand('<afile>:p:h') . '/types.vim'
if filereadable(fname)
  exe 'so ' . fname
endif

" setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
" setlocal foldexpr< foldmethod<

