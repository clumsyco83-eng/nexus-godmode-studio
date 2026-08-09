#!/usr/bin/env bash
#
# Install third-party Claude Code skills globally WITHOUT byte-copying them.
#
# Repositories that ship skills but have no .claude-plugin/ manifest cannot be
# installed with `/plugin marketplace add`. The usual workaround — copying the
# skill folders into ~/.claude/skills/ — creates a second copy that silently
# drifts from upstream and never receives updates.
#
# This script avoids that: it clones each upstream ONCE into ~/src, then
# symlinks individual skill folders into ~/.claude/skills/. One canonical
# source, updated with `git pull`. No duplicated files.
#
# Verified: Claude Code follows symlinks in ~/.claude/skills/.
#
# Usage:
#   ./install-external-skills.sh            # install / update
#   ./install-external-skills.sh --list     # show what would be linked
#   ./install-external-skills.sh --remove   # remove only the symlinks it made
#
set -euo pipefail

SRC_DIR="${SRC_DIR:-$HOME/src}"
SKILLS_DIR="${SKILLS_DIR:-$HOME/.claude/skills}"

# repo_url|subdir_holding_skills|space-separated skill folders to link
REPOS=(
  "https://github.com/emilkowalski/skills|skills|animate animation-vocabulary apple-design emil-design-eng find-animation-opportunities improve-animations pick-ui-library prototype review-animations"
)

list_only=false; remove=false
case "${1:-}" in
  --list)   list_only=true ;;
  --remove) remove=true ;;
  "")       ;;
  *) echo "unknown option: $1" >&2; exit 2 ;;
esac

linked=0; skipped=0

for entry in "${REPOS[@]}"; do
  url="${entry%%|*}"; rest="${entry#*|}"
  subdir="${rest%%|*}"; skills="${rest#*|}"
  name="$(basename "$url")"; owner="$(basename "$(dirname "$url")")"
  clone="$SRC_DIR/$owner-$name"

  if $remove; then
    for s in $skills; do
      target="$SKILLS_DIR/$s"
      if [ -L "$target" ] && [[ "$(readlink "$target")" == "$clone"/* ]]; then
        rm "$target"; echo "removed symlink  $s"; linked=$((linked+1))
      fi
    done
    continue
  fi

  if $list_only; then
    echo "$owner/$name -> $clone"
    for s in $skills; do echo "    $s"; done
    continue
  fi

  mkdir -p "$SRC_DIR" "$SKILLS_DIR"
  if [ -d "$clone/.git" ]; then
    echo "updating $owner/$name"
    git -C "$clone" pull --ff-only --quiet || echo "  (pull skipped — local changes or diverged)"
  else
    echo "cloning $owner/$name"
    git clone --depth 1 "$url" "$clone" --quiet
  fi

  for s in $skills; do
    source_path="$clone/$subdir/$s"
    target="$SKILLS_DIR/$s"
    if [ ! -d "$source_path" ]; then
      echo "  MISSING upstream: $s (skipped)"; skipped=$((skipped+1)); continue
    fi
    # Never clobber a real directory — only replace our own symlink.
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "  CONFLICT: $target exists and is not a symlink — left untouched"
      skipped=$((skipped+1)); continue
    fi
    ln -sfn "$source_path" "$target"
    echo "  linked $s"; linked=$((linked+1))
  done
done

if ! $list_only; then
  echo
  echo "linked/removed: $linked   skipped: $skipped"
  echo "canonical clones live in $SRC_DIR — re-run this script to update them."
  echo
  echo "Note: pick-ui-library, prototype and review-animations set"
  echo "disable-model-invocation, so they are discovered but only run when you"
  echo "invoke them explicitly (/pick-ui-library). That is their authors' design."
fi
