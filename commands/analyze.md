# /pit1:analyze

Analyze the current project's runtime, framework, and infrastructure needs.

## Usage

```
/pit1:analyze [path]
```

## What this does

Runs `pit1 analyze` — detects runtime, framework, databases, and suggested cloud components.
No deployment. Safe to run anytime.

## Instructions for Claude

Run: `pit1 analyze <path> --output json`

Parse and explain the result in plain language:
- What runtime was detected
- What framework
- What databases
- What cloud components are suggested
- Estimated complexity (simple / moderate / complex)
