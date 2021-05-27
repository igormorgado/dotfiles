" File format
setlocal fileformat=unix
setlocal encoding=utf-8

" Spacing
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

" Buffer limits
setlocal nowrap
setlocal nolinebreak
setlocal textwidth=0
setlocal colorcolumn=100

augroup trailspaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

if exists('loaded_slime')
    function! SlimeExecuteAndJump()
        call slime#send(getline(".") . "\r")
        call search('^\S', "Wz")
    endfunction

    let g:slime_vimterminal_cmd = "ipython3 --matplotlib"
    let g:slime_python_ipython = 1
    " This makes loading toooo slow
    "let g:slime_dispatch_ipython_pause = 1000
    let g:slime_cell_delimiter = "#%%"
    "let g:slime_cell_delimiter = "# In["
    let g:slime_no_mappings = 1
    nmap <Leader>gv <Plug>SlimeConfig
    xmap <Leader>g <Plug>SlimeRegionSend
    nmap <Leader>g <Plug>SlimeParagraphSend

    nmap <silent> <Leader>gg :call SlimeExecuteAndJump()<cr>
    "nmap <silent> <Leader>gg <plug>SlimeLineSend:call search('^\S')<CR>
    nmap <silent> <Leader>gc <Plug>SlimeSendCell:call search("^" . g:slime_cell_delimiter, "W")<cr>
endif
