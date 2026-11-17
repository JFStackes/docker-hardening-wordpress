# Ejemplos opcionales de proxy para WordPress

Estos fragmentos son configuraciones de proxy externas a Compose. Sustituye dominio, red y política TLS según tu infraestructura. El proxy debe ser el único origen que pueda alcanzar WordPress.

## Nginx en el host

Con `PUBLISH_IP=127.0.0.1`:

```nginx
location / {
    proxy_pass http://127.0.0.1:8080;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Proto https;
}
```

Configura TLS en el `server`, reemplaza cabeceras reenviadas del cliente y ajusta límites de subida de forma coherente con PHP.

## Caddy en el host

```caddyfile
wordpress.example.com {
    reverse_proxy 127.0.0.1:8080
}
```

Caddy gestiona HTTPS y cabeceras reenviadas de forma predeterminada. Declara proxies de confianza si hay CDN u otra capa por delante.

## Traefik como contenedor

Configura `PROXY_NETWORK_EXTERNAL=true` y conecta Traefik a `PROXY_NETWORK`. Un archivo dinámico puede usar:

```yaml
http:
  routers:
    wordpress:
      rule: Host(`wordpress.example.com`)
      entryPoints: [websecure]
      tls: {}
      service: wordpress
  services:
    wordpress:
      loadBalancer:
        servers:
          - url: http://wordpress:80
```

No se requieren labels, entrypoints o resolvers con nombres concretos. Si Traefik obtiene la configuración desde Docker, añade tus propias labels en tu propia configuración local de Compose.
