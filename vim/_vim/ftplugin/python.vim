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

" Set pylint when building file
if (executable("pylint"))
    setlocal makeprg=pylint\ --reports=n\ --output-format\ parseable\ %:p
    setlocal errorformat=%f:%l:\ %m
endif

augroup pythonglobal
    autocmd!
    au BufRead,BufNewFile *.py,*.pyw let b:comment_leader = '#'
    " Is pissing me off
    " au BufWritePost *.py make
augroup END

nnoremap <buffer> <F5> :make<CR>
inoremap <buffer> <F5> <ESC>:make<CR>i

" Execute python code inside vim buffer
" if has("python3")
"     nnoremap <buffer> <F5> :py3file %<cr>
" elseif has("python")
"     nnoremap <buffer> <F5> :pyfile %<cr>
" else
"     nnoremap <buffer> <F5> :exec '!python3' % <cr>
" endif

" <S-F5> Install the software with pip
if filereadable("setup.py") && executable("pip")
    nnoremap <buffer> <S-F5> :!pip\ install\ .<CR>
    inoremap <buffer> <S-F5> <ESC>:!pip\ install\ .<CR>i
endif

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

