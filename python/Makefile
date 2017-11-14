mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
pythonfiles = pythonrc.py pdbrc pdbrc.py ipython/profile_default/ipython_config.py
rcdfiles = 050-python

all: python
clean: pythonclean

python:
	@mkdir -p ${HOME}/.bashrc.d/
	@mkdir -p ${HOME}/.ipython/
	$(foreach f,$(pythonfiles),ln -sf $(dir $(mkfile_path))_$(f) ${HOME}/.$(f);)
	$(foreach f,$(rcdfiles),ln -sf $(dir $(mkfile_path))_bashrc.d/$(f) ${HOME}/.bashrc.d/$(f);)

pythonclean:
	@rm -f ${HOME}/.bashrc.d/050-python
	@rm -f ${HOME}/.ipython
	@rm -f ${HOME}/.pythonrc.py
	@rm -f ${HOME}/.pdbrc
	@rm -f ${HOME}/.pdbrc.py

