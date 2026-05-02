# LaraPaper Add-on Documentation

Self-hosted [TRMNL](https://usetrmnl.com) dashboard server powered by [LaraPaper](https://github.com/usetrmnl/larapaper).

## Configuration

### Option: `app_key` (required)

The Laravel application encryption key. Generate one with:

```bash
echo "base64:$(openssl rand -base64 32)"
```

Set this before first start. Changing it after installation will invalidate sessions.

### Option: `app_url`

The full base URL of the add-on, e.g. `http://homeassistant.local:4567`. Required if you access LaraPaper from outside your local network or behind a reverse proxy.

### Option: `proxy_refresh_minutes` (default: `15`)

How often (in minutes) LaraPaper polls for TRMNL content updates.

## Ports

| Port | Description |
|------|-------------|
| 4567 | LaraPaper web interface |

## Persistent Data

All persistent data is stored in the add-on's `/data` directory managed by Home Assistant Supervisor:

- `/data/db` — SQLite database
- `/data/images` — Generated dashboard images

## Notes

- The add-on wraps `ghcr.io/usetrmnl/larapaper:latest`.
- If the add-on fails to start, check the log tab — the most common cause is a missing or invalid `app_key`.
