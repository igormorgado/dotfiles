---
name: sample-repo-tour
description: Give a short orientation to an unfamiliar codebase when the user asks for a repository tour or invokes $sample-repo-tour.
---

# Sample Repo Tour

Inspect the current repository and give the user a brief map of it:

- Identify its purpose from the README, project manifests, and relevant source files.
- Point out the main entry points and a few important directories with file links.
- Report setup or test commands only when repository files document them.
- Say what remains unclear if the available files do not establish an answer.

Keep the tour read-only unless the user also asks for changes.
