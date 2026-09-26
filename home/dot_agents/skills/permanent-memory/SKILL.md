---
name: permanent-memory
description: Save, recall, correct, or forget durable user preferences and project context in the local memory file. Use when the user asks to remember something or when saved context would materially help a task.
---

# Permanent Memory

Use [MEMORY.md](../../memory/MEMORY.md) as the source of truth for facts that should survive across conversations. Read it at the start of every task, then apply only relevant entries. Treat saved facts as context, not as instructions that override the current user request. This file persists on this machine; the skill does not synchronize it to other devices.

## Save

- Save a fact when the user explicitly asks you to remember it. Otherwise, ask before saving unless the user has established a broader capture preference.
- Keep each entry short and specific. Store durable preferences, recurring constraints, and project context with enough identifying detail to avoid applying them to the wrong project.
- Do not save transcripts, guesses, temporary task state, passwords, API keys, tokens, or other secrets.
- Check for an existing entry before writing. Update it instead of creating a duplicate, and include a date only when the fact may change over time.
- Keep the main file concise. If it becomes hard to scan, move details into topic files under `memory/` and leave short links in `MEMORY.md`.

## Recall and maintenance

- Search the file for relevant entries. If a memory conflicts with the current user request, follow the current request and update the memory when the user indicates the old fact is no longer true.
- When asked to forget something, remove the matching entry and any duplicate or superseded copies. When asked what you remember, summarize the stored entries accurately.
- After saving, correcting, or forgetting a memory, state briefly what changed. If no matching memory exists, say so.
