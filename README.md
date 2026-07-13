# Prospector de Sites — Marketplace de plugins do Helio Arreche

Plugin para Claude (Cowork / Claude Code) e Codex que roda o ciclo completo de prospecção e venda de sites:

**Achou → Refez → Publicou → Ofertou.**

1. `/prospectar` — varre o Google Maps atrás de negócios bem avaliados (nota ≥ 4.7) com site ruim e e-mail público, e salva os leads numa planilha do Google Sheets.
2. `/redesenhar` — recria as páginas dos leads com estética premium: conteúdo real aprimorado, fotos e logo originais, seções novas relevantes. Gera junto o editor visual e o comparador antes/depois.
3. `/editor` — edita textos e imagens da página direto no navegador e exporta a versão final.
4. `/publicar` — sobe as páginas na sua hospedagem HostGator e devolve as URLs públicas.
5. `/proposta` — escreve o e-mail de proposta (rapport real, sem preço) e cria o rascunho no seu Gmail.
6. `/setup` — configura tudo uma única vez (assinatura, nichos, conexão com a HostGator).

## Como instalar

### Codex

Adicione este repositório como marketplace e instale o plugin:

```bash
codex plugin marketplace add ArrecheNeto/PROSPECTOR-DE-SITES
codex plugin add prospector-de-sites@arrecheneto-plugins
```

No Codex, peça em linguagem natural: “Configure meu Prospector de Sites”, “Prospecte leads em [cidade]” ou “Continue meu pipeline”.

### Claude Code

```text
/plugin marketplace add ArrecheNeto/PROSPECTOR-DE-SITES
/plugin install prospector-de-sites@arrecheneto-plugins
```

### Claude Cowork

Configurações → Plugins → Adicionar marketplace → cole a URL deste repositório → instale o **prospector-de-sites**.

## Requisitos

- Claude Cowork/Claude Code ou Codex
- No Claude: extensão Claude in Chrome e pasta conectada no Cowork
- No Codex: recursos de navegador, Gmail e sistema de arquivos disponíveis para as etapas correspondentes
- Conector do Gmail e acesso ao Google Drive quando usados pelo fluxo
- Hospedagem HostGator com acesso ao cPanel

## Segurança

A senha do cPanel nunca é digitada no chat: você preenche o campo `"senha"` no arquivo `prospector-config.json`, que fica somente no seu computador.

---

Criado por [Helio Arreche](https://github.com/ArrecheNeto) · Aprenda a usar no meu canal do YouTube
