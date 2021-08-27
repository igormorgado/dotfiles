mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

dirs = _config/fish/completions \
       _config/fish/conf.d \
       _config/fish/functions \
       _config/fish

files = _config/fish/functions/fish_greeting.fish \
        _config/fish/functions/fish_mode_prompt.fish \
        _config/fish/functions/fish_prompt.fish \
        _config/fish/functions/fish_right_prompt.fish \
	_config/fish/functions/fish_user_key_bindings.fish \
	_config/fish/config.fish \
        _dir_colors \
	_inputrc

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

