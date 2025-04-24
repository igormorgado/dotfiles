Make these `*_packages.txt` into `$CHEZMOIDIR/.chezmoidata/packages.yaml`.

In a structure like this

```yaml
packages:
  darwin:
    brew:
      - git
      - htop
  archlinux:
    pacman:
      - git
      - htop
  debian:
    apt:
      - git
      - htop
```

Put `./run_once_before_install-packages.sh.tmpl` at `$CHEZMOIDIR`, or better, at
some `chezmoiscript` sub directory in `$CHEZMOIDIR`. Also make it executable
`+x`.


Need to findout a way to tell chezmoi to execute this, maybe some configuration
at the `chezmoi.yaml`


For now we can keep a single `debian.apt` structure for all debian like. But,
if for some reason there is package naming issues, it's easy to break into
many.
