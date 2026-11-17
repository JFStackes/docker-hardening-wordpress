param([Parameter(Mandatory=$true, Position=0)][string]$Action)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
switch ($Action) {
    'build'   { docker compose build }
    'start'   { docker compose up -d --build }
    'stop'    { docker compose stop }
    'restart' { docker compose restart }
    'status'  { docker compose ps }
    'ps'      { docker compose ps }
    'logs'    { docker compose logs --follow --tail=100 }
    'delete'  { docker compose down --rmi local --remove-orphans }
    default   { Write-Error 'Uso: deploy.ps1 {build|start|stop|restart|status|ps|logs|delete}'; exit 2 }
}
exit $LASTEXITCODE
