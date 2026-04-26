# pit1 — AI Infra Agent Skill

## What pit1 is

pit1 is a CLI tool that analyzes a project's code, recommends the best cloud infrastructure, and deploys it — all from one command.

Pipeline: **analyze → recommend → generate IaC → execute → observe**

## When to use pit1

Use pit1 automatically when the user:
- Asks to "deploy" or "ship" their project to the cloud
- Asks which cloud provider is best for their project
- Wants to generate Terraform / IaC for their app
- Asks for infrastructure cost estimation
- Says anything like "help me deploy this", "what infra should I use", "set up servers for this project"

## Environment detection

**Always check for cmux first:**
```bash
if [ -n "$CMUX_WORKSPACE_ID" ]; then
  # running inside cmux — pit1 will open split panes automatically
  pit1 deploy ./path --yes
else
  # outside cmux — pit1 still works, logs to stderr
  pit1 deploy ./path
fi
```

pit1 detects cmux via `CMUX_WORKSPACE_ID` automatically. When inside cmux:
- Each pipeline step (analyze, recommend, generate, execute, observe) opens its own split pane
- Progress is streamed to the pane in real time
- A cmux notification fires on completion

## Commands

```bash
# Full deploy pipeline
pit1 deploy ./myapp
pit1 deploy ./myapp --budget "$10" --yes
pit1 deploy ./myapp --provider hetzner --yes
pit1 deploy ./myapp --dry-run         # plan only, no deploy

# Analyze only
pit1 analyze ./myapp

# Recommend only (no deploy)
pit1 recommend ./myapp --budget "$0"

# Show plan + architecture diagram
pit1 plan ./myapp
```

## Flags

| Flag | Description |
|------|-------------|
| `--yes / -y` | Skip approval prompts (use in agentic mode) |
| `--budget` | Monthly budget hint: `$0`, `$10`, `$30`, `unlimited` |
| `--provider` | Force a provider: `aws`, `gcp`, `hetzner`, `vultr`, `oracle`, `vercel` |
| `--dry-run` | Analyze & recommend without executing |
| `--output json` | Machine-readable JSON output |

## Provider routing logic

| Project type | Provider | Strategy |
|---|---|---|
| Static site | Vercel / GitHub Pages / S3 | Direct deploy |
| Dynamic app, budget $0 | Oracle Free Tier | Browser automation |
| Dynamic app, cheap | Hetzner, Vultr, DigitalOcean | REST API direct |
| Dynamic app, any budget | AWS, GCP, Azure | Terraform |

## How to install pit1 before using

If `pit1` is not found, install it first:
```bash
cd /path/to/pit1-repo
pip install -e .
# or
pip install typer rich anthropic
```

## Agentic usage rules

- Always use `--yes` flag when running non-interactively (Claude Code context)
- Use `--dry-run` first for unfamiliar projects to preview the plan
- Use `--output json` when you need to parse the result programmatically
- If the user hasn't specified a budget, ask before deploying (cost matters)
- After deploy, check `outputs` in the result for endpoint URLs

## Output schema (JSON mode)

```json
{
  "status": "success | dry_run | cancelled | error",
  "analysis": {
    "runtime": "node | python | static | ...",
    "framework": "next | django | ...",
    "databases": ["postgres"],
    "suggested_components": ["app_server", "managed_postgres"]
  },
  "recommendation": {
    "vendor": "hetzner",
    "tier": "CX11",
    "estimated_cost": "$10",
    "deploy_method": "api_direct"
  },
  "outputs": {
    "endpoint": "https://...",
    "ip": "1.2.3.4"
  }
}
```

## cmux pane behavior

When running inside cmux, pit1 opens these panes automatically:
- `🔍 Analyzer` — runtime/framework/DB detection
- `📐 Architect` — vendor + cost recommendation  
- `🏗️ Generator` — Terraform / Dockerfile generation
- `⚡ Executor` — actual deployment
- `👁 Observer` — health checks + endpoint verification

Do not manually open browser or panes — pit1 handles this via `cmux new-pane`.
