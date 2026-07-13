#!/bin/bash
# Prospector de Sites — publica a fila na HostGator (Mac).
# Manual: duplo clique. Automatico (launchd): chamado com --auto (log em publicador-log.txt, sem pause).
cd "$(dirname "$0")"
AUTO=0; [ "$1" = "--auto" ] && AUTO=1
log(){ if [ $AUTO -eq 1 ]; then echo "[$(date '+%d/%m %H:%M:%S')] $1" >> publicador-log.txt; else echo "$1"; fi; }
fim(){ [ $AUTO -eq 0 ] && read -p "Pressione Enter para fechar..."; exit $1; }
[ -f fila-publicacao.txt ] || { [ $AUTO -eq 0 ] && log "Nada na fila — peca /publicar ao Claude primeiro."; fim 0; }
CFG=prospector-config.json
[ -f "$CFG" ] || { log "ERRO: prospector-config.json nao encontrado."; fim 1; }
SRV=$(python3 -c "import json;print(json.load(open('$CFG'))['hostgator'].get('servidor',''))")
[ -n "$SRV" ] || { log "ERRO: preencha a conexao HostGator no dashboard (Configuracoes), incluindo a senha."; fim 1; }
AUTH_CFG=$(mktemp "${TMPDIR:-/tmp}/prospector-curl.XXXXXX") || { log "ERRO: nao consegui proteger as credenciais temporarias."; fim 1; }
chmod 600 "$AUTH_CFG"
trap 'rm -f "$AUTH_CFG"' EXIT HUP INT TERM
if ! python3 - "$CFG" "$AUTH_CFG" <<'PY'
import json, os, sys

config_path, auth_path = sys.argv[1:]
hostgator = json.load(open(config_path, encoding='utf-8')).get('hostgator', {})
usuario = str(hostgator.get('usuario', ''))
senha = str(hostgator.get('senha', ''))
if not usuario or not senha or any(c in usuario + senha for c in '\r\n'):
    raise SystemExit(1)
escape = lambda value: value.replace('\\', '\\\\').replace('"', '\\"')
with open(auth_path, 'w', encoding='utf-8') as auth:
    auth.write('user = "{}:{}"\n'.format(escape(usuario), escape(senha)))
os.chmod(auth_path, 0o600)
PY
then
  log "ERRO: preencha uma conexao HostGator valida no dashboard (Configuracoes)."
  fim 1
fi
OK=0; FALHA=0
while IFS='|' read -r LOCAL REMOTO; do
  LOCAL=$(echo "$LOCAL" | xargs); REMOTO=$(echo "$REMOTO" | xargs)
  [ -z "$LOCAL" ] && continue
  if [ ! -f "$LOCAL" ]; then log "PULOU (nao existe): $LOCAL"; FALHA=$((FALHA+1)); continue; fi
  log "Subindo $LOCAL -> $REMOTO ..."
  if curl --config "$AUTH_CFG" -sS --connect-timeout 20 -T "$LOCAL" "ftp://$SRV/$REMOTO" --ftp-create-dirs; then
    log "  OK"; OK=$((OK+1))
  else
    log "  FALHOU"; FALHA=$((FALHA+1))
  fi
done < fila-publicacao.txt
log "Concluido: $OK enviados, $FALHA falhas."
if [ $FALHA -eq 0 ] && [ $OK -gt 0 ]; then
  mv fila-publicacao.txt "fila-publicada-$(date '+%Y%m%d-%H%M').txt"
  log "Fila concluida. Avise o Claude ('publiquei') para verificar as URLs."
fi
fim 0
