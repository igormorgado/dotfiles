mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
rcfiles = gitignore gitconfig
#rcdfiles = 050-pinfo

all: git

git:
	@mkdir -p ${HOME}/.bashrc.d
	$(foreach f,$(rcfiles),ln -sf $(dir $(mkfile_path))_$(f) ${HOME}/.$(f);)
	$(foreach f,$(rcdfiles),ln -sf $(dir $(mkfile_path))_bashrc.d/$(f) ${HOME}/.bashrc.d/$(f);)
	git config credential.helper store
	git config --global core.excludesfile ~/.gitignore
	git config --list

clean:
	$(foreach f,$(rcfiles),  rm -f ${HOME}/.$(f))
	$(foreach f,$(rcdfiles), rm -f ${HOME}/.$(f))

