mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

all: clean build install load

build:
	cpp Xresources.main > Xresources

load:
	xrdb -merge ${HOME}/.Xresources

install:
	@ln -sf $(dir $(mkfile_path))Xresources ${HOME}/.Xresources

clean:
	rm -f ${HOME}/.Xresources
