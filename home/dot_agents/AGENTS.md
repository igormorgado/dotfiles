# Persistent memory

At the start of every task, load `~/.agents/memory/MEMORY.md` if they exist. Follow the skill for recall, saving, correction, and forgetting. Apply only relevant memories; current user instructions take precedence.

# Agent resources

This directory holds reusable resources for agent-assisted work.

- Read files in `references/` only when relevant to the current task.
- Use files in `templates/` as starting points and replace their placeholders.
- Check usage before running a helper in `scripts/`.
- Follow a matching `skills/<name>/SKILL.md` for skill-specific instructions.

For release notes, use `references/versioning.md`, `templates/release.md`, and `scripts/collect_changes.py`.

For linux user configuration changes read `references/configuration.md`

## Installed skills

Personal skills are installed under `~/.agents/skills`, except when a skill requires another location. Check the matching `SKILL.md` before use. Current personal skills (20):

- `codex-self-improvement`
- `define-goal`
- `evo-memory`
- `experiment-craft`
- `experiment-pipeline`
- `hypothesis-generation`
- `networkx`
- `paper-figures`
- `paper-lookup`
- `paper-navigator`
- `paper-planning`
- `paper-rebuttal`
- `paper-review`
- `paper-writing`
- `research-ideation`
- `research-survey`
- `scikit-learn`
- `systematic-debugging`
- `torch-geometric`
- `writing-plans`

Codex-managed system skills under `~/.codex/skills/.system` (6):

- `imagegen`
- `openai-docs`
- `plugin-creator`
- `review-agent`
- `skill-creator`
- `skill-installer`

<!-- codex-self-improvement:start -->
## Global self-improvement

Load the `codex-self-improvement` skill for technical repository work, review/correction of earlier work, and explicit durable UX/design/workflow feedback.

Activation events:

- explicit durable feedback → evaluate private memory even without file changes;
- review, blocker, or correction → correction retrospective even when implementation is deferred;
- technical repository files changed → post-change efficiency reflection;
- one qualified universal improvement → verified upstream draft PR;
- active `UPSTREAM_QUEUE.md` entry → bounded retry at most once per session or natural consolidation point.

Operating constraints:

- activation is automatic and does not interrupt normal work;
- reflection is silent when it writes nothing;
- personal taste and private evidence stay under `PRIVATE_LOCATION`;
- `UNIVERSAL_LOCATION` is a read-only snapshot of public upstream `main`;
- public changes are authored only in isolated upstream branches/worktrees;
- project facts remain project-local;
- one universal improvement is enough; batching is not required;
- reuse stable contribution IDs, branches, and existing draft PRs;
- never push directly to `main`, merge automatically, or expose private memory;
- after an actual memory/skill write, report only changed filename(s) and any confirmed draft PR reference;
- quality, safety, TDD, review, and verification are not reduced for usage efficiency.
<!-- codex-self-improvement:end -->
