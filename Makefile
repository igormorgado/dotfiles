CHEZMOI := $(shell command -v chezmoi || true)
SHELL := /bin/bash
UNAME := $(shell uname)
DISTRO := $(shell [ -f /etc/os-release ] && . /etc/os-release && echo $$ID || echo unknown)
MAKEFILE_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
DOTFILES_DIR := $(MAKEFILE_DIR)
SKILLS_SCRIPT := $(DOTFILES_DIR).cache/install-skills.sh
PYTHON := python3
.DEFAULT_GOAL := help

.PHONY: all install bootstrap apply config help render-skills skills-preview install-skills snapshot-skills test clean

help:
	@echo "make all             Install chezmoi, bootstrap, apply, and configure dotfiles"
	@echo "make apply           Apply dotfiles and pending chezmoi scripts"
	@echo "make config          Generate the local chezmoi configuration"
	@echo "make skills-preview  Preview the skill installer without changing this machine"
	@echo "make install-skills  Install the skills and plugins allowed on this host"
	@echo "make snapshot-skills Bundle current personal skills and update their manifest"
	@echo "make test            Run installer tests without network or real installations"
	@echo "make clean           Remove local generated scripts and test caches"
 
all: install bootstrap apply config

install:
ifeq (,$(wildcard $(CHEZMOI)))
	@echo "🔧 Installing chezmoi..."
ifeq ($(UNAME),Darwin)
	@echo "🍎 Detected macOS – installing via Homebrew..."
	@brew install chezmoi
else ifeq ($(DISTRO),arch)
	@echo "🐧 Detected Arch Linux – installing via pacman..."
	@sudo pacman -Sy --noconfirm chezmoi
else
	@echo "🌐 Unknown OS – falling back to chezmoi install script..."
	@sh -c "$$(curl -fsLS get.chezmoi.io)" -- -b $(HOME)/.local/bin
endif
else
	@echo "🏠 Chezmoi installed" 
endif

bootstrap: install
	@echo "🚀 Bootstrapping chezmoi from $(DOTFILES_DIR)..."
	$(CHEZMOI) init -v igormorgado 

config: install
	@echo "Generating chezmoi config"
	mkdir -p $(HOME)/.config/chezmoi
	cat .chezmoi.yaml.tmpl | $(CHEZMOI) execute-template > $(HOME)/.config/chezmoi/chezmoi.yaml

apply: install bootstrap
	@echo "🎯 Applying dotfiles..."
	$(CHEZMOI) -v apply

render-skills:
	@mkdir -p "$(DOTFILES_DIR).cache"
	@$(CHEZMOI) --source "$(DOTFILES_DIR)" --working-tree "$(DOTFILES_DIR)" execute-template < "$(DOTFILES_DIR)home/.chezmoiscripts/run_once_after_install-skills.sh.tmpl" > "$(SKILLS_SCRIPT).tmp"
	@mv "$(SKILLS_SCRIPT).tmp" "$(SKILLS_SCRIPT)"

skills-preview: render-skills
	@bash "$(SKILLS_SCRIPT)" --dry-run

install-skills: render-skills
	@bash "$(SKILLS_SCRIPT)"

snapshot-skills:
	$(PYTHON) -B "$(DOTFILES_DIR)scripts/snapshot_skills.py"

test:
	$(PYTHON) -B -m unittest discover -s "$(DOTFILES_DIR)tests" -v

clean:
	rm -rf -- "$(DOTFILES_DIR).cache"
