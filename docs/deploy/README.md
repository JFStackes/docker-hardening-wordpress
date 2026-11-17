# Operación del despliegue

Desde la raíz del repositorio, ejecuta primero `./scripts/init.sh` en Linux y configura `.env`, los secretos y la red del proxy como se explica en el [README](../../README.md). Se necesitan Docker Compose 2.24.4 o posterior y acceso al daemon. Los scripts de inicialización y copia requieren Linux; el wrapper PowerShell solo gestiona Compose y no sustituye esos requisitos.

`./deploy.sh` o `./deploy.ps1` aceptan `build`, `start`, `stop`, `restart`, `status` (o `ps`), `logs` y `delete`. `logs` sigue las últimas 100 líneas. `delete` elimina los contenedores del proyecto, pero conserva volúmenes, secretos y configuración. No ejecuta un borrado global.

Los comandos nativos `docker compose config --quiet`, `docker compose up -d` y `docker compose ps` se ejecutan desde la raíz y usan el mismo `.env` y proyecto. El modo de red se configura en `.env`; no hay que seleccionar otro archivo Compose. No cambies el nombre de proyecto ni los volúmenes al actualizar.

Para actualizar, comprobar la versión de PHP, gestionar el núcleo persistente de WordPress y restaurar una copia, sigue los apartados de actualización y copias del [README](../../README.md). Prueba toda restauración en un entorno aislado antes de sustituir datos reales.
