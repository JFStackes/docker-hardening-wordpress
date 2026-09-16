# Contribuir a JFStack WordPress

Trabaja desde la raíz de este repositorio independiente y mantén los cambios centrados en WordPress y MariaDB.

## Convenciones

- No incluyas `.env`, secretos, backups, dumps, uploads ni datos persistentes.
- Mantén MariaDB sin puertos publicados.
- Conserva `compose.yaml` sin puertos de host; cualquier publicación debe permanecer en `compose.publish.yaml`.
- No relajes capacidades, `read_only`, redes o configuración PHP/Apache/MariaDB sin documentar la necesidad y el riesgo.
- No cambies imágenes sin revisar compatibilidad, migraciones y notas de seguridad.

## Validación

```bash
cp .env.example .env
printf '%s' 'ci-placeholder' > secrets/db_password.txt
printf '%s' 'ci-placeholder' > secrets/db_root_password.txt
docker compose config --quiet
docker compose -f compose.yaml -f compose.publish.yaml config --quiet
bash -n scripts/*.sh
shellcheck scripts/*.sh
```

Usa únicamente valores ficticios. Explica en el pull request las comprobaciones realizadas y los controles de seguridad afectados. Comunica vulnerabilidades explotables según `SECURITY.md`.
