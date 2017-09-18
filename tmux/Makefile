mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
tmuxfiles = tmux.conf tmux
rcdfiles = 050-tmux

all: tmux
clean: tmuxclean

tmux:
	@mkdir -p ${HOME}/.bashrc.d/
	$(foreach f,$(tmuxfiles),ln -sf $(dir $(mkfile_path))_$(f) ${HOME}/.$(f);)
	$(foreach f,$(rcdfiles),ln -sf $(dir $(mkfile_path))_bashrc.d/$(f) ${HOME}/.bashrc.d/$(f);)
	/usr/share/tmux-plugin-manager/bin/install_plugins

tmuxclean:
	@rm -f ${HOME}/.tmux.conf
	@rm -f ${HOME}/.tmux
	@rm -f ${HOME}/.bashrc.d/050-tmux

