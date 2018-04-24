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
setlocal foldcolumn=5
setlocal foldnestmax=10
setlocal foldtext=FoldText()
setlocal foldlevelstart=99
setlocal foldlevel=99

" File format
setlocal fileformat=unix
setlocal encoding=utf-8


if executable('gcc')
    compiler gcc
    let current_compiler = "gcc"
    inoremap <buffer> <F5> <ESC>:w <bar> :!gcc -Wall -Wextra -Werror -pedantic % -o %< && ./%< <CR>
    nnoremap <buffer> <F5> :w <bar> :!gcc -Wall -Wextra -Werror -pedantic % -o %< && ./%< <CR>
endif

if filereadable('Makefile*') 
    inoremap <buffer> <F5> <ESC>:w <bar> :make <CR>
    nnoremap <buffer> <F5> :w <bar> :make<CR>
endif

let fname = expand('<afile>:p:h') . '/types.vim'
if filereadable(fname)
    exe 'so ' . fname
endif

" To build cctree.out file:
" Install cscope
" In source dir run cscope -b -k -R
" Shortcuts:
"   <C-\><
"   <C-\>>
"   <C-\>=
"   <C-\>-
if exists('loaded_cctree')

    let g:CCTreeDisplayMode=2
    let g:CCTreeRecursiveDepth=5
    let g:CCTreeUseUTF8Symbols=1

    if filereadable("cscope.out") && !filereadable("cctree.out")
        execute ':CCTreeLoadDB cscope.out'
        execute ':CCTreeSaveXRefDB cctree.out'
        execute ':call delete("cscope.out")'
        echom 'Converted CCTree'
    endif

    if filereadable("cctree.out")
        augroup loadcctree
            autocmd!
            autocmd VimEnter,BufNewFile,BufReadPost *.c,*.h,*.cu,*.cuh,*.cpp,*.hpp :CCTreeLoadXRefDB cctree.out
        augroup END
    endif
endif

