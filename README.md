**Important Disclaimer**: This is **Alpha-level** software and has not been tested in production environments. This has not passed a security audit either. It is provided as-is for experimental purposes. Use at your own risk—thoroughly review and test before deploying, especially in a home automation setup. Potential issues could include API incompatibilities, network errors, or unhandled edge cases. Contributions and feedback are welcome!

# OpenHAB Reader Skill for OpenClaw

## Overview

This is an integration skill for OpenClaw, designed specifically for read-only interactions with OpenHAB version 4.3.1 smart home servers. You need a running openHAB server to properly use this skill in openClaw. The skill is only allows querying data such as item states, events, rules, or sensor readings from a local/home network OpenHAB instance (e.g., running on a Raspberry Pi).

The skill emphasizes security and minimalism: it restricts operations to GET requests only (no writes or controls), prompts for credentials each time, and requires explicit user approvals for executions. It was created using OpenClaw's skill-creator tool, based on the official OpenHAB REST API documentation.

## Features
- Query item states (e.g., "What's the living room temperature?").
- Fetch recent events or persistence data.
- Secure, local-network focused (rejects public URLs).
- Built-in script for safe API calls.
- On-demand reference loading to keep context efficient.

## Installation and Usage
1. **Prerequisites**: OpenClaw installed, with access to `exec` tool and curl. Your OpenHAB server must be reachable (e.g., via VPN if remote).
2. **Setup in OpenClaw**: Copy this folder to `~/.openclaw/workspace/skills/openhab-reader/`. OpenClaw will auto-detect it.
3. **Configuration**: Set environment variables (e.g., `export OPENHAB_URL=http://your-rpi-ip:8080` and `export OPENHAB_TOKEN=your-api-key`). The skill prompts if missing.
4. **Example Query**: In OpenClaw, ask: "Get the kitchen light status from OpenHAB." The agent will use the skill to fetch and summarize.
5. **Testing**: Run manually with the script: `./scripts/query_openhab.sh --endpoint "/rest/items/Kitchen_Light" --url "$OPENHAB_URL" --token "$OPENHAB_TOKEN"`.

For full integration details, see SKILL.md.

## Files Overview
This section lists all three files in the skill, including their names and detailed descriptions of what they do.

### SKILL.md
The core file defining the skill's metadata and instructions. It includes:
- YAML frontmatter with the skill name and description (used by OpenClaw for triggering).
- Workflow guidelines: Step-by-step on confirming config, validating requests, executing queries, handling errors, and responding.
- Security rules: Mandates no credential storage, user approvals for exec, local-network restrictions, and logging without sensitive data.
- Advanced notes: References loading other files only when needed (e.g., for complex queries).
This file is loaded by OpenClaw agents when the skill triggers, keeping it concise for efficiency.

### scripts/query_openhab.sh
A Bash script for performing safe, read-only GET requests to the OpenHAB REST API. Key details:
- Parameters: Accepts `--endpoint` (API path, e.g., "/rest/items/ItemName"), `--url` (base server URL), and `--token` (auth bearer token).
- Safety features: Enforces GET only, warns on HTTP (prefers HTTPS), and includes basic error handling (e.g., missing params).
- Usage: Executed via OpenClaw's `exec` tool with approvals. Outputs JSON responses for parsing.
