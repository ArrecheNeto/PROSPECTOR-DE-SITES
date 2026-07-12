---
name: deploy-cloudflare
description: Esta skill deve ser usada ao publicar páginas no Cloudflare Pages — deploy via wrangler direto do sandbox, criação do projeto, verificação da URL pública e HTTPS. Acione quando o usuário disser "publicar", "subir o site", "colocar no ar", "deploy", "cloudflare" ou rodar /publicar ou o teste de conexão do /setup.
---

# Deploy no Cloudflare Pages

Publicar páginas num projeto único do Cloudflare Pages e garantir a URL pública `https://[urlBase]/[slug]/` funcionando. HTTPS é automático no Cloudflare — todo `*.pages.dev` e todo domínio conectado já sai com certificado válido.

## Credenciais e config

Tudo vem de `prospector-config.json` (bloco `cloudflare`):

- `accountId` — ID da conta (dashboard do Cloudflare → barra lateral direita da visão geral, ou na URL `dash.cloudflare.com/[accountId]`).
- `apiToken` — token de API **escopado**: criado em dash.cloudflare.com/profile/api-tokens → Create Token → permissão **Cloudflare Pages: Edit** (só isso). Nunca usar a Global API Key.
- `projeto` — nome do projeto Pages (padrão `prospector`). Vira o subdomínio público: `https://[projeto].pages.dev`.
- `dominio` — domínio próprio conectado ao projeto (opcional; vazio = usar `[projeto].pages.dev`).

**O token vive SÓ nesse arquivo, no computador do usuário — nunca é digitado no chat, nunca aparece em saída, log ou comando exibido.** Leia-o via script (variável de ambiente), jamais interpolado em comando mostrado ao usuário. Se estiver vazio, oriente: dashboard → aba Configurações → Conexão Cloudflare → colar Account ID e token e salvar (ou editar o arquivo na mão). Nunca pelo chat.

`urlBase` = `dominio` se preenchido, senão `[projeto].pages.dev`.

## Estrutura de publicação

A pasta `publicar/` na raiz da pasta conectada é o ESPELHO do site público — um deploy sobe a pasta INTEIRA (deploy é atômico: o que não estiver na pasta sai do ar):

```
publicar/
  index.html            ← página raiz neutra (crie uma vez: em branco ou logo do usuário)
  [slug]/index.html     ← página redesenhada do cliente
  [slug]/proposta.html  ← página-capa (antes/depois)
```

Antes de cada deploy, copie os arquivos novos de `sites/[slug]/` para `publicar/[slug]/` (a página vira `index.html`). NUNCA apague pastas de clientes já publicados — deploy parcial derruba os antigos.

## Método 1 — wrangler direto do sandbox (padrão, silencioso)

A API do Cloudflare é HTTPS puro — funciona do sandbox, sem instalar nada na máquina do usuário.

```bash
python3 - <<'EOF'  # gera env sem expor o token
import json, os, subprocess
cfg = json.load(open('CAMINHO/prospector-config.json'))['cloudflare']
env = dict(os.environ, CLOUDFLARE_API_TOKEN=cfg['apiToken'], CLOUDFLARE_ACCOUNT_ID=cfg['accountId'])
r = subprocess.run(['npx', '--yes', 'wrangler', 'pages', 'deploy', 'CAMINHO/publicar',
                    '--project-name', cfg.get('projeto', 'prospector'), '--branch', 'main',
                    '--commit-dirty=true'], env=env, capture_output=True, text=True)
print(r.stdout[-2000:]); print(r.stderr[-2000:])
EOF
```

- **Projeto ainda não existe** (`Project not found`): crie uma vez com `npx wrangler pages project create [projeto] --production-branch=main` (mesmas variáveis de ambiente) e repita o deploy.
- **Erro de autenticação (10000/8000x)**: token sem a permissão Pages:Edit ou accountId errado — oriente a refazer o token pelo dashboard (aba Configurações).
- Se a rede do sandbox bloquear ou `npx` não existir, caia SEM DRAMA para o Método 2.

## Método 2 — Script local (fallback)

Requer Node.js na máquina do usuário (nodejs.org, instalação padrão). Garanta `publicar-agora.ps1` + `publicar-agora.bat` (Windows) ou `publicar-agora.command` (Mac; rode `chmod +x` ao copiar) de `references/` desta skill na pasta conectada. Um duplo clique lê o config, roda o wrangler e mostra o resultado — log em `publicador-log.txt`. Se o Windows/macOS bloquear o script baixado (SmartScreen/Gatekeeper), oriente: botão direito → Propriedades → Desbloquear (Windows) ou botão direito → Abrir (Mac), só na primeira vez.

## Método 3 — Navegador (último recurso)

dash.cloudflare.com → Workers & Pages → [projeto] → Create deployment → upload da pasta `publicar/` arrastando. O USUÁRIO faz o login dele (nunca peça senha/token no chat); você navega e confere via Claude in Chrome.

## Verificação (obrigatória, após qualquer método)

1. Abra `https://[urlBase]/[slug]/` e a capa `.../proposta.html` — confirme que carregam com o conteúdo certo (o deploy propaga em segundos; se der 404, aguarde ~30s e tente 1 vez de novo).
2. HTTPS é automático no Cloudflare — se algo carregar sem cadeado, a URL está errada (confira `urlBase`).
3. Atualize `leads.md` + banco/dashboard com status `publicado` e a URL.

## Domínio próprio (opcional, recomendado quando escalar)

`[projeto].pages.dev` é apresentável (curto, HTTPS, sem números aleatórios) e serve para as primeiras propostas. Para domínio próprio: registre (registro.br) → Cloudflare → Workers & Pages → [projeto] → Custom domains → adicionar. Depois preencha `dominio` nas Configurações do dashboard — as próximas propostas já saem com ele.

## Teste de conexão do /setup

Publique `publicar/teste/index.html` simples ("Funcionou!") pelo Método 1 e entregue a URL `https://[urlBase]/teste/` ao usuário. Se o sandbox bloquear, copie os scripts do Método 2 para a pasta e peça o duplo clique — o usuário aprende o fluxo de fallback logo no setup.
