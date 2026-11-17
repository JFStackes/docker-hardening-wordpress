# Guía del repositorio

- Lee [README.md](README.md) para configuración, migración, seguridad y copias; la operación de Compose está en [docs/deploy/README.md](docs/deploy/README.md).
- `compose.yaml` es la única definición del stack. Conserva el nombre de proyecto, los volúmenes, los secretos y la compatibilidad con ambas modalidades de proxy.
- `config/` contiene ajustes de servicios; `scripts/` contiene inicialización, backup, actualización y el control de PHP. Los wrappers de operación están en la raíz.
- Valida `docker compose config --quiet` con red externa y con `PROXY_NETWORK_EXTERNAL=false`, y la sintaxis de `deploy.sh` y `scripts/*.sh`. Utiliza un proyecto y volúmenes aislados para las pruebas de arranque.
- No incluyas `.env`, secretos, copias ni datos de usuarios en Git; no elimines datos persistentes durante las pruebas o el despliegue.
