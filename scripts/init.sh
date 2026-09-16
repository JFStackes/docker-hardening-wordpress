#!/usr/bin/env bash

# JFStack
# https://www.jfstack.es
# https://github.com/JFStackes
# Project: Docker Compose Hardening

set -Eeuo pipefail

project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$project_dir"

umask 077
mkdir -p secrets backups
chmod 700 secrets backups

if [[ ! -f .env ]]; then
  cp .env.example .env
  echo "Creado .env a partir de .env.example"
fi

create_random_secret() {
  local target="$1"
  if [[ ! -s "$target" ]]; then
    openssl rand -base64 48 | tr -d '\n' > "$target"
    echo "Creado $target"
  fi
}

create_random_secret secrets/db_password.txt
create_random_secret secrets/db_root_password.txt
chmod 600 .env secrets/*.txt

echo
echo "Inicialización completada. Revisa .env, elige la modalidad de proxy y valida Compose."
echo "La modalidad base requiere que PROXY_NETWORK ya exista; la publicada no usa esa red."
