#!/bin/sh
set -eu

# La etiqueta de la imagen es mutable: impedir el arranque con PHP anterior
# a las correcciones de CVE-2026-109618 y CVE-2026-109619.
if ! php -r 'exit(PHP_MAJOR_VERSION === 8 && PHP_MINOR_VERSION === 3 && version_compare(PHP_VERSION, "8.3.36", ">=") ? 0 : 1);'; then
  echo 'PHP no cumple el mínimo requerido (8.3.36 de la rama 8.3). Descarga una imagen actualizada antes de iniciar WordPress.' >&2
  exit 1
fi

if [ "${1:-}" = "--check-php" ]; then
  exit 0
fi

exec /usr/local/bin/docker-entrypoint.sh "$@"
