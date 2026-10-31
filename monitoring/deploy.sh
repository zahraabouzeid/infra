#!/bin/sh
set -eu
cd "$(dirname "$0")"
docker compose pull --quiet
# Alloy reads its configuration at start, and the deploy replaces the mounted file.
docker compose up --detach --force-recreate
docker image prune --force
