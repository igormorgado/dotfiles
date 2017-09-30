mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
tmuxfiles = tmux.conf tmux/scripts tmux/dark.conf tmux/light.conf
rcdfiles = 050-tmux

all: tmux
clean: tmuxclean

tmux:
	@mkdir -p ${HOME}/.bashrc.d
	@mkdir -p ${HOME}/.tmux
	$(foreach f,$(tmuxfiles),ln -sf $(dir $(mkfile_path))_$(f) ${HOME}/.$(f);)
	$(foreach f,$(rcdfiles),ln -sf $(dir $(mkfile_path))_bashrc.d/$(f) ${HOME}/.bashrc.d/$(f);)
	@rm -rf ${HOME}/.tmux/plugins
	@mkdir -p ${HOME}/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	~/.tmux/plugins/tpm/bin/install_plugins

tmuxclean:
	@rm -rf ~/.tmux/plugins
	@rm -f  ~/.tmux.conf
	@rm -f  ~/.tmux
	@rm -f  ~/.bashrc.d/050-tmux

