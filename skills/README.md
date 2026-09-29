# Personal skill snapshot

`personal.tar.gz` contains the 27 personal skills installed on `blackmonolith`
when this installer was added on 2026-09-29. It preserves the installed versions,
including local customizations, references, templates, scripts, and bundled tests.
The complete name list and SHA-256 checksum are in
[the skill manifest](../home/.chezmoidata/skills.json).

This is an installation snapshot, not a live upstream checkout. Four skills
(`academic-paper`, `academic-paper-reviewer`, `academic-pipeline`, and
`deep-research`) have local source copies in `JasperPWang/lab-codex-skills`.
Other installed skills include local customizations and copies without complete
upstream provenance. Keeping this snapshot avoids silently substituting different
versions during setup. Included attribution and license files are preserved.

The archive contains only skill directories, each with `SKILL.md`. It excludes
Python bytecode and cache directories. It contains no private memory store,
agent configuration, credentials, Codex system skills, or plugin cache. Superpowers
and Zotero are installed through Codex's plugin command separately.

Inspect or refresh the snapshot from the repository root:

```sh
tar -tzf skills/personal.tar.gz
make snapshot-skills
make test
make skills-preview
```

Refreshing the snapshot updates its checksum in the manifest, causing Chezmoi to
reconsider the installer on the next apply. Installation adds missing skills; it
does not update or remove existing skill directories. To replace an existing
skill intentionally, move its directory to a backup location first, then rerun
`make install-skills`.
