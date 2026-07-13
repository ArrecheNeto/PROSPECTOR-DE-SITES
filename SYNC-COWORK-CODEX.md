# ⚠️ REGRA DE MANUTENÇÃO — DOIS ALVOS SEMPRE EM SINCRONIA

O **Prospector de Sites** roda em DUAS plataformas de plugin. Toda alteração de skill,
comando, template ou versão DEVE ser aplicada e publicada valendo para as DUAS.

## Os dois alvos

1. **Claude (Cowork / Claude Code)**
   - Manifesto do plugin: `prospector-de-sites/.claude-plugin/plugin.json`
   - Catálogo de marketplace: `.claude-plugin/marketplace.json` (raiz do repo)
   - Instala: adicionar o repo pela URL no Cowork, ou `/plugin marketplace add felipemazetti/PROSPECTOR-DE-SITES`.

2. **OpenAI Codex (CLI / IDE / app)** — mesmo padrão de skills (agentskills.io)
   - Manifesto do plugin: `prospector-de-sites/.codex-plugin/plugin.json` (aponta `"skills": "./skills/"`).
   - **Catálogo de marketplace (Git):** `.agents/plugins/marketplace.json` na RAIZ do repo (aponta `./prospector-de-sites`). Sem ele o Codex recusa com *"marketplace root does not contain a supported manifest"*.
   - Instala como plugin: adicionar o repo via `/plugins` (marketplace Git) no Codex.
   - Extra opcional: `codex/instalar-codex.sh` adiciona os atalhos de comando (`$prospectar`, `$publicar`…) em `~/.agents/skills`; e copie `codex/AGENTS-modelo.md` para a pasta de trabalho como `AGENTS.md`.

## Fonte única (não duplicar conteúdo)

A MESMA pasta `prospector-de-sites/` serve os dois — ela tem os DOIS manifestos
(`.claude-plugin/` e `.codex-plugin/`) e compartilha:
- `skills/*/SKILL.md` (as 7 skills, incluindo `prospeccao-web` para quando não há navegador automatizado)
- `skills/*/references/*` e `skills/*/assets/*`
- `commands/*.md` (comandos-slash do Claude; no Codex viram atalhos via `instalar-codex.sh`)

## Checklist ao atualizar QUALQUER coisa

1. Edite a skill / comando / template UMA vez na pasta `prospector-de-sites/`.
2. Suba a versão nos QUATRO arquivos, mantendo o número igual:
   - `prospector-de-sites/.claude-plugin/plugin.json`
   - `prospector-de-sites/.codex-plugin/plugin.json`
   - `.claude-plugin/marketplace.json`
   - `prospector-de-sites/manual.html` (badge de versão)
   (`.agents/plugins/marketplace.json` do Codex não versiona por plugin — não precisa mexer.)
3. Registre no `CHANGELOG.md`.
4. Commit + push no GitHub (vale para Cowork e Codex).

## Como quem já instalou atualiza

- **Cowork**: botão de atualizar/refresh nas configurações de plugins.
- **Claude Code**: `/plugin marketplace update`.
- **Codex**: atualizar o marketplace pelo `/plugins` (ou re-adicionar o repo).
