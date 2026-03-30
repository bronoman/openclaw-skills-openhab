#!/bin/bash
# Read-only OpenHAB API query script. Uses curl for GET requests only.

while [[ $# -gt 0 ]]; do
  case $1 in
    --endpoint) ENDPOINT="$2"; shift; shift ;;
    --url) URL="$2"; shift; shift ;;
    --token) TOKEN="$2"; shift; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# Safety checks
if [[ -z "$URL" || -z "$ENDPOINT" ]]; then
  echo "Error: Missing URL or endpoint."; exit 1
fi
if [[ "$URL" =~ ^http:// ]]; then # Prefer HTTPS; warn if not
  echo "Warning: Using HTTP—recommend HTTPS for security."
fi

# Execute safe GET (no writes)
curl -s -X GET -H "Authorization: Bearer $TOKEN" -H "Accept: application/json" "$URL$ENDPOINT" || { echo "Query failed."; exit 1; }
