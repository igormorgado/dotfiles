" 
filetype indent on

" Line wrap
setlocal nowrap
setlocal nolinebreak
setlocal tw=79
setlocal colorcolumn=79
setlocal cursorline

" Ident
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

" File format
setlocal fileformat=unix
setlocal encoding=utf-8

setlocal iskeyword+=:
setlocal grepprg=grep\ -nH\ $*

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_dvi = 'latex -interaction=nonstopmode -src-specials $*'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:Tex_MultipleCompileFormats = 'pdf'

setlocal makeprg=pdflatex\ %

" augroup latexsave
"     au BufWritePost * :silent make | redraw!
" augroup END

