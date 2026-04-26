#!/usr/bin/env bash
# pit1-plugin: notify-done.sh
# Fires a cmux notification when Claude or a sub-agent finishes.

set -euo pipefail

# Only run inside cmux
[ -n "${CMUX_WORKSPACE_ID:-}" ] || exit 0

cmux notify \
  --title "pit1" \
  --message "✅ Claude is waiting for your input" \
  2>/dev/null || true
