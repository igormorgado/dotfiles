"""Install the plugins and personal skill snapshot selected by a chezmoi template."""

import argparse
import hashlib
import io
import json
import os
from pathlib import Path, PurePosixPath
import socket
import subprocess
import sys
import tarfile
import tempfile


def short_hostname(value):
    return value.strip().lower().split(".", 1)[0]


def read_bundle(repository, settings):
    names = settings["names"]
    if not names or len(names) != len(set(names)) or any(
        not name or name in {".", ".."} or "/" in name or "\\" in name for name in names
    ):
        raise ValueError("Invalid personal skill names in the manifest")
    content = (repository / settings["archive"]).read_bytes()
    if hashlib.sha256(content).hexdigest() != settings["sha256"]:
        raise ValueError("Personal skill bundle checksum mismatch")
    files = {}
    with tarfile.open(fileobj=io.BytesIO(content), mode="r:gz") as bundle:
        for member in bundle.getmembers():
            path = PurePosixPath(member.name)
            if path.is_absolute() or ".." in path.parts or not path.parts or path.parts[0] not in names:
                raise ValueError(f"Unsafe bundle path: {member.name}")
            if member.isdir():
                continue
            if not member.isfile() or len(path.parts) < 2 or path in files:
                raise ValueError(f"Unsupported or duplicate bundle entry: {member.name}")
            with bundle.extractfile(member) as source:
                files[path] = (source.read(), 0o755 if member.mode & 0o111 else 0o644)
    for name in names:
        if PurePosixPath(name, "SKILL.md") not in files:
            raise ValueError(f"Bundle is missing {name}/SKILL.md")
    return files


def install_personal_skills(repository, settings, dry_run):
    files = read_bundle(repository, settings)
    destination = Path.home() / ".agents/skills"
    pending = []
    # Check every destination before copying any skill.
    for name in settings["names"]:
        target = destination / name
        if os.path.lexists(target):
            if not target.is_dir() or not (target / "SKILL.md").is_file():
                raise ValueError(f"Existing skill is incomplete; keeping it untouched: {target}")
            print(f"Keep existing skill: {name}")
        else:
            pending.append(name)
    if dry_run:
        for name in pending:
            print(f"Would install skill: {name}")
        return
    if not pending:
        return
    destination.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix=".skill-install-", dir=destination.parent) as temporary:
        staging = Path(temporary)
        for path, (content, mode) in files.items():
            if path.parts[0] not in pending:
                continue
            target = staging.joinpath(*path.parts)
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(content)
            target.chmod(mode)
        for name in pending:
            target = destination / name
            if os.path.lexists(target):
                raise ValueError(f"Skill appeared during installation; keeping it untouched: {target}")
            os.rename(staging / name, target)
            print(f"Installed skill: {name}")


def install(settings, repository, rendered_hostname, dry_run):
    runtime_hostname = short_hostname(socket.gethostname())
    personal_hosts = {short_hostname(host) for host in settings["personalHosts"]}
    is_personal = (
        short_hostname(rendered_hostname) in personal_hosts
        and runtime_hostname in personal_hosts
    )
    installed_plugins = set()
    if not dry_run:
        result = subprocess.run(
            ["codex", "plugin", "list", "--json"], check=True, capture_output=True, text=True,
        )
        installed_plugins = {
            plugin["pluginId"] for plugin in json.loads(result.stdout)["installed"]
            if plugin.get("installed", True)
        }

    def ensure_plugins(names):
        for name in names:
            if dry_run:
                print(f"Would ensure plugin is installed: {name}")
            elif name in installed_plugins:
                print(f"Keep installed plugin: {name}")
            else:
                subprocess.run(["codex", "plugin", "add", name], check=True)
                installed_plugins.add(name)

    ensure_plugins(settings["plugins"]["allHosts"])
    if not is_personal:
        print(f"Skip personal skills and plugins on {runtime_hostname} "
              f"(template host: {rendered_hostname})")
        return
    install_personal_skills(repository, settings["personal"], dry_run)
    ensure_plugins(settings["plugins"]["personal"])


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("repository", type=Path)
    parser.add_argument("rendered_hostname")
    parser.add_argument("settings", help="JSON settings rendered by chezmoi")
    parser.add_argument("--dry-run", action="store_true", help="Preview without writing files or calling Codex")
    args = parser.parse_args(argv)
    try:
        install(json.loads(args.settings), args.repository, args.rendered_hostname, args.dry_run)
    except (OSError, ValueError, KeyError, TypeError, tarfile.TarError, subprocess.CalledProcessError) as error:
        print(f"Skill installation failed: {error}", file=sys.stderr)
        if isinstance(error, FileNotFoundError) and error.filename == "codex":
            print("Install Codex with plugin support, then rerun make install-skills.", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
