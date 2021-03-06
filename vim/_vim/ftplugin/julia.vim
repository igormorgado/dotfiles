" Configure default tab to 4 spaces
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

" File format
setlocal fileformat=unix
setlocal encoding=utf-8

runtime macros/matchit.vim

setlocal autoindent
setlocal smartindent

setlocal nowrap
setlocal textwidth=92
setlocal colorcolumn=93

" Julia Vim configs
let g:latex_to_unicode_auto=1
let g:julia_indent_align_import=1
let g:julia_indent_align_brackets=1
let g:julia_indent_align_funcargs=1

" Julia-cell configs
let g:slime_dont_ask_default=0
let g:slime_vimterminal_cmd="julia"

nnoremap <F5> :w<CR>:JuliaCellRun<CR>
inoremap <F5> <ESC>:w<CR>:JuliaCellRun<CR>

nnoremap <S-F5> :w<CR>:JuliaCellExecuteCellJump<CR>
inoremap <S-F5> <ESC>:w<CR>:JuliaCellExecuteCellJump<CR>

nnoremap <Leader>jr :JuliaCellRun<CR>
nnoremap <Leader>jc :JuliaCellExecuteCell<CR>
nnoremap <Leader>jC :JuliaCellExecuteCellJump<CR>
nnoremap <Leader>jl :JuliaCellClear<CR>
nnoremap <Leader>jp :JuliaCellPrevCell<CR>
nnoremap <Leader>jn :JuliaCellNextCell<CR>
nnoremap <Leader>j[ :JuliaCellPrevCell<CR>
nnoremap <Leader>j] :JuliaCellNextCell<CR>
