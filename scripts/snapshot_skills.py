"""Bundle installed personal skills and update the chezmoi skill manifest."""

import argparse
import gzip
import hashlib
import io
import json
from pathlib import Path
import subprocess
import sys
import tarfile


EXCLUDED = {"__pycache__", ".git", ".cache", ".pytest_cache", ".mypy_cache", ".DS_Store"}


def convert_data(content, template):
    # Reuse chezmoi's YAML support instead of adding a Python YAML dependency.
    return subprocess.run(
        ["chezmoi", "execute-template", "--with-stdin", template],
        input=content, capture_output=True, text=True, check=True,
    ).stdout


def snapshot(source, repository):
    manifest = repository / "home/.chezmoidata/skills.yaml"
    data = json.loads(convert_data(manifest.read_text(), "{{ .chezmoi.stdin | fromYaml | toJson }}"))
    skills = sorted(path for path in source.iterdir() if (path / "SKILL.md").is_file())
    if not skills:
        raise ValueError(f"No skills found in {source}")
    entries = []
    for skill in skills:
        if skill.is_symlink():
            raise ValueError(f"Refusing to bundle a symlink: {skill}")
        for path in sorted(skill.rglob("*")):
            relative = path.relative_to(source)
            if set(relative.parts) & EXCLUDED or path.suffix in {".pyc", ".pyo"}:
                continue
            if path.is_symlink():
                raise ValueError(f"Refusing to bundle a symlink: {path}")
            if path.is_file():
                entries.append((path, relative.as_posix()))
    output = io.BytesIO()
    with gzip.GzipFile(fileobj=output, mode="wb", filename="", mtime=0) as compressed:
        with tarfile.open(fileobj=compressed, mode="w") as bundle:
            for path, name in entries:
                content = path.read_bytes()
                info = tarfile.TarInfo(name)
                info.size = len(content)
                info.mode = 0o755 if path.stat().st_mode & 0o111 else 0o644
                bundle.addfile(info, io.BytesIO(content))
    content = output.getvalue()
    personal = data["skills"]["personal"]
    personal["names"] = [skill.name for skill in skills]
    personal["sha256"] = hashlib.sha256(content).hexdigest()
    manifest_content = convert_data(json.dumps(data), "{{ .chezmoi.stdin | fromJson | toYaml }}")
    archive = repository / personal["archive"]
    archive.parent.mkdir(parents=True, exist_ok=True)
    archive.write_bytes(content)
    manifest.write_text(manifest_content)
    print(f"Bundled {len(skills)} skills ({len(entries)} files) into {archive}")


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=Path.home() / ".agents/skills")
    parser.add_argument("--repository", type=Path, default=Path(__file__).resolve().parents[1])
    args = parser.parse_args(argv)
    try:
        snapshot(args.source, args.repository)
    except (OSError, ValueError, KeyError, subprocess.CalledProcessError) as error:
        print(f"Skill snapshot failed: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
