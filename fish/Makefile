mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

dirs = _config/fish/completions \
       _config/fish/conf.d \
       _config/fish/functions \
       _config/fish 

files = _config/fish/functions/fish_prompt.fish \
	_config/fish/config.fish 


all: install
clean: cleanup

install:
	$(foreach f,$(files),mkdir -p $(dir $(patsubst _%,.%,$(f))) ;)
	$(foreach f,$(files),ln -sf $(dir $(mkfile_path))$(f) $(realpath ${HOME}/$(dir $(patsubst _%,.%,$(f)))) ;)

cleanup:
	$(foreach f,$(files),rm ${HOME}/$(patsubst _%,.%,$(f)) ;)
	$(foreach f,$(files),rmdir --ignore-fail-on-non-empty $(realpath ${HOME}/$(dir $(patsubst _%,.%,$(f)))) ;)

