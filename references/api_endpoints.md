# OpenHAB 4.3.1 REST API Endpoints (Read-Only)

## Items
- /rest/items/{itemName} : Get state (e.g., "ON" for switch).
- /rest/items : List all items.

## Events
- /rest/events : Stream recent events.

## Persistence
- /rest/persistence/items/{itemName} : Get historic data (add ?time=... for range).

Examples:
- curl ... /rest/items/Kitchen_Temp → {"state": "22.5"}
- For full docs, reference official: https://www.openhab.org/docs/interfaces/rest.html
