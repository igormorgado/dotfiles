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
setlocal colorcolumn=80


if exists('g:loaded_slime' )
    function! SlimeExecuteAndJump()
        call slime#send(getline(".") . "\r")
        call search('^.*\S', "Wz")
    endfunction

    let g:slime_vimterminal_cmd = "bash"
    let g:slime_no_mappings = 1
    nmap <Leader>gv <Plug>SlimeConfig
    xmap <Leader>g <Plug>SlimeRegionSend
    nmap <Leader>g <Plug>SlimeParagraphSend
    nmap <silent> <Leader>gg :call SlimeExecuteAndJump()<cr>
endif

if executable('shellcheck')
    setlocal makeprg=shellcheck\ -f\ gcc\ %
endif

augroup trailspaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

" How to not execute in /tmp/* files?
" augroup shellsave
"     autocmd!
"     au BufWritePost * :silent make | redraw!
" augroup END
