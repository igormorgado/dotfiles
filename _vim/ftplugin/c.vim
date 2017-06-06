" Line wrap
setlocal nowrap
setlocal linebreak
setlocal textwidth=79
setlocal colorcolumn=79
setlocal cursorline

" Ident
setlocal autoindent
setlocal cindent
setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

" Fold
setlocal foldmethod=syntax
setlocal foldnestmax=10
setlocal foldlevel=4

" File format
setlocal fileformat=unix
setlocal encoding=utf-8


augroup filetype_c
	autocmd!
    au BufWinEnter *.c compiler gcc
    au BufWinEnter *.c imap <buffer> <F5> <ESC>:w <bar> :make <CR>:!./a.out<CR> 
    au BufWinEnter *.c nmap <buffer> <F5> :w <bar> :make<CR>:!./a.out<CR>
    au BufWinLeave *.c unnmap <buffer> <F5>
    au BufWinLeave *.c unimap <buffer> <F5>
	" autocmd BufWinEnter *.c setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
	" autocmd BufWinLeave *.c setlocal foldexpr< foldmethod<
augroup END

" Compiling
setlocal makeprg=gcc\ %\ &&\ ./a.out
" setlocal makeprg=gcc\ %

