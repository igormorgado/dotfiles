mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

all: install
clean: cleanup

install:
	mkdir -p ${HOME}/.local/share
	ln -sf $(realpath $(mkfile_path)/_local/share/fonts) $(realpath ${HOME}/.local/share)

cleanup:
	rm $(realpath ${HOME}/.local/share)

