#!/usr/bin/env bash
# pit1-plugin: session-start.sh
# Renames the cmux sidebar tab to show pit1 + current project on session start.

set -euo pipefail

# Only run inside cmux
[ -n "${CMUX_WORKSPACE_ID:-}" ] || exit 0

# Try to get git repo name + branch
REPO_NAME=$(basename "$(git rev-parse --show-toplevel 2>/dev/null || echo "project")")
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")

if [ -n "$BRANCH" ]; then
  LABEL="pit1 · ${REPO_NAME}:${BRANCH}"
else
  LABEL="pit1 · ${REPO_NAME}"
fi

# Rename the current cmux workspace tab
cmux set-title "$LABEL" 2>/dev/null || true
