mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
vimfiles = ctags
vimfiledir = vimrc after ftplugin spell syntax ftdetect indent

all: vim
clean: vimclean 

vim:
	@mkdir -p ${HOME}/.vim
	@mkdir -p ${HOME}/.tmp/vim/gutentags
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	$(foreach f,$(vimfiles),ln -sf $(dir $(mkfile_path))_$(f) ${HOME}/.$(f);)
	$(foreach f,$(vimfiledir),ln -sf $(dir $(mkfile_path))_vim/$(f) ${HOME}/.vim/$(f);)
	$(foreach f,$(rcdfiles),ln -sf $(dir $(mkfile_path))_bashrc.d/$(f) ${HOME}/.bashrc.d/$(f);)

	vim +PlugInst +qall

vimclean:
	@rm -f ${HOME}/.vimrc
	@rm -f ${HOME}/.ctags
	@rm -rf ${HOME}/.vim

