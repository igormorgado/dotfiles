# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with **chezmoi**, containing comprehensive Unix/Linux development environment configurations optimized for terminal-based workflows.

## Essential Commands

### Chezmoi Operations
```bash
# Apply dotfiles to system
make apply

# Complete installation process
make all

# Install chezmoi if not present
make install

# Initialize chezmoi repository
make bootstrap

# Generate chezmoi configuration
make config

# Check what would be applied (dry run)
chezmoi diff

# Apply changes to system
chezmoi apply

# Add new files to management
chezmoi add ~/.config/newfile
```

### Development Workflow
```bash
# Edit configurations in chezmoi source
chezmoi edit ~/.config/nvim/init.lua

# Apply single file changes
chezmoi apply ~/.config/nvim/init.lua

# View chezmoi status
chezmoi status
```

## Architecture Overview

### Directory Structure
- `home/` - All dotfiles prefixed with `dot_` (chezmoi convention)
- `home/dot_config/` - Modern XDG config directory structure
- `misc/` - Additional utilities, themes, and resources
- `.chezmoi.yaml.tmpl` - Template-driven chezmoi configuration
- `Makefile` - Installation and setup automation

### Core Technology Stack
- **Shell**: Fish (primary) with modular conf.d/ structure
- **Editor**: Neovim with Lua configuration
- **Terminal**: Kitty with custom Python integrations
- **File Manager**: vifm with custom key bindings
- **Terminal Multiplexer**: tmux
- **Version Control**: Git with delta for enhanced diffs

### Key Design Patterns
- **Consistent Theming**: "darktrial" theme across all applications
- **Template-Driven**: Uses chezmoi templates for cross-platform compatibility
- **Modular Configuration**: Fish shell functions split into logical conf.d/ files
- **Modern Tool Integration**: fzf, ripgrep, zoxide, and other modern CLI tools

### Important Configuration Files
- `home/dot_config/fish/conf.d/` - Modular Fish shell functions
- `home/dot_config/nvim/init.lua` - Primary Neovim configuration
- `home/dot_config/kitty/kitty.conf` - Terminal emulator settings
- `home/dot_gitconfig` - Git configuration with delta integration
- `.chezmoi.yaml.tmpl` - Cross-platform chezmoi settings

### Custom Integrations
- Python scripts for Kitty terminal enhancements
- Docker and Kubernetes helper functions in Fish
- Google Cloud SDK integration
- Python virtual environment management (pyenv, uvenv)
- Custom color schemes and font collection

## Important Notes
- All dotfiles use chezmoi's `dot_` prefix convention
- Configurations are template-driven for cross-platform support
- Recent development focuses on Neovim configuration updates
- Auto-commit feature tracks configuration changes via Git
- Environment supports macOS, Arch Linux, and other Unix systems