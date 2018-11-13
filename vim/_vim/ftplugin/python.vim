" Line wrap
setlocal wrap
setlocal linebreak
setlocal cursorline

" PEP8 rules
setlocal expandtab
setlocal autoindent
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal fileformat=unix
setlocal encoding=utf-8

setlocal textwidth=130
setlocal colorcolumn=130

" Highlight
let python_highlight_all = 1

" Indent Python in the Google way.
setlocal foldmethod=expr
setlocal foldlevel=99

"
" GOOGLE PYTHON STYLE
"
setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function! GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"
"
"
" GOOGLE PYTHON STYLE <END>
"


if(executable("ack"))
    setlocal grepprg=ack\ --python
    inoremap <F7> <ESC>:grep *<left><left>
    nnoremap <F7> :grep *<left><left>
    nnoremap gr :grep <cword> *<CR>
    nnoremap Gr :grep <cword> &:p:h/*<CR>
endif


" Set pylint when building file
" if (executable("pylint"))
"     setlocal makeprg=pylint\ --reports=n\ --output-format\ parseable\ %:p
"     setlocal errorformat=%f:%l:\ %m
" endif

" if (executable("flake8"))
"     setlocal makeprg=flake8\ --reports=n\ --output-format\ parseable\ %:p
"     setlocal errorformat=%f:%l:\ %m
" endif

augroup pythonglobal
    autocmd!
    au BufRead,BufNewFile *.py,*.pyw let b:comment_leader = '#'
    " It's pissing me off
    " au BufWritePost *.py make
augroup END

" nnoremap <buffer> <F5> :make<CR>
" inoremap <buffer> <F5> <ESC>:make<CR>

" Execute python code inside vim buffer
" if has("python3")
"     nnoremap <buffer> <F5> :py3file %<cr>
" elseif has("python")
"     nnoremap <buffer> <F5> :pyfile %<cr>
" else
"     nnoremap <buffer> <F5> :exec '!python3' % <cr>
" endif

" <S-F5> Install the software with pip
"if filereadable("setup.py") && executable("pip")
"    nnoremap <buffer> <S-F5> :!pip\ install\ .<CR>
"    inoremap <buffer> <S-F5> <ESC>:!pip\ install\ .<CR>i
"endif

" TODO: Need to change to pyenv instead virtualenv
" if has('python3')
" python3 << EOF
" import os.path
" import sys
" import vim
" if 'VIRTUAL_ENV' in os.environ:
"     project_base_dir = os.environ['VIRTUAL_ENV']
"     sys.path.insert(0, project_base_dir)
"     activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"     execfile(activate_this, dict(__file__=activate_this))
" for p in sys.path:
"     # Add each dir entry in sys.path
"     if os.path.isdir(p):
"         vim.command(r"set path+=%s" % (p.replace(" ",r"\ ")))
" EOF
" endif
" 
" " Load up virtualenv's vimrc if it exists
" if filereadable($VIRTUAL_ENV . '/.vimrc')
"     source $VIRTUAL_ENV/.vimrc
" endif


" Comp confs
setlocal textwidth=130
setlocal colorcolumn=130

" Check the code
" if filereadable('Makefile')
"     inoremap <F5> <ESC>!make\ quick-lint
"     nnoremap <F5> !make\ quick-lint
"     vnoremap <F5> !make\ quick-lint
" endif

if filereadable('development.ini')
    if executable('pshell')
        inoremap <S-F5> <ESC>!pshell\ development.ini
        nnoremap <S-F5> !pshell\ development.ini
        vnoremap <S-F5> !pshell\ development.ini
        inoremap <C-F5> <ESC>!pshell\ development.ini
        nnoremap <C-F5> !pshell\ development.ini
        vnoremap <C-F5> !pshell\ development.ini
    endif
endif


" Nosetest function under the cursor
if executable('nosetests')
    inoremap <F6> <ESC>!nosetests\ <cword>
    nnoremap <F6> !nosetests\ <cword>
    vnoremap <F6> !nosetests\ <cword>
endif
    
" S-F6 run all tests
if filereadable('Makefile')
    if executable('nosetests')
        inoremap <S-F6> <ESC>!make\ quick-test
        nnoremap <S-F6> !make\ quick-test
        vnoremap <S-F6> !make\ quick-test
        inoremap <C-F6> <ESC>!make\ quick-test
        nnoremap <C-F6> !make\ quick-test
        vnoremap <C-F6> !make\ quick-test
    endif
endif
