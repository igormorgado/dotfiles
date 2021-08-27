mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

dirs = 
files = _dir_colors 

all: install
clean: cleanup

test:
	$(foreach f,$(dirs),echo mkdir -p ${HOME}/$(patsubst _%,.%,$(f)) ;)

install:
	$(foreach f,$(dirs),mkdir -p ${HOME}/$(patsubst _%,.%,$(f)) ;)
	$(foreach f,$(files),ln -s $(realpath $(dir $(mkfile_path))$(f)) ${HOME}/$(patsubst _%,.%,$(f)) ;)

cleanup:
	$(foreach f,$(files),rm ${HOME}/$(patsubst _%,.%,$(f)) ;)
	$(foreach f,$(dirs),rmdir --ignore-fail-on-non-empty $(realpath ${HOME}/$(patsubst _%,.%,$(f))) ;)

