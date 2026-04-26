# /pit1:plan

Show the full infrastructure plan without deploying.

## Usage

```
/pit1:plan [path] [--budget $N]
```

## What this does

Runs `pit1 plan` — analyze + recommend + show architecture diagram. Nothing is deployed.

## Instructions for Claude

Run: `pit1 plan <path> --output json`

Show the user:
1. Detected project type
2. Recommended vendor and tier
3. Estimated monthly cost
4. Architecture components
5. Deployment method that would be used (Terraform / API / browser)

Ask: "Would you like to deploy this plan?"
