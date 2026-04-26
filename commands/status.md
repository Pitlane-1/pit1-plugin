# /pit1:status

Show current pit1 + cmux environment status.

## Instructions for Claude

Run these commands and report results:

```bash
# Check pit1 installation
which pit1 && pit1 --version

# Check cmux environment
echo "CMUX_WORKSPACE_ID=${CMUX_WORKSPACE_ID:-not set}"

# Show cmux workspace info if inside cmux
if [ -n "${CMUX_WORKSPACE_ID:-}" ]; then
  cmux status --json 2>/dev/null || echo "cmux CLI not in PATH"
fi

# Show current project info
git rev-parse --show-toplevel 2>/dev/null && git branch --show-current
```

Report:
- pit1 version and install location
- Whether running inside cmux or not
- Current workspace/project info
