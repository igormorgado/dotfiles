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

let g:latex_to_unicode_auto=1
let g:julia_indent_align_import=1
let g:julia_indent_align_brackets=1
let g:julia_indent_align_funcargs=1

inoremap <F4> <ESC>:!julia %<CR>i
nnoremap <F4> :!julia %<CR>
