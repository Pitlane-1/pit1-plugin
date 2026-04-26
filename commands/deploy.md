# /pit1:deploy

Deploy the current project using pit1's AI infra pipeline.

## Usage

```
/pit1:deploy [path] [--budget $N] [--provider NAME] [--dry-run]
```

## What this does

Runs `pit1 deploy` on the specified path (default: current directory).

Steps:
1. 🔍 Analyzes your code (runtime, framework, databases)
2. 📐 Recommends optimal cloud vendor + tier + cost
3. 🏗️ Generates Terraform / Dockerfile
4. ✅ Asks for approval (unless `--yes`)
5. ⚡ Deploys and streams progress in cmux panes
6. 👁 Verifies endpoints

## Examples

```bash
pit1 deploy .
pit1 deploy ./myapp --budget "$10" --yes
pit1 deploy ./myapp --provider hetzner --dry-run
```

## Instructions for Claude

When this command is invoked:
1. Check if `pit1` is installed: `which pit1`
2. If not installed, tell the user to run `pip install -e .` in the pit1 repo
3. Detect the project path from context or ask the user
4. If budget not specified, ask the user before deploying
5. Run `pit1 deploy <path> --yes --output json` and parse the result
6. Report the endpoint URL from `outputs.endpoint` on success
