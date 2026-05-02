#!/bin/sh
set -e

OPTIONS_FILE="/data/options.json"

# Read user-configured options
if [ -f "$OPTIONS_FILE" ]; then
    APP_KEY=$(jq -r '.app_key // empty' "$OPTIONS_FILE")
    APP_URL=$(jq -r '.app_url // empty' "$OPTIONS_FILE")
    PROXY_REFRESH=$(jq -r '.proxy_refresh_minutes // 15' "$OPTIONS_FILE")

    [ -n "$APP_KEY" ] && export APP_KEY
    [ -n "$APP_URL" ]  && export APP_URL
    export TRMNL_PROXY_REFRESH_MINUTES="$PROXY_REFRESH"
fi

export PHP_OPCACHE_ENABLE=1

# --- Persistent storage via symlinks into /data ---

# Database: /var/www/html/database/storage -> /data/db
mkdir -p /data/db
if [ -d /var/www/html/database/storage ] && [ ! -L /var/www/html/database/storage ]; then
    cp -r /var/www/html/database/storage/. /data/db/ 2>/dev/null || true
    rm -rf /var/www/html/database/storage
fi
ln -sfn /data/db /var/www/html/database/storage

# Generated images: /var/www/html/storage/app/public/images/generated -> /data/images
mkdir -p /data/images
mkdir -p /var/www/html/storage/app/public/images
if [ -d /var/www/html/storage/app/public/images/generated ] && [ ! -L /var/www/html/storage/app/public/images/generated ]; then
    cp -r /var/www/html/storage/app/public/images/generated/. /data/images/ 2>/dev/null || true
    rm -rf /var/www/html/storage/app/public/images/generated
fi
ln -sfn /data/images /var/www/html/storage/app/public/images/generated

# Hand off to the original container entrypoint
exec /usr/local/bin/start-container
