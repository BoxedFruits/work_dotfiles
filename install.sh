#!/usr/bin/env bash
set -euo pipefail

SPEC_KIT_VERSION="v1.0.3"
MATT_SKILLS_VERSION="v1.2.0"

export PATH="$HOME/.local/bin:$PATH"

# uv (needed for Spec Kit)
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Spec Kit CLI, pinned to a release tag
uv tool install specify-cli --force \
  --from "git+https://github.com/github/spec-kit.git@${SPEC_KIT_VERSION}"

# Matt Pocock's skills, pinned to a release tag
SKILLS_DIR="$HOME/.local/share/mattpocock-skills"
if [ ! -d "$SKILLS_DIR/.git" ]; then
  git clone https://github.com/mattpocock/skills.git "$SKILLS_DIR"
fi
git -C "$SKILLS_DIR" fetch --tags --force
git -C "$SKILLS_DIR" checkout --quiet "$MATT_SKILLS_VERSION"
bash "$SKILLS_DIR/scripts/link-skills.sh"
