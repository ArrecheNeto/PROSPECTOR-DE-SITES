# Prospector de Sites

Plugin para Claude (Cowork / Claude Code) que roda o ciclo completo de prospecção e venda de sites:

**Achou → Refez → Publicou → Ofertou.**

1. `/setup` — configura tudo uma única vez (assinatura, nichos, conexão com o Cloudflare).
2. `/prospectar` — varre o Google Maps atrás de negócios bem avaliados (nota ≥ 4.7) com site ruim e e-mail público, e salva os leads numa planilha do Google Sheets + dashboard local.
3. `/redesenhar` — recria as páginas dos leads com estética premium e regras anti-AI-slop: conteúdo real aprimorado, fotos e logo originais, seções novas relevantes. Gera junto o editor visual e o comparador antes/depois.
4. `/editor` — edita textos e imagens da página direto no navegador e exporta a versão final.
5. `/publicar` — sobe as páginas no Cloudflare Pages (HTTPS automático) e devolve as URLs públicas.
6. `/proposta` — escreve o e-mail de proposta (rapport real, sem preço), passa pela checklist anti-spam e cria o rascunho no seu e-mail (Gmail ou iCloud Mail, inclusive domínio próprio via iCloud+).
7. `/respostas` — verifica no seu e-mail quem respondeu e atualiza o dashboard.
8. `/followup` — lembrete gentil para propostas paradas há 3+ dias (1 por lead, nunca repete).
9. `/contrato` — gera a minuta do contrato (folha imprimível + Word travado) do cliente que fechou e deixa o rascunho no e-mail.

## Como instalar

No Claude Code:

```
/plugin marketplace add felipemazetti/PROSPECTOR-DE-SITES
/plugin install prospector-de-sites@arrecheneto-plugins
```

No Claude Cowork (desktop): Configurações → Plugins → Adicionar marketplace → cole a URL deste repositório → instale o **prospector-de-sites**.

### Usar no OpenAI Codex (CLI/IDE/app)

Este repositório é um plugin **dual**: os mesmos manifestos servem Claude e Codex. A pasta `prospector-de-sites/` tem os dois manifestos (`.claude-plugin/` e `.codex-plugin/`), e a raiz tem os dois catálogos de marketplace (`.claude-plugin/marketplace.json` e `.agents/plugins/marketplace.json`).

**Como plugin (recomendado):** no Codex, adicione este repositório pelo `/plugins` (marketplace Git) e instale o **prospector-de-sites**. As 7 skills de conhecimento entram sozinhas e são invocáveis por `$prospeccao-maps`, `$redesign-premium`, `$deploy-cloudflare` etc. — ou simplesmente descrevendo a tarefa (ex.: "prospectar nutricionistas em Campinas").

**Atalhos de comando (opcional):** se preferir os atalhos explícitos `$prospectar`, `$publicar`, `$proposta` etc., rode também o instalador — ele adiciona esses comandos em `~/.agents/skills`:

```
git clone https://github.com/felipemazetti/PROSPECTOR-DE-SITES
bash PROSPECTOR-DE-SITES/codex/instalar-codex.sh
```

Em qualquer caso, copie `codex/AGENTS-modelo.md` para a sua pasta de trabalho como `AGENTS.md` — ele adapta o fluxo ao Codex.

**No Codex**: com a extensão **Codex for Chrome** (`@Chrome`) habilitada no app do Codex, o ciclo fica quase completo — prospecção no Google Maps real e e-mail no seu webmail logado (Gmail ou icloud.com/mail), como no Claude. No Mac, o **Computer Use** (`@Computer Use`) é alternativa para rascunhos direto no Apple Mail. Sem essas ferramentas (Codex CLI puro): a prospecção usa a skill `prospeccao-web` (pesquisa assistida via busca web, sem inventar dado não verificado) e os e-mails saem prontos em `emails-prontos/` para copiar e colar. Redesign, deploy no Cloudflare, dashboard e contratos funcionam integralmente em qualquer modo.

## Requisitos

- Claude Cowork (ou Claude Code) com extensão Claude in Chrome conectada
- E-mail: conector do Gmail OU conta do iCloud Mail (via navegador, sem senha no chat) · conector do Google Drive
- Uma pasta conectada no Cowork (config, leads e sites ficam nela)
- Conta no Cloudflare (plano grátis) com um token de API escopado para o Pages

## Segurança

O token de API do Cloudflare nunca é digitado no chat: você o cola na aba Configurações do dashboard local (ou direto no `prospector-config.json`), que fica somente no seu computador. O token é escopado — só tem a permissão **Cloudflare Pages: Edit**, nada mais da sua conta.

---

Criado por [Helio Arreche](https://github.com/ArrecheNeto) · adaptado neste fork para publicação via Cloudflare Pages
