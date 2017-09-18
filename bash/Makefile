mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
bashfiles = profile bashrc bash_profile bash_logout inputrc
rcdfiles = 010-bash_functions 020-aliases 999-local

all: bash dircolor config
clean: bashclean dircolorclean configclean

bash:
	@mkdir -p ${HOME}/.bashrc.d/
	$(foreach f,$(bashfiles),ln -sf $(dir $(mkfile_path))_$(f) ${HOME}/.$(f);)
	$(foreach f,$(rcdfiles),ln -sf $(dir $(mkfile_path))_bashrc.d/$(f) ${HOME}/.bashrc.d/$(f);)

bashclean:
	@rm -f ${HOME}/.profile
	@rm -f ${HOME}/.bashrc
	@rm -f ${HOME}/.bash_profile
	@rm -f ${HOME}/.bash_logout
	@rm -f ${HOME}/.inputrc
	@rm -f ${HOME}/.bashrc.d/010-bash_functions
	@rm -f ${HOME}/.bashrc.d/020-aliases
	@rm -f ${HOME}/.bashrc.d/999-local

dircolor:
ifeq (${BACKGROUND},light)
	$(info Setting LIGHT background)
	@ln -sf $(dir $(mkfile_path))_dir_colors.ansi-light 	${HOME}/.dir_colors
else ifeq (${BACKGROUND},dark)
	$(info Setting DARK background)
	@ln -sf $(dir $(mkfile_path))_dir_colors.ansi-dark 	${HOME}/.dir_colors
else
	$(info Setting UNIVERSAL background)
	@ln -sf $(dir $(mkfile_path))_dir_colors.ansi-universal 	${HOME}/.dir_colors
endif

dircolorclean:
	@rm -f ${HOME}/.dir_colors

config:
	@mkdir -p ${HOME}/.config
	@ln -sf $(dir $(mkfile_path))_config/locale.conf ${HOME}/.config/locale.conf

configclean:
	@rm -f ${HOME}/_config/.dir_colors

