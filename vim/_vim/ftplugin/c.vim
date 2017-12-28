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
    inoremap <buffer> <F5> <ESC>:w <bar> :make <CR>
    nnoremap <buffer> <F5> :w <bar> :make<CR>
else
    inoremap <buffer> <F5> <ESC>:w <bar> :!gcc -Wall -Wextra -Werror -pedantic % -o %< && ./%< <CR>
    nnoremap <buffer> <F5> :w <bar> :!gcc -Wall -Wextra -Werror -pedantic % -o %< && ./%< <CR>
endif


if filereadable('vMakefile.include')
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
    setlocal textwidth=120
    setlocal colorcolumn=79
    if (executable('pmake'))
        let current_compiler = "icc"
        set makeprg=csh\ -c\ 'pmake\ dist'
        inoremap <buffer> <F5> <ESC>:w <bar> :make<CR>i
        nnoremap <buffer> <F5> :w <bar> :make<CR>
        inoremap <buffer> <S-F5> <ESC>:!gdeploy<CR>i
        nnoremap <buffer> <S-F5> :!gdeploy<CR>
    else
        inoremap <buffer> <F5> <ESC>:echom "Environment not set 'pmake' not found"<CR>
        nnoremap <buffer> <F5> :echom "Environment not set 'pmake' not found"<CR> 
    endif
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

" setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
" setlocal foldexpr< foldmethod<

" New cTypes
"syn keyword cType ushort dev_mem pthread_t gpuImagingParams
