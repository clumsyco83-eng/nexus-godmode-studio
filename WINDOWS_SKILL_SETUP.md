# Windows NEXUS Skill Setup

This is the safe Windows path for installing or updating the NEXUS skill pack in Claude Code without deleting unrelated older skills.

## Priority six

The current laptop-verification gate explicitly covers:

- `nexus-godmode-master`
- `token-optimizer-v2`
- `project-memory-continuity`
- `security-guardian`
- `verification-before-completion`
- `git-guardrails-claude-code`

All six live in the canonical plugin tree at `plugins/nexus-godmode-studio/skills/`.

## Install/update the priority six

From a fresh clone or pull of this repository in PowerShell:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\global\install-nexus-skills.ps1 -Scope Priority
```

The installer targets `$HOME\.claude\skills` by default. It:

1. verifies the canonical source exists;
2. snapshots the existing target copy of each selected skill before replacing it;
3. installs an exact copy of each selected skill;
4. compares every installed file to the canonical source by SHA-256;
5. preserves all unrelated pre-existing skill folders;
6. detects multiple `SKILL.md` manifests claiming the same selected skill name;
7. writes `NEXUS-SKILL-VERIFICATION.md` in the local Claude skills directory.

Backups are stored below `$HOME\.claude\skills\.nexus-backup\<timestamp>` when existing selected skills are replaced.

## Verify without changing files

```powershell
.\global\install-nexus-skills.ps1 -Scope Priority -VerifyOnly
```

## Install/update the whole NEXUS pack

```powershell
.\global\install-nexus-skills.ps1 -Scope All
```

This synchronizes all canonical NEXUS skills but still leaves unrelated local skills alone.

## Fresh Claude Code session gate

Filesystem verification is not the same thing as live Claude Code discovery. After the script passes:

1. close all Claude Code sessions;
2. start a fresh Claude Code session;
3. confirm the six priority skills are discoverable;
4. give Claude a small task that should route to each relevant skill;
5. confirm no duplicate skill is presented or loaded;
6. keep the generated verification report with the laptop validation results.

Do not claim the fresh-session gate passed until it has actually been performed on the real Windows machine.

## GitHub verification

`.github/workflows/windows-skill-pack-ci.yml` validates on a Windows runner that:

- the canonical plugin skill tree and `.claude/skills` project mirror are byte-equivalent;
- the complete NEXUS pack installs into an isolated Claude skills directory;
- the priority six pass duplicate/integrity verification;
- the complete pack passes integrity verification.

GitHub CI proves the installer and repository pack behave correctly on Windows. It does not replace the final fresh-session test in the user's locally installed Claude Code.
