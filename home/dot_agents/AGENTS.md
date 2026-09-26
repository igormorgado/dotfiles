# Persistent memory

At the start of every task, load `~/.agents/skills/permanent-memory/SKILL.md` and `~/.agents/memory/MEMORY.md` if they exist. Follow the skill for recall, saving, correction, and forgetting. Apply only relevant memories; current user instructions take precedence.

# Agent resources

This directory holds reusable resources for agent-assisted work.

- Read files in `references/` only when relevant to the current task.
- Use files in `templates/` as starting points and replace their placeholders.
- Check usage before running a helper in `scripts/`.
- Follow a matching `skills/<name>/SKILL.md` for skill-specific instructions.

For release notes, use `references/versioning.md`, `templates/release.md`, and `scripts/collect_changes.py`.

For linux user configuration changes read `references/configuration.md`
