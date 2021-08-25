mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
pathdirs = bin
rcdfiles = 

all: bindir
clean: bindirclean

bindir:
	$(foreach f,$(pathdirs),ln -sf $(dir $(mkfile_path))$(f) ${HOME}/$(f);)
	$(foreach f,$(rcdfiles),ln -sf $(dir $(mkfile_path))_bashrc.d/$(f) ${HOME}/.bashrc.d/$(f);)

bindirclean:
	@rm -f ${HOME}/bin

