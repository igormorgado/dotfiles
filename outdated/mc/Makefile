mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
mcfiles = ini panels.ini solarized.ini
rcdfiles = 050-mc

all: mc
clean: mcclean

mc:
	@mkdir -p ${HOME}/.bashrc.d/
	@mkdir -p ${HOME}/.config/mc
	$(foreach f,$(mcfiles),ln -sf $(dir $(mkfile_path))_config/mc/$(f) ${HOME}/.config/mc/$(f);)
	$(foreach f,$(rcdfiles),ln -sf $(dir $(mkfile_path))_bashrc.d/$(f) ${HOME}/.bashrc.d/$(f);)

mcclean:
	@rm -f ${HOME}/.config/mc/ini
	@rm -f ${HOME}/.config/mc/panels.ini
	@rm -f ${HOME}/.config/mc/solirized.ini
	@rm -f ${HOME}/.bashrc.d/050-mc

