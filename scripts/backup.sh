#!/usr/bin/env bash

# JFStack
# https://www.jfstack.es
# https://github.com/JFStackes
# Project: Docker Compose Hardening

set -Eeuo pipefail

project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
backup_dir="${BACKUP_DIR:-$project_dir/backups}"
retention_days="${BACKUP_RETENTION_DAYS:-14}"
timestamp="$(date -u +'%Y%m%dT%H%M%SZ')"

if [[ ! "$retention_days" =~ ^[0-9]+$ ]]; then
  echo "BACKUP_RETENTION_DAYS debe ser un entero no negativo." >&2
  exit 1
fi

cd "$project_dir"
umask 077
mkdir -p "$backup_dir"
chmod 700 "$backup_dir"

exec 9>"$backup_dir/.backup.lock"
if ! flock -n 9; then
  echo "Ya hay otra copia de seguridad en ejecución." >&2
  exit 1
fi

db_backup="$backup_dir/database-$timestamp.sql.gz"
files_backup="$backup_dir/wordpress-$timestamp.tar.gz"
checksum_file="$backup_dir/backup-$timestamp.sha256"
db_partial="$db_backup.partial"
files_partial="$files_backup.partial"

cleanup() {
  rm -f -- "$db_partial" "$files_partial"
}
trap cleanup EXIT

docker compose exec -T db sh -c \
  'exec mariadb-dump --single-transaction --quick --routines --triggers --events -uroot -p"$(cat /run/secrets/db_root_password)" "$MARIADB_DATABASE"' \
  | gzip -9 > "$db_partial"

docker compose exec -T wordpress \
  tar -czf - -C /var/www/html . > "$files_partial"

gzip -t "$db_partial"
tar -tzf "$files_partial" >/dev/null

mv -- "$db_partial" "$db_backup"
mv -- "$files_partial" "$files_backup"

(
  cd "$backup_dir"
  sha256sum "$(basename -- "$db_backup")" "$(basename -- "$files_backup")" \
    > "$(basename -- "$checksum_file")"
)

find "$backup_dir" -maxdepth 1 -type f \
  \( -name 'database-*.sql.gz' -o -name 'wordpress-*.tar.gz' -o -name 'backup-*.sha256' \) \
  -mtime "+$retention_days" -delete

echo "Copia de seguridad verificada creada:"
echo "  $db_backup"
echo "  $files_backup"
echo "  $checksum_file"
