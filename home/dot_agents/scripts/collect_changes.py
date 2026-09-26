#!/usr/bin/env python3
"""Print candidate release-note items from Git commit subjects."""

import argparse
import subprocess
from pathlib import Path


def git(repo: Path, *args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        ["git", "-C", str(repo), *args],
        capture_output=True,
        text=True,
        check=False,
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", type=Path, default=Path.cwd(), help="Git repository (default: current directory)")
    parser.add_argument("--since", help="Tag or commit to compare with HEAD (default: latest reachable tag)")
    args = parser.parse_args()

    if args.since and args.since.startswith("-"):
        parser.error("--since must name a Git ref, not an option")

    repo = args.repo.expanduser().resolve()
    probe = git(repo, "rev-parse", "--is-inside-work-tree")
    if probe.returncode != 0 or probe.stdout.strip() != "true":
        parser.error(f"not a Git working tree: {repo}")

    base = args.since
    if base is None:
        tag = git(repo, "describe", "--tags", "--abbrev=0")
        base = tag.stdout.strip() if tag.returncode == 0 else None

    revision_range = f"{base}..HEAD" if base else "HEAD"
    result = git(repo, "log", "--no-merges", "--format=%h%x09%s", revision_range)
    if result.returncode != 0:
        parser.error(result.stderr.strip() or f"cannot read Git history for {revision_range}")

    print(f"# Candidate changes ({revision_range})")
    if not result.stdout.strip():
        print("No commits found.")
        return 0

    for line in result.stdout.splitlines():
        commit, subject = line.split("\t", 1)
        print(f"- {subject} (`{commit}`)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
