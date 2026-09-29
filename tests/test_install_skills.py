"""Exercise host isolation, bundle integrity, and non-destructive installation."""

import contextlib
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import socket
import subprocess
import tarfile
import tempfile
import unittest
from unittest.mock import patch


ROOT = Path(__file__).resolve().parents[1]


class InstallSkillsTests(unittest.TestCase):
    def setUp(self):
        installer = ROOT / "scripts/install_skills.py"
        self.assertTrue(installer.is_file(), "The skills installer is not implemented")
        spec = importlib.util.spec_from_file_location("install_skills", installer)
        self.installer = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(self.installer)
        cache = ROOT / ".cache/tests"
        cache.mkdir(parents=True, exist_ok=True)
        self.temp = tempfile.TemporaryDirectory(dir=cache)
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.user_dir = self.root / "user"
        self.repo = self.root / "repo's files"
        self.repo.mkdir()
        self.archive = self.repo / "skills/personal.tar.gz"
        self.archive.parent.mkdir()
        self.files = {
            "example/SKILL.md": b"---\nname: example\n---\nExample skill\n",
            "example/references/guide.md": b"Bundled reference\n",
            "example/helper.sh": b"#!/bin/sh\nexit 0\n",
            "second/SKILL.md": b"---\nname: second\n---\nSecond skill\n",
        }
        self.write_archive(self.files)
        self.settings = {
            "personalHosts": ["blackmonolith"],
            "plugins": {
                "allHosts": ["superpowers@openai-api-curated"],
                "personal": ["zotero@openai-api-curated"],
            },
            "personal": {
                "archive": "skills/personal.tar.gz",
                "sha256": hashlib.sha256(self.archive.read_bytes()).hexdigest(),
                "names": ["example", "second"],
            },
        }
        self.plugins = set()
        self.additions = []

    def write_archive(self, files):
        with tarfile.open(self.archive, "w:gz") as bundle:
            for name, content in files.items():
                info = tarfile.TarInfo(name)
                info.size = len(content)
                info.mode = 0o755 if name.endswith(".sh") else 0o644
                bundle.addfile(info, io.BytesIO(content))

    def codex(self, command, **kwargs):
        if command == ["codex", "plugin", "list", "--json"]:
            data = {"installed": [
                {"pluginId": name, "installed": True, "enabled": True}
                for name in sorted(self.plugins)
            ], "available": []}
            return subprocess.CompletedProcess(command, 0, json.dumps(data), "")
        if command[:3] == ["codex", "plugin", "add"] and len(command) == 4:
            self.plugins.add(command[3])
            self.additions.append(command[3])
            return subprocess.CompletedProcess(command, 0, "", "")
        self.fail(f"Unexpected external command: {command}")

    def run_installer(self, rendered="blackmonolith", runtime="blackmonolith", dry_run=False):
        args = [str(self.repo), rendered, json.dumps(self.settings)]
        if dry_run:
            args.append("--dry-run")
        output = io.StringIO()
        with patch.object(Path, "home", return_value=self.user_dir), \
                patch.object(socket, "gethostname", return_value=runtime), \
                patch.object(self.installer.subprocess, "run", side_effect=self.codex), \
                contextlib.redirect_stdout(output), contextlib.redirect_stderr(output):
            code = self.installer.main(args)
        return code, output.getvalue()

    def test_work_and_unknown_hosts_only_install_superpowers(self):
        # Removing either host check must expose personal files or Zotero here.
        for rendered, runtime in [
            ("cyberdeck", "cyberdeck"), ("igor-morgado", "igor-morgado"),
            ("unknown", "unknown"), ("blackmonolith", "cyberdeck"),
            ("cyberdeck", "blackmonolith"),
        ]:
            with self.subTest(rendered=rendered, runtime=runtime):
                self.plugins.clear()
                code, output = self.run_installer(rendered, runtime)
                self.assertEqual(code, 0, output)
                self.assertEqual(self.plugins, {"superpowers@openai-api-curated"})
                self.assertFalse(self.user_dir.exists())

    def test_personal_host_installs_skills_references_and_both_plugins(self):
        code, output = self.run_installer(runtime="BLACKMONOLITH.local")
        self.assertEqual(code, 0, output)
        for name, content in self.files.items():
            self.assertEqual((self.user_dir / ".agents/skills" / name).read_bytes(), content)
        self.assertEqual((self.user_dir / ".agents/skills/example/helper.sh").stat().st_mode & 0o777, 0o755)
        self.assertEqual(self.plugins, {
            "superpowers@openai-api-curated", "zotero@openai-api-curated",
        })

    def test_rerun_preserves_customizations_and_installed_plugins(self):
        self.assertEqual(self.run_installer()[0], 0)
        path = self.user_dir / ".agents/skills/example/SKILL.md"
        path.write_text("Locally customized\n")
        self.additions.clear()
        code, output = self.run_installer()
        self.assertEqual(code, 0, output)
        self.assertEqual(path.read_text(), "Locally customized\n")
        self.assertEqual(self.additions, [])

    def test_dry_run_has_no_filesystem_or_external_side_effects(self):
        code, output = self.run_installer(dry_run=True)
        self.assertEqual(code, 0, output)
        self.assertIn("example", output)
        self.assertIn("superpowers", output)
        self.assertFalse(self.user_dir.exists())
        self.assertEqual(self.plugins, set())

    def test_corrupt_bundle_installs_no_personal_skills(self):
        self.archive.write_bytes(self.archive.read_bytes() + b"changed")
        code, output = self.run_installer()
        self.assertNotEqual(code, 0)
        self.assertIn("checksum", output.lower())
        self.assertFalse(self.user_dir.exists())
        self.assertNotIn("zotero@openai-api-curated", self.plugins)

    def test_work_host_does_not_require_personal_bundle(self):
        self.archive.unlink()
        code, output = self.run_installer("cyberdeck", "cyberdeck")
        self.assertEqual(code, 0, output)
        self.assertEqual(self.plugins, {"superpowers@openai-api-curated"})

    def test_archive_path_traversal_is_rejected_before_writes(self):
        self.write_archive({**self.files, "../outside": b"bad"})
        self.settings["personal"]["sha256"] = hashlib.sha256(self.archive.read_bytes()).hexdigest()
        code, output = self.run_installer()
        self.assertNotEqual(code, 0, output)
        self.assertFalse(self.user_dir.exists())
        self.assertFalse((self.root / "outside").exists())

    def test_incomplete_existing_skill_is_preserved_and_reported(self):
        path = self.user_dir / ".agents/skills/second"
        path.mkdir(parents=True)
        (path / "notes.txt").write_text("Keep this\n")
        code, output = self.run_installer()
        self.assertNotEqual(code, 0, output)
        self.assertEqual((path / "notes.txt").read_text(), "Keep this\n")
        self.assertFalse((self.user_dir / ".agents/skills/example").exists())

    def test_plugin_failure_is_reported_and_retry_can_complete(self):
        with patch.object(self, "codex", side_effect=subprocess.CalledProcessError(1, "codex")):
            code, output = self.run_installer()
        self.assertNotEqual(code, 0, output)
        self.assertFalse(self.user_dir.exists())
        self.assertEqual(self.run_installer()[0], 0)

    def test_actual_chezmoi_template_renders_and_runs_for_both_host_types(self):
        # Exercise shell quoting and the embedded helper, not just its Python API.
        (self.repo / ".chezmoiroot").write_text("home\n")
        (self.repo / "home").mkdir()
        (self.repo / "scripts").mkdir()
        (self.repo / "scripts/install_skills.py").write_bytes((ROOT / "scripts/install_skills.py").read_bytes())
        template = (ROOT / "home/.chezmoiscripts/run_once_after_install-skills.sh.tmpl").read_text()
        config = self.root / "chezmoi.json"
        config.write_text("{}\n")
        runtime_host = socket.gethostname().split(".", 1)[0].lower()
        self.settings["personalHosts"] = [runtime_host]
        for rendered_host, personal in [(runtime_host, True), ("excluded-work-host", False)]:
            with self.subTest(host=rendered_host):
                data = {"chezmoi": {"hostname": rendered_host}, "skills": self.settings}
                rendered_result = subprocess.run([
                    "chezmoi", "--config", str(config), "--source", str(self.repo),
                    "--working-tree", str(self.repo), "--override-data", json.dumps(data),
                    "execute-template",
                ], input=template, capture_output=True, text=True)
                self.assertEqual(rendered_result.returncode, 0, rendered_result.stderr)
                rendered = rendered_result.stdout
                subprocess.run(["bash", "-n"], input=rendered, text=True, check=True)
                script = self.root / "rendered.sh"
                script.write_text(rendered)
                result = subprocess.run(["bash", str(script), "--dry-run"], capture_output=True, text=True)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertIn("superpowers@openai-api-curated", result.stdout)
                self.assertEqual("zotero@openai-api-curated" in result.stdout, personal)
                self.assertEqual("Would install skill: second" in result.stdout, personal)


if __name__ == "__main__":
    unittest.main()
