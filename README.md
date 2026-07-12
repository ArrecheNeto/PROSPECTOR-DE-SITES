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

## Requisitos

- Claude Cowork (ou Claude Code) com extensão Claude in Chrome conectada
- E-mail: conector do Gmail OU conta do iCloud Mail (via navegador, sem senha no chat) · conector do Google Drive
- Uma pasta conectada no Cowork (config, leads e sites ficam nela)
- Conta no Cloudflare (plano grátis) com um token de API escopado para o Pages

## Segurança

O token de API do Cloudflare nunca é digitado no chat: você o cola na aba Configurações do dashboard local (ou direto no `prospector-config.json`), que fica somente no seu computador. O token é escopado — só tem a permissão **Cloudflare Pages: Edit**, nada mais da sua conta.

---

Criado por [Helio Arreche](https://github.com/ArrecheNeto) · adaptado neste fork para publicação via Cloudflare Pages
