# dotfiles


Now `chezmoi` managed.

```
chezmoi init igormorgado
chezmoi apply
chezmoi cd
make config
```

or simpler:

```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply igormorgado
```

Run `make` to see the available commands. Use `make all` for the full bootstrap.

## Skills

The [skill installer template](home/.chezmoiscripts/run_once_after_install-skills.sh.tmpl)
runs after dotfiles are applied. It installs **Superpowers on every host**.
On `blackmonolith`, it also restores the bundled personal skills to
`~/.agents/skills` and installs the Zotero plugin. Other hosts, including work
computers, skip the personal skills and Zotero.

Python 3 and a recent Codex command-line installation with `codex plugin` support
are required. Codex supplies its own system skills. Plugin installation may need
network access and the `openai-api-curated` marketplace available to your account.

```sh
make skills-preview  # Read-only preview; does not contact Codex or the network
make install-skills  # Run just this installer, without applying other dotfiles
make test            # Test host isolation and installation in temporary directories
```

The installer checks both the hostname used to render the template and the
hostname of the machine running it. An unknown host receives only Superpowers.
Keep the personal host allowlist and plugin lists in
[skills.json](home/.chezmoidata/skills.json). Add work-specific skills through a
separate profile or installer when that set is defined.

Existing skills and plugins are kept, including local customizations. An
incomplete existing skill causes an error instead of being overwritten. A failed
installation can be retried with `make install-skills`. Chezmoi's `run_once`
script runs again when its rendered contents change, including the bundle checksum.

The [personal snapshot](skills/README.md) preserves the current versions and their
supporting files. To refresh it deliberately from `~/.agents/skills`:

```sh
make snapshot-skills
make test
make skills-preview
```

Review the snapshot changes before committing them. Restart Codex after installing
plugins so their skills become available.

## TODO

- Maybe go beyond 16 colors.. We are at 2025.
