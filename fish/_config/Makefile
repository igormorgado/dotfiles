mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

files = _config/fish/config.fish \
	_config/fish/functions/fish_prompt.fish


all: install
clean: cleanup

install:
	$(foreach f,$(files),echo $(patsubst _%,.%,$(f)) ;)
	# @mkdir -p $DSTDIR
	# $(foreach f,$(files),ln -sf $(dir $(mkfile_path))_$(f) ${/.$(f);)
	# $(foreach f,$(filesdir),ln -sf $(dir $(mkfile_path))_vim/$(f) ${HOME}/.vim/$(f);)


cleanup:
	# @rm -f ${HOME}/.vimrc
	# @rm -f ${HOME}/.ctags
	# @rm -rf ${HOME}/.vim

