---
name: openhab-reader
description: Read-only integration for OpenHAB 4.3.1 servers. Use to query item states, events, rules, or sensor data from a local/home network OpenHAB instance (e.g., on Raspberry Pi). Triggers on requests like 'What's the temperature in the living room?' or 'Check OpenHAB event logs'—strictly no writes or controls. Assumes secure local access only.
---

# OpenHAB Reader (v1.0.0)

Use this skill to safely read data from OpenHAB 4.3.1 REST API. Restrict to GET requests only. Always verify user intent before querying.

## Quick Start
- Require user-provided config: OPENHAB_URL (e.g., http://192.168.1.100:8080), OPENHAB_TOKEN (API key).
- Use scripts/query_openhab.sh for queries: exec with parameters (e.g., --endpoint "/rest/items/LivingRoom_Temp" --url "$OPENHAB_URL" --token "$OPENHAB_TOKEN").
- Parse JSON responses and summarize for user (e.g., "Temperature: 22°C").

## Workflow
1. Confirm config: If missing, prompt user (e.g., "Provide your OpenHAB URL and token—I'll store securely in env").
2. Validate request: Ensure read-only (reject if implies write, like "turn on").
3. Execute query: Use script with HTTPS if available.
4. Handle errors: Retry on timeouts; report auth failures without leaking details.
5. Respond: Format data clearly (e.g., tables for lists).

## Advanced Queries
- For endpoints/examples, load references/api_endpoints.md only if needed (e.g., complex persistence queries).

## Security Rules (Mandatory)
- Never store creds in files—use env vars or prompt each time.
- Require explicit user approval for each exec (via OpenClaw's elevated/ask mode).
- Limit to local network (reject public URLs).
- Log queries without sensitive data.
