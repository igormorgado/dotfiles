" Line wrapping standard for coding
setlocal nowrap
setlocal textwidth=79
setlocal colorcolumn=79

" Configure default tab to 4 spaces
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

" File format
setlocal fileformat=unix
setlocal encoding=utf-8

" Show invisible chars
setlocal list

"Indent C-indenting
setlocal autoindent
setlocal smartindent
setlocal cindent
setlocal showmatch
setlocal smarttab

" Trailing characters are marked as errors
match errorMsg /\s\+$/

" always display sign columns
setlocal signcolumn=yes

" Fold
setlocal foldmethod=syntax
setlocal foldcolumn=1
setlocal foldlevelstart=99
setlocal foldlevel=99

" Completion
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone,preview


nnoremap <Leader>oc :e %<.c<CR>
nnoremap <Leader>oC :e %<.cpp<CR>
nnoremap <Leader>oh :e %<.h<CR>

" GDB stuff
packadd termdebug
let g:termdebug_popup = 1
let g:termdebug_wide = 1

" Where 'where'  is any gdb command
" map ,w :call TermDebugSendCommand('where')<CR>
" Try this approach and create some nice vim functions.

" Make
inoremap <F4> <ESC>:make<CR>i
nnoremap <F4> :make<CR>

" Run debug
inoremap <F5> <ESC>:Termdebug %:r<CR>:Source<CR>:Break<CR>:Run<CR>i
nnoremap <F5> :Termdebug %:r<CR>:Source<CR>:Break<CR>:Run<CR>

" Insert Breakpoint
inoremap <F9> <ESC>:Break<CR>i
nnoremap <F9> :Break<CR>

" Step over / Next
inoremap <F10> <ESC>:Over<CR>i
nnoremap <F10>      :Over<CR>
"
" Step into
inoremap <F11> <ESC>:Step<CR>i
nnoremap <F11>      :Step<CR>

if (filereadable("Makefile") || filereadable("makefile"))
    setlocal makeprg=make
elseif filereadable("meson.build")
    setlocal makeprg=meson\ compile\ -C\ build
else
    setlocal makeprg=gcc\ -o\ a.out\ %
endif

augroup trailspaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END


" inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"   \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


"let fname = expand('<afile>:p:h') . '/types.vim'
"if filereadable(fname)
"    exe 'so ' . fname
"endif

" Using gtags-scope with guttentags for now, lets check
" " To build cctree.out file:
" " Install cscope
" " In source dir run cscope -b -k -R
" " Shortcuts:
" "   <C-\><
" "   <C-\>>
" "   <C-\>=
" "   <C-\>-
" if exists('loaded_cctree')
"
"     let g:CCTreeDisplayMode=2
"     let g:CCTreeRecursiveDepth=5
"     let g:CCTreeUseUTF8Symbols=1
"
"     if filereadable("cscope.out") && !filereadable("cctree.out")
"         execute ':CCTreeLoadDB cscope.out'
"         execute ':CCTreeSaveXRefDB cctree.out'
"         execute ':call delete("cscope.out")'
"         echom 'Converted CCTree'
"     endif
"
"     if filereadable("cctree.out")
"         augroup loadcctree
"             autocmd!
"             autocmd VimEnter,BufNewFile,BufReadPost *.c,*.h,*.cu,*.cuh,*.cpp,*.hpp :CCTreeLoadXRefDB cctree.out
"         augroup END
"     endif
" endif

