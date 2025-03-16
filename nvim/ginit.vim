" If is neovim gtk
if exists('g:GtkGuiLoaded')
	call rpcnotify(1, 'Gui', 'Font', 'Fira Code 12')
	let g:GuiInternalClipboard = 1
endif
