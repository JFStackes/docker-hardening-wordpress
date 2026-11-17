#!/usr/bin/env bash
set -Eeuo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

case "${1:-}" in
  build) docker compose build ;;
  start) docker compose up -d --build ;;
  stop) docker compose stop ;;
  restart) docker compose restart ;;
  status|ps) docker compose ps ;;
  logs) docker compose logs --follow --tail=100 ;;
  delete) docker compose down --rmi local --remove-orphans ;;
  *) echo "Uso: $0 {build|start|stop|restart|status|ps|logs|delete}" >&2; exit 2 ;;
esac
