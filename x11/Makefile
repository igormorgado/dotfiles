mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
x11files = xprofile XCompose

all: xresources x11
clean: x11clean 

x11:
	@mkdir -p ${HOME}/.local/share/applications
	@ln -sf $(dir $(mkfile_path))_local/share/applications/mimeapps.list ${HOME}/.local/share/applications/
	$(foreach f,$(x11files),ln -sf $(dir $(mkfile_path))_$(f) ${HOME}/.$(f);)


xresources:
	$(MAKE) -C Xresources

x11clean:
	@rm -f ${HOME}/.xprofile
	@rm -f ${HOME}/.Xresources
	@rm -f ${HOME}/.XCompose


