# Prospector de Sites — publicação no Cloudflare Pages
# Uso: duplo clique no publicar-agora.bat (requer Node.js instalado — nodejs.org)
$ErrorActionPreference = "Stop"
$pasta = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $pasta
function Log($msg,$cor="Gray"){
  Add-Content "publicador-log.txt" ("[" + (Get-Date -Format "dd/MM HH:mm:ss") + "] " + $msg)
  Write-Host $msg -ForegroundColor $cor
}
if (-not (Get-Command npx -ErrorAction SilentlyContinue)) { Log "ERRO: Node.js nao encontrado. Instale em nodejs.org (instalacao padrao) e tente de novo." "Red"; pause; exit 1 }
if (-not (Test-Path "publicar")) { Log "Nada para publicar - peca /publicar ao Claude primeiro (ele monta a pasta publicar/)." "Yellow"; pause; exit 0 }
try { $cfg = Get-Content "prospector-config.json" -Raw -Encoding UTF8 | ConvertFrom-Json } catch { Log "ERRO: prospector-config.json nao encontrado/invalido." "Red"; pause; exit 1 }
$cf = $cfg.cloudflare
if (-not $cf -or -not $cf.accountId -or -not $cf.apiToken) { Log "ERRO: preencha a Conexao Cloudflare (dashboard > Configuracoes): Account ID e API Token." "Red"; pause; exit 1 }
$projeto = if ($cf.projeto) { $cf.projeto } else { "prospector" }
# token e accountId vao por variavel de ambiente - nunca pela linha de comando
$env:CLOUDFLARE_API_TOKEN = $cf.apiToken
$env:CLOUDFLARE_ACCOUNT_ID = $cf.accountId
Log ("Publicando a pasta publicar/ no projeto '" + $projeto + "'...") "Cyan"
& npx --yes wrangler pages deploy "publicar" --project-name $projeto --branch main --commit-dirty=true
if ($LASTEXITCODE -ne 0) {
  Log "Primeiro deploy? Tentando criar o projeto..." "Yellow"
  & npx --yes wrangler pages project create $projeto --production-branch main
  & npx --yes wrangler pages deploy "publicar" --project-name $projeto --branch main --commit-dirty=true
}
if ($LASTEXITCODE -eq 0) { Log ("OK! Site no ar em https://" + $projeto + ".pages.dev - avise o Claude ('publiquei') para verificar as URLs.") "Green" }
else { Log ("FALHOU (codigo " + $LASTEXITCODE + "). Confira token/Account ID nas Configuracoes do dashboard.") "Red" }
$env:CLOUDFLARE_API_TOKEN = ""; $env:CLOUDFLARE_ACCOUNT_ID = ""
pause
