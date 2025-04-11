CHEZMOI := $(shell command -v chezmoi || true)
SHELL := /bin/bash
UNAME := $(shell uname)
DISTRO := $(shell [ -f /etc/os-release ] && . /etc/os-release && echo $$ID || echo unknown)
MAKEFILE_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
DOTFILES_DIR := $(MAKEFILE_DIR)

.PHONY: all bootstrap apply
 
# all: bootstrap apply

install-chezmoi:
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

bootstrap: install-chezmoi
	@echo "🚀 Bootstrapping chezmoi from $(DOTFILES_DIR)..."
	# mkdir -p $(HOME)/.config/chezmoi
	# cp $(DOTFILES_DIR)/chezmoi.toml $(HOME)/.config/chezmoi/chezmoi.toml
	$(CHEZMOI) init --source=$(DOTFILES_DIR)

apply:
	@echo "🎯 Applying dotfiles..."
	$(CHEZMOI) apply
