#!/bin/bash
# Prospector de Sites — publicação no Cloudflare Pages (Mac)
# Uso: duplo clique (requer Node.js — nodejs.org ou brew install node)
cd "$(dirname "$0")"
log(){ echo "[$(date '+%d/%m %H:%M:%S')] $1" | tee -a publicador-log.txt; }
command -v npx >/dev/null 2>&1 || { log "ERRO: Node.js não encontrado. Instale em nodejs.org e tente de novo."; read -p "Enter para fechar..."; exit 1; }
[ -d publicar ] || { log "Nada para publicar — peça /publicar ao Claude primeiro (ele monta a pasta publicar/)."; read -p "Enter para fechar..."; exit 0; }
[ -f prospector-config.json ] || { log "ERRO: prospector-config.json não encontrado."; read -p "Enter para fechar..."; exit 1; }
# token e accountId vão por variável de ambiente — nunca pela linha de comando
eval "$(python3 - <<'EOF'
import json
cf = json.load(open('prospector-config.json')).get('cloudflare', {})
print(f"export CLOUDFLARE_API_TOKEN='{cf.get('apiToken','')}'")
print(f"export CLOUDFLARE_ACCOUNT_ID='{cf.get('accountId','')}'")
print(f"PROJETO='{cf.get('projeto') or 'prospector'}'")
EOF
)"
[ -n "$CLOUDFLARE_API_TOKEN" ] && [ -n "$CLOUDFLARE_ACCOUNT_ID" ] || { log "ERRO: preencha a Conexão Cloudflare (dashboard > Configurações): Account ID e API Token."; read -p "Enter para fechar..."; exit 1; }
log "Publicando a pasta publicar/ no projeto '$PROJETO'..."
npx --yes wrangler pages deploy publicar --project-name "$PROJETO" --branch main --commit-dirty=true || {
  log "Primeiro deploy? Tentando criar o projeto..."
  npx --yes wrangler pages project create "$PROJETO" --production-branch main
  npx --yes wrangler pages deploy publicar --project-name "$PROJETO" --branch main --commit-dirty=true
}
if [ $? -eq 0 ]; then log "OK! Site no ar em https://$PROJETO.pages.dev — avise o Claude ('publiquei') para verificar as URLs."
else log "FALHOU. Confira token/Account ID nas Configurações do dashboard."; fi
read -p "Enter para fechar..."
