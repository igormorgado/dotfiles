mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
files = tmux.conf tmux/scripts tmux/dark.conf

all: install
clean: cleanup

install:
	@mkdir -p ${HOME}/.tmux
	$(foreach f,$(files),ln -sf $(dir $(mkfile_path))_$(f) ${HOME}/.$(f);)
	@rm -rf ${HOME}/.tmux/plugins
	@mkdir -p ${HOME}/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	~/.tmux/plugins/tpm/bin/install_plugins

cleanup:
	@rm -f  ~/.tmux.conf
	@rm -rf ~/.tmux

