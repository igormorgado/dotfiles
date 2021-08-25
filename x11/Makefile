mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

all: clean install load

install:
	@ln -sf $(dir $(mkfile_path))_Xresources ${HOME}/.Xresources

load:
	xrdb -merge ${HOME}/.Xresources

clean:
	rm -f ${HOME}/.Xresources
