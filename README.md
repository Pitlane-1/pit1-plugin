# pit1-plugin — for Claude Code + cmux

Integrates [pit1](https://github.com/Pitlane-1/Pit-1) — the AI infra agent — with [cmux](https://cmux.com) and Claude Code.

## What It Does

| Feature | How |
|---|---|
| **Auto tab naming** | `SessionStart` hook renames cmux sidebar tab to repo + branch |
| **Completion notifications** | `Stop` / `Task` hooks fire cmux notify when Claude needs input |
| **Split pane pipeline** | pit1 opens a pane per step (analyze → recommend → generate → execute → observe) |
| **Slash commands** | `/pit1:deploy`, `/pit1:analyze`, `/pit1:plan`, `/pit1:status` |
| **Skill** | Teaches Claude when to use pit1 automatically |

## Requirements

- macOS 14.0+
- [cmux](https://cmux.com) (`brew tap manaflow-ai/cmux && brew install --cask cmux`)
- cmux CLI symlinked: `sudo ln -sf "/Applications/cmux.app/Contents/Resources/bin/cmux" /usr/local/bin/cmux`
- pit1 installed: `pip install -e .` in the pit1 repo

## Installation

```bash
# In Claude Code
/plugin marketplace add YOUR_GITHUB_USERNAME/pit1-plugin
/plugin install pit1-plugin
/reload-plugins
```

## Slash Commands

| Command | Description |
|---|---|
| `/pit1:deploy [path]` | Full AI deploy pipeline |
| `/pit1:analyze [path]` | Analyze project only |
| `/pit1:plan [path]` | Plan without deploying |
| `/pit1:status` | Show environment status |

## File Structure

```
pit1-plugin/
├── .claude-plugin/
│   └── plugin.json       # Plugin manifest
├── skills/pit1/
│   └── SKILL.md          # Teaches Claude when/how to use pit1
├── hooks/
│   └── hooks.json        # SessionStart, Stop, Task hooks
├── scripts/
│   ├── session-start.sh  # Renames cmux tab on session start
│   └── notify-done.sh    # cmux notification on Stop/Task
└── commands/
    ├── deploy.md         # /pit1:deploy
    ├── analyze.md        # /pit1:analyze
    ├── plan.md           # /pit1:plan
    └── status.md         # /pit1:status
```

## How it works inside cmux

pit1 detects `CMUX_WORKSPACE_ID` automatically. When set:
- Each pipeline step opens its own vertical split pane
- Progress streams to the pane in real time
- Notifications fire at genuine handoff points (not every step)

Outside cmux: pit1 logs everything to stderr via Rich. Zero noise.

## License

MIT
