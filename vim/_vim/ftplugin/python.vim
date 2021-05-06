setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

" File format
setlocal fileformat=unix
setlocal encoding=utf-8

" Columns
setlocal nowrap
setlocal textwidth=92
setlocal colorcolumn=93

let g:slime_dont_ask_default=0
let g:slime_vimterminal_cmd="ipython3 --matplotlib"

nnoremap <F5> :w<CR>:IPythonCellRun<CR>
inoremap <F5> <ESC>:w<CR>:IPythonCellRun<CR>

nnoremap <S-F5> :w<CR>:IPythonCellExecuteCellJump<CR>
inoremap <S-F5> <ESC>:w<CR>:IPythonCellExecuteCellJump<CR>

" map <Leader>s to start IPython
nnoremap <Leader>ps :SlimeSend1 ipython --matplotlib<CR>

nnoremap <Leader>pr :IPythonCellRun<CR>
nnoremap <Leader>pR :IPythonCellRunTime<CR>
nnoremap <Leader>pc :IPythonCellExecuteCell<CR>
nnoremap <Leader>pC :IPythonCellExecuteCellJump<CR>
nnoremap <Leader>pl :IPythonCellClear<CR>
nnoremap <Leader>px :IPythonCellClose<CR>
nnoremap <Leader>p[ :IPythonCellPrevCell<CR>
nnoremap <Leader>p] :IPythonCellNextCell<CR>
nnoremap <Leader>pp :IPythonCellPrevCell<CR>
nnoremap <Leader>pn :IPythonCellNextCell<CR>

"" map [c and ]c to jump to the previous and next cell header
"nnoremap [c :IPythonCellPrevCell<CR>
"nnoremap ]c :IPythonCellNextCell<CR>

" map <Leader>h to send the current line or current selection to IPython
nmap <Leader>ph <Plug>SlimeLineSend
xmap <Leader>ph <Plug>SlimeRegionSend

" map <Leader>Q to restart ipython
nnoremap <Leader>pQ :IPythonCellRestart<CR>

" map <Leader>d to start debug mode
nnoremap <Leader>pd :SlimeSend1 %debug<CR>

" map <Leader>q to exit debug mode or IPython
nnoremap <Leader>pq :SlimeSend1 exit<CR>

iabbrev ipdb import ipdb;ipdb.set_trace()
