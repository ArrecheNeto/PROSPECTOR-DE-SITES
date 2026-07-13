---
description: Publica as páginas redesenhadas no Cloudflare Pages e retorna as URLs públicas
argument-hint: "[nome do cliente ou todos]"
---

Publique páginas no Cloudflare Pages seguindo a skill `deploy-cloudflare`.

## Passos

1. Leia `prospector-config.json`. Se o bloco `cloudflare` não estiver preenchido (accountId + apiToken), oriente o usuário a preencher na aba Configurações do dashboard (o token nunca passa pelo chat) — não prossiga sem eles.
2. Determine o que publicar: `$ARGUMENTS` (um cliente ou "todos"), ou liste as páginas com status `redesenhado` em `leads.md` e pergunte.
3. **Gere a página-capa de cada cliente**: preencha `references/capa-proposta-template.html` (skill `proposta-email`) com os dados do lead + assinatura do config e salve como `sites/[slug]/proposta.html`. É ela que vai no e-mail de proposta.
4. **Monte a pasta `publicar/`** (espelho do site — skill `deploy-cloudflare`): copie `sites/[slug]/[slug].html` → `publicar/[slug]/index.html` e `sites/[slug]/proposta.html` → `publicar/[slug]/proposta.html` de cada cliente do lote, SEM apagar pastas de clientes já publicados (o deploy sobe a pasta inteira).
5. **Publique seguindo a skill `deploy-cloudflare`**, nesta ordem: wrangler direto do sandbox (Método 1, silencioso — token via variável de ambiente, nunca exibido); se a rede/npx falhar, script local `publicar-agora` (Método 2, requer Node.js); último recurso, upload pelo navegador (Método 3).
6. **Verificação (bloqueante)**: abra cada URL `https://[urlBase]/[slug]/` e a capa `.../proposta.html` e confirme que carregam com o conteúdo certo. HTTPS é automático no Cloudflare.
7. Atualize `leads.md` e o banco do dashboard: status `publicado` + URL pública nova.

## Saída

Liste, por cliente: URL da página nova e URL da capa (`.../proposta.html`), ambas testadas. Sugira o próximo passo: `/proposta` para enviar os e-mails.
