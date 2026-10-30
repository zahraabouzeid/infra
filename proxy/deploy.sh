#!/bin/sh
set -eu
cd "$(dirname "$0")"
docker network inspect web > /dev/null 2>&1 || docker network create web
docker compose pull --quiet
docker compose up --detach
reload() {
  docker compose exec -T caddy caddy reload --config /etc/caddy/Caddyfile
}
# A container that was just recreated needs a moment before it accepts a reload.
reload || { sleep 5; reload; }
docker image prune --force
