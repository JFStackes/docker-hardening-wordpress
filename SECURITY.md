# Política de seguridad del stack WordPress

## Notificación de vulnerabilidades

No abras una incidencia pública que contenga credenciales, URLs privadas, logs con datos personales o una vulnerabilidad explotable. Comunícala de forma privada al propietario del repositorio mediante la función de notificación privada de vulnerabilidades de GitHub cuando esté disponible.

## Consideraciones de despliegue

- No versionar `.env`, `secrets/*.txt`, backups ni volcados de bases de datos.
- No publicar nunca MariaDB. WordPress se publica en loopback por defecto; si se usa una IP privada, protégela con un firewall y permite el acceso únicamente desde el proxy.
- Permitir que únicamente el proxy inverso alcance WordPress, mediante la red externa compartida, loopback o una IP privada restringida por firewall.
- Mantener MariaDB exclusivamente en la red interna `backend`.
- Mantener actualizados Docker, Compose, el sistema operativo del host, las imágenes, WordPress, temas y plugins.
- Descargar imágenes de nuevo y verificar la versión real de PHP; el mínimo 8.3.36 cubre CVE-2026-109618 y CVE-2026-109619, no avisos posteriores. El núcleo WordPress persistente se actualiza por separado.
- Revisar cualquier capacidad Linux añadida, bind mount o cambio en `security_opt`.
- Guardar copias cifradas fuera del VPS y probar la restauración periódicamente.
- Si un plugin requiere una función PHP deshabilitada, habilitar únicamente esa función después de revisar por qué es necesaria.

## Material sensible

No se versionan `.env` ni sus variantes, `secrets/*.txt`, certificados o claves privadas, uploads, exports, dumps ni copias de seguridad. Las plantillas conservadas en Git deben contener solo valores ficticios.
