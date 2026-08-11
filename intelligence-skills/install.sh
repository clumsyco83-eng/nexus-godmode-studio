#!/usr/bin/env bash
#
# install.sh — copy the Intelligence Foundation skills into the NEXUS plugin.
#
# Staged skill folders carry ordering prefixes (01-, 02-, ...) that convey
# pipeline order to a human reader. Installed folders must match their `name`
# frontmatter exactly, so this script strips the prefix on copy. The `name`
# field itself is never rewritten -- it already holds the unprefixed identity.
#
# Usage:
#   ./install.sh --dry-run           show what would happen, change nothing
#   ./install.sh                     install into the default plugin skills dir
#   ./install.sh --dest <path>       install somewhere else
#   ./install.sh --force             overwrite existing destination folders
#
# This script does NOT activate anything: it copies files. Skills load only
# once the host reads the destination directory. After installing, re-run the
# "Sync NEXUS Project Skills" workflow (or mirror by hand into .claude/skills/)
# and confirm with:
#   diff -r plugins/nexus-godmode-studio/skills .claude/skills

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$HERE/.." && pwd)"
DEST="$REPO_ROOT/plugins/nexus-godmode-studio/skills"
DRY_RUN=0
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --force)   FORCE=1; shift ;;
    --dest)    DEST="${2:?--dest requires a path}"; shift 2 ;;
    -h|--help) sed -n '2,25p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; exit 2 ;;
  esac
done

say() { printf '%s\n' "$*"; }
run() { if [[ $DRY_RUN -eq 1 ]]; then say "  would: $*"; else "$@"; fi; }

# ------------------------------------------------------------------ preflight

say "NEXUS Intelligence Foundation -- install"
say "  source: $HERE"
say "  dest:   $DEST"
[[ $DRY_RUN -eq 1 ]] && say "  mode:   DRY RUN (nothing will be written)"
say ""

say "Validating before install..."
if ! "$HERE/validate.sh" --quiet; then
  say ""
  say "Validation failed. Fix the errors above before installing."
  exit 1
fi
say ""

if [[ ! -d "$DEST" ]]; then
  say "Destination does not exist: $DEST"
  say "Create it first, or pass --dest to install elsewhere."
  exit 1
fi

# ------------------------------------------------------------------- planning

declare -a SRC_DIRS=() DST_NAMES=()
for src in "$HERE"/[0-9][0-9]-*/; do
  [[ -d "$src" ]] || continue
  base="$(basename "$src")"
  name="${base#[0-9][0-9]-}"          # strip the ordering prefix

  # The installed folder name must equal the skill's `name` frontmatter.
  declared="$(sed -n 's/^name:[[:space:]]*\([a-z0-9-]*\).*/\1/p' "$src/SKILL.md" | head -1)"
  if [[ "$declared" != "$name" ]]; then
    say "ERROR: $base declares name '$declared' but would install as '$name'."
    say "       Installed directory name and 'name' must match exactly."
    exit 1
  fi

  SRC_DIRS+=("$src")
  DST_NAMES+=("$name")
done

if [[ ${#SRC_DIRS[@]} -eq 0 ]]; then
  say "No staged skill directories found in $HERE"
  exit 1
fi

# --------------------------------------------------------------- collisions

collisions=0
for name in "${DST_NAMES[@]}"; do
  if [[ -e "$DEST/$name" ]]; then
    say "  exists: $name"
    collisions=$((collisions + 1))
  fi
done

if [[ $collisions -gt 0 && $FORCE -eq 0 ]]; then
  say ""
  say "$collisions destination folder(s) already exist. Re-run with --force to overwrite,"
  say "or remove them first. Refusing to overwrite silently."
  exit 1
fi

# ----------------------------------------------------------------- installing

say "Installing ${#SRC_DIRS[@]} skills:"
for i in "${!SRC_DIRS[@]}"; do
  src="${SRC_DIRS[$i]}"
  name="${DST_NAMES[$i]}"
  say "  $(basename "$src")  ->  $name"
  [[ -e "$DEST/$name" ]] && run rm -rf "$DEST/$name"
  run mkdir -p "$DEST/$name"
  run cp -R "$src." "$DEST/$name/"
done

# Shared principles are referenced by every skill as ../SHARED-PRINCIPLES.md,
# which resolves to the skills root once installed.
say "  SHARED-PRINCIPLES.md  ->  (skills root)"
run cp "$HERE/SHARED-PRINCIPLES.md" "$DEST/SHARED-PRINCIPLES.md"

say ""
if [[ $DRY_RUN -eq 1 ]]; then
  say "Dry run complete. Nothing was written."
else
  say "Installed. Next steps:"
  say "  1. Re-run the 'Sync NEXUS Project Skills' workflow, or mirror by hand:"
  say "       rm -rf .claude/skills && mkdir -p .claude/skills"
  say "       cp -R plugins/nexus-godmode-studio/skills/. .claude/skills/"
  say "  2. Verify the mirror:"
  say "       diff -r plugins/nexus-godmode-studio/skills .claude/skills"
  say "  3. Bump versions in .claude-plugin/marketplace.json and plugin.json together."
fi
