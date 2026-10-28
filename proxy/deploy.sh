#!/bin/sh
set -eu
cd "$(dirname "$0")"
docker network inspect web > /dev/null 2>&1 || docker network create web
docker compose pull --quiet
docker compose up --detach
docker compose exec caddy caddy reload --config /etc/caddy/Caddyfile
docker image prune --force
