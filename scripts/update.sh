#!/usr/bin/env bash

# JFStack
# https://www.jfstack.es
# https://github.com/JFStackes
# Project: Docker Compose Hardening

set -Eeuo pipefail

project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$project_dir"

docker compose pull
# Verificar la imagen descargada antes de sustituir el contenedor existente.
docker compose run --rm --no-deps --entrypoint /usr/local/bin/jfstack-entrypoint wordpress --check-php \
  || { echo 'La imagen descargada no contiene PHP 8.3.36 o posterior. No se ha actualizado el stack.' >&2; exit 1; }
docker compose up -d --remove-orphans
docker compose ps
