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
    au BufWinEnter *.c imap <buffer> <F5> <ESC>:w <bar> :make <CR>
    au BufWinEnter *.c nmap <buffer> <F5> :w <bar> :make<CR>
    au BufWinLeave *.c nunmap <buffer> <F5>
    au BufWinLeave *.c iunmap <buffer> <F5>

	" load the types.vim highlighting file, if it exists
	autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
	autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
	autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
	autocmd BufRead,BufNewFile *.[ch] endif


	" autocmd BufWinEnter *.c setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
	" autocmd BufWinLeave *.c setlocal foldexpr< foldmethod<
augroup END

