mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
files = muttrc
fdir = mutt
filedir = solarized_dark_16colors alias sig
rcdfiles =
tmpdir = mail cache/headers cache/bodies temp

all: mutt
clean: muttclean 

mutt:
	# Add a way to just create if $fdir is set
	@mkdir -p ${HOME}/.$(fdir)
	$(foreach f,$(files),ln -sf $(dir $(mkfile_path))_$(f) ${HOME}/.$(f);)
	$(foreach f,$(filedir),ln -sf $(dir $(mkfile_path))_$(fdir)/$(f) ${HOME}/.$(fdir)/$(f);)
	$(foreach f,$(rcdfiles),ln -sf $(dir $(mkfile_path))_bashrc.d/$(f) ${HOME}/.bashrc.d/$(f);)
	$(foreach f,$(tmpdir),mkdir -p ${HOME}/.tmp/$(fdir)/$(f);)

muttclean:
	$(foreach f,$(files),rm -f ${HOME}/.$(f);)
	$(foreach f,$(filedir),rm -f ${HOME}/$(fdir).$(f);)
	$(foreach f,$(tmpdir),rmdir ${HOME}/.tmp/$(fdir)/$(f);)
	@rmdir ${HOME}/.$(fdir)
