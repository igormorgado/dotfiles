mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
rcfiles = pinforc
#rcdfiles = 050-pinfo

all: pinfo

install: pinfo

pinfo:
	@mkdir -p ${HOME}/.bashrc.d
	$(foreach f,$(rcfiles),ln -sf $(dir $(mkfile_path))_$(f) ${HOME}/.$(f);)
	$(foreach f,$(rcdfiles),ln -sf $(dir $(mkfile_path))_bashrc.d/$(f) ${HOME}/.bashrc.d/$(f);)

clean:
	$(foreach f,$(rcfiles),  rm -f ${HOME}/.$(f))
	$(foreach f,$(rcdfiles), rm -f ${HOME}/.$(f))

