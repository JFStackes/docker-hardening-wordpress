#!/usr/bin/env bash

# JFStack
# https://www.jfstack.es
# https://github.com/JFStackes
# Project: Docker Compose Hardening

set -Eeuo pipefail

project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$project_dir"

docker compose pull
docker compose up -d --remove-orphans
docker compose ps
