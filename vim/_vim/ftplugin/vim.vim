" File format
setlocal fileformat=unix
setlocal encoding=utf-8

" Spacing
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

" Buffer limits
setlocal nowrap
setlocal nolinebreak
setlocal textwidth=0
setlocal colorcolumn=80

" Folding
setlocal foldmethod=marker


if has("autocmd")
	" Reload $MYVIMRC when writing it
	augroup reload_vimrc
		autocmd!
		autocmd bufwritepost $MYVIMRC source $MYVIMRC
	augroup END
endif
