# Repository Guidelines

This repository contains personal dotfiles managed with **chezmoi**. Keep changes small, portable (macOS/Arch/Debian), and safe to apply on a real machine.

## Project Structure & Module Organization

- `home/` — managed files. Chezmoi uses the `dot_` prefix here and renders it as `.` on apply.
  - `home/dot_config/` — XDG configs (Fish, Kitty, Neovim, tmux, vifm, etc.).
  - `home/.chezmoidata/` — YAML data used by templates (for example `packages_arch.yaml`).
  - `home/.chezmoiscripts/` — bootstrap scripts run by `chezmoi` (for example package installs).
- `misc/` — reference files/themes not directly applied.
- `.chezmoi.yaml.tmpl` — template for `~/.config/chezmoi/chezmoi.yaml`.
- `Makefile` — bootstrap/apply automation.

## Build, Test, and Development Commands

Run from the repo root:

- `make install` — install `chezmoi` (uses brew/pacman/curl depending on OS).
- `make bootstrap` — initialize `chezmoi` for this repo (`chezmoi init -v igormorgado`).
- `make config` — render `.chezmoi.yaml.tmpl` into `~/.config/chezmoi/chezmoi.yaml`.
- `make apply` — apply dotfiles to your system (also runs the package bootstrap script on first apply).
- `make all` — `install + bootstrap + apply + config`.
- `chezmoi diff` — preview what would change before applying.
- `chezmoi edit ~/.config/nvim/init.lua` — edit a managed file in the source state.
- `chezmoi add ~/.config/newtool/config` — start managing a new file.
- `chezmoi execute-template < home/.chezmoiscripts/run_once_before_install-packages.sh.tmpl | bash` — render and run the package bootstrap (re-runs installs; uses `sudo`).

## Coding Style & Naming Conventions

- Follow chezmoi conventions: new managed files live under `home/` and use `dot_` / `dot_config/` naming.
- Prefer templates (`*.tmpl`) plus data in `home/.chezmoidata/` for OS-specific values.
- Use YAML for files in `home/.chezmoidata/`, matching the existing package and skill manifests.
- Match existing formatting; use tabs only in `Makefile`.

## Testing Guidelines

Run `make test` for the skill installer's host isolation, integrity, and repeat-run checks. Run `make skills-preview` to render and preview the real template without installing anything. For other dotfiles, validate with `chezmoi diff` and/or `chezmoi apply --dry-run`, and apply on a disposable profile/VM first when practical.

Skill installation uses `home/.chezmoidata/skills.yaml` and `home/.chezmoiscripts/run_once_after_install-skills.sh.tmpl`. Superpowers applies to all hosts; personal skills and Zotero require both the rendered and runtime hostname to be allowlisted. Keep source skill snapshots under `skills/`, outside the managed `home/` tree. `make snapshot-skills` deliberately refreshes the bundle from `~/.agents/skills`; never include private memory, credentials, or caches in it. Existing installed skills must not be overwritten. Generated scripts and test files live under `.cache/`, managed by `make clean`.

Debian/Ubuntu note: Neovim is installed as an AppImage to `~/.local/bin/nvim.appimage` with a symlink at `~/.local/bin/nvim` (not via `apt`).

## Commit & Pull Request Guidelines

- Commit messages are simple and imperative (examples in history: `Add …`, `Update …`, `Remove …`, often including a path).
- `make config` generates a chezmoi config that enables `git.autoAdd/autoCommit/autoPush`; confirm `git status` and remotes before pushing.
- PRs should include: what changed, OS(es) tested, and any manual validation steps.
