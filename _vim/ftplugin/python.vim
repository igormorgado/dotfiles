colorscheme lanox

" Line wrap
setlocal wrap
setlocal linebreak
setlocal textwidth=79
setlocal colorcolumn=79
setlocal cursorline

" Ident
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

" File format
setlocal fileformat=unix
setlocal encoding=utf-8

" Highlight
let python_hightlight_all = 1

" Folding
"setlocal foldmethod=expr
let g:SimpylFold_fold_import = 1
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0

augroup filetype_python
	autocmd!
	autocmd BufWinEnter *.py setlocal foldmethod=expr
	autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
augroup END


nnoremap <buffer> <F7> :call Autopep8()<CR>

if has('python')
python << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
for p in sys.path:
    # Add each dir entry in sys.path
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ",r"\ ")))
EOF
endif

" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif

