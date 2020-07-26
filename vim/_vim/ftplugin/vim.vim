" Tab configuration
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" Wrapping
set nowrap

" Ident
setlocal autoindent
setlocal smartindent
setlocal expandtab
setlocal foldmethod=marker


if has("autocmd")
	" Reload $MYVIMRC when writing it
	augroup reload_vimrc
		autocmd!
		autocmd bufwritepost $MYVIMRC source $MYVIMRC
	augroup END
endif
