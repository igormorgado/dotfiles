CHEZMOI := $(shell command -v chezmoi || true)
SHELL := /bin/bash
UNAME := $(shell uname)
DISTRO := $(shell [ -f /etc/os-release ] && . /etc/os-release && echo $$ID || echo unknown)
MAKEFILE_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
DOTFILES_DIR := $(MAKEFILE_DIR)

.PHONY: all bootstrap apply config
 
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


