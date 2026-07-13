#!/bin/bash
# Prospector de Sites — instalador manual para OpenAI Codex (CLI/IDE)
#
# OPCIONAL: só precisa disto se quiser as skills-comando explícitas ($prospectar,
# $publicar etc.). O jeito recomendado é instalar como PLUGIN (adicionar o repo pelo
# /plugins do Codex) — aí as 7 skills de conhecimento entram sozinhas. Este script
# adiciona, por cima, os atalhos de comando em ~/.agents/skills.
#
# Uso: bash codex/instalar-codex.sh   (ou duplo clique no instalar-codex.command)
set -e
REPO="$(cd "$(dirname "$0")/.." && pwd)"
PLUGIN="$REPO/prospector-de-sites"
DESTINO="$HOME/.agents/skills"
mkdir -p "$DESTINO"

echo "Prospector de Sites → Codex"
echo "Instalando skills em $DESTINO"

# 1. Skills de conhecimento (mesmo formato SKILL.md — copiadas como estão)
for skill in "$PLUGIN"/skills/*/; do
  nome="$(basename "$skill")"
  rm -rf "$DESTINO/$nome"
  cp -R "$skill" "$DESTINO/$nome"
  echo "  ✓ skill $nome"
done

# 2. Comandos → skills executáveis (frontmatter name/description + corpo adaptado)
for cmd in "$PLUGIN"/commands/*.md; do
  base="$(basename "$cmd" .md)"
  nome="$base"; [ "$base" = "setup" ] && nome="prospector-setup"
  desc="$(awk -F': ' '/^description:/{print substr($0, index($0,": ")+2); exit}' "$cmd")"
  dir="$DESTINO/$nome"
  rm -rf "$dir"; mkdir -p "$dir"
  {
    echo "---"
    echo "name: $nome"
    echo "description: $desc. Acione quando o usuário pedir \"$base\" ou invocar \$$nome."
    echo "---"
    # corpo sem o frontmatter original; $ARGUMENTS vira instrução em linguagem natural
    awk 'BEGIN{fm=0} /^---$/{fm++; next} fm>=2{print}' "$cmd" \
      | sed 's/`\$ARGUMENTS`/os argumentos que o usuário escreveu junto da invocação/g; s/\$ARGUMENTS/os argumentos que o usuário escreveu junto da invocação/g'
  } > "$dir/SKILL.md"
  echo "  ✓ comando /$base → \$$nome"
done

# 3. AGENTS.md modelo para a pasta de trabalho
cp "$REPO/codex/AGENTS-modelo.md" "$DESTINO/../AGENTS-prospector-modelo.md" 2>/dev/null || true

echo ""
echo "Pronto! No Codex, digite /skills para conferir, e use por exemplo:"
echo "  \$prospector-setup           → configuração inicial"
echo "  \$prospectar nutricionistas em Campinas"
echo "  \$redesenhar · \$publicar · \$proposta · \$respostas · \$followup · \$contrato"
echo ""
echo "IMPORTANTE: copie codex/AGENTS-modelo.md do repositório para a sua pasta"
echo "de trabalho (a mesma do prospector-config.json) com o nome AGENTS.md —"
echo "ele explica ao Codex o contexto e as limitações fora do Claude."
