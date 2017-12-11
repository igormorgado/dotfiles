" Line wrap
" setlocal wrap
" setlocal linebreak
setlocal cursorline

" PEP8 rules
setlocal expandtab
setlocal autoindent
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal textwidth=79
setlocal colorcolumn=79
setlocal fileformat=unix
setlocal encoding=utf-8

setlocal foldmethod=expr

" Highlight
let python_hightlight_all = 1

"au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
"au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/
au BufRead,BufNewFile *.py,*.pyw let b:comment_leader = '#'
au BufWritePost *.py make
" highlight BadWhitespace ctermbg=red guibg=red

" Set pylint when saving file
if (executable("pylint"))
    set makeprg=pylint\ --reports=n\ --output-format\ parseable\ %:p
    set errorformat=%f:%l:\ %m
endif

if has("python3")
    nnoremap <buffer> <F5> :py3file %<cr>

    " py from vim import buffers, windows, command, current, error
    " py import vim, sys
    " py from vimpy import 

    " command! PyExecBuffer py exec('\n'.join(current.buffer))
    " nnoremap <F5> :PyExecBuffer<CR>
    " inoremap <F5> <Esc><F5><CR>a

elseif has("python")
    nnoremap <buffer> <F5> :pyfile %<cr>
else
    nnoremap <buffer> <F5> :exec '!python3' % <cr>
endif


noremap <buffer> <F8> :call Autopep8()<CR>
" let g:autopep8_ignore="E501,W293"
" let g:autopep8_select="E501,W293"
let g:autopep8_pep8_passes=100
let g:autopep8_max_line_length=99
let g:autopep8_diff_type='horizontal'

" TODO: Need to change to pyenv instead virtualenv
if has('python3')
python3 << EOF
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

