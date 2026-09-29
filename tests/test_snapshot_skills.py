"""A snapshot restores the installed files without caches or outside symlinks."""

import contextlib
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import subprocess
import tarfile
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


class SnapshotSkillsTests(unittest.TestCase):
    def setUp(self):
        script = ROOT / "scripts/snapshot_skills.py"
        self.assertTrue(script.is_file(), "The snapshot builder is not implemented")
        spec = importlib.util.spec_from_file_location("snapshot_skills", script)
        self.builder = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(self.builder)
        cache = ROOT / ".cache/tests"
        cache.mkdir(parents=True, exist_ok=True)
        self.temp = tempfile.TemporaryDirectory(dir=cache)
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.source = self.root / "installed"
        skill = self.source / "example"
        skill.mkdir(parents=True)
        (skill / "SKILL.md").write_text("An installed skill\n")
        (skill / "helper.sh").write_text("#!/bin/sh\nexit 0\n")
        (skill / "helper.sh").chmod(0o755)
        (skill / "__pycache__").mkdir()
        (skill / "__pycache__/old.pyc").write_bytes(b"cache")
        (self.source / "not-a-skill").mkdir()
        (self.source / "not-a-skill/private.txt").write_text("Do not bundle\n")
        self.manifest = self.root / "home/.chezmoidata/skills.yaml"
        self.manifest.parent.mkdir(parents=True)
        self.manifest.write_text("""skills:
  personalHosts:
    - blackmonolith
  plugins:
    allHosts:
      - superpowers@openai-api-curated
    personal: []
  personal:
    archive: skills/personal.tar.gz
    names: []
    sha256: ''
""")

    def snapshot(self):
        with contextlib.redirect_stdout(io.StringIO()), contextlib.redirect_stderr(io.StringIO()):
            return self.builder.main(["--source", str(self.source), "--repository", str(self.root)])

    def test_snapshot_is_reproducible_and_contains_only_skill_assets(self):
        self.assertEqual(self.snapshot(), 0)
        archive = self.root / "skills/personal.tar.gz"
        first = archive.read_bytes()
        self.assertEqual(self.snapshot(), 0)
        self.assertEqual(archive.read_bytes(), first)
        rendered = subprocess.run([
            "chezmoi", "execute-template", "--with-stdin",
            "{{ .chezmoi.stdin | fromYaml | toJson }}",
        ], input=self.manifest.read_text(), capture_output=True, text=True, check=True)
        data = json.loads(rendered.stdout)["skills"]
        self.assertEqual(data["personal"]["names"], ["example"])
        self.assertEqual(data["personal"]["sha256"], hashlib.sha256(first).hexdigest())
        self.assertEqual(data["personalHosts"], ["blackmonolith"])
        self.assertEqual(data["plugins"]["allHosts"], ["superpowers@openai-api-curated"])
        with tarfile.open(archive) as bundle:
            self.assertEqual(bundle.getnames(), ["example/SKILL.md", "example/helper.sh"])
            self.assertEqual(bundle.extractfile("example/SKILL.md").read(), b"An installed skill\n")
            self.assertEqual(bundle.getmember("example/helper.sh").mode, 0o755)

    def test_symlink_outside_skill_is_rejected(self):
        (self.source / "example/private-link").symlink_to(self.source / "not-a-skill/private.txt")
        self.assertNotEqual(self.snapshot(), 0)
        self.assertFalse((self.root / "skills/personal.tar.gz").exists())


if __name__ == "__main__":
    unittest.main()
