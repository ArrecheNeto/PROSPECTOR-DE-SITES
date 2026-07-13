# Prospector de Sites — contexto para o Codex

> Copie este arquivo para a raiz da sua pasta de trabalho (a mesma do `prospector-config.json`) com o nome `AGENTS.md`. Ele orienta o Codex quando as skills do Prospector forem usadas.

## O que é este fluxo

Ciclo de prospecção e venda de sites: **achou → refez → publicou → ofertou**. As skills instaladas em `~/.agents/skills` (prospeccao-maps, redesign-premium, deploy-cloudflare, proposta-email, dashboard-leads, contrato-servico) contêm as regras de cada etapa; as skills `$prospectar`, `$redesenhar`, `$publicar`, `$proposta`, `$respostas`, `$followup`, `$contrato`, `$editor` e `$prospector-setup` são os fluxos executáveis. Siga-as à risca.

## Arquivos desta pasta

- `prospector-config.json` — preferências, assinatura, bloco `cloudflare` (accountId, apiToken escopado, projeto, dominio) e bloco `envio` (provedor de e-mail). **O apiToken nunca é exibido em comando, log ou resposta** — leia-o via script e injete por variável de ambiente.
- `prospector.db` + `dashboard.html` + `dashboard-server.py` — CRM local (skill `dashboard-leads`). Todo comando que muda status de lead atualiza o banco E regenera o snapshot.
- `leads.md` — cópia de trabalho do pipeline.
- `sites/[slug]/` — páginas criadas. `publicar/` — espelho do site público (deploy atômico).

## Diferenças em relação ao Claude (adaptações obrigatórias)

As skills citam ferramentas do Claude que têm equivalentes diferentes aqui. Antes de tudo, detecte o que está disponível NESTA sessão: a extensão **Codex for Chrome** (`@Chrome` — opera no Chrome real do usuário, com as sessões logadas) e o **Computer Use** (`@Computer Use` — controla apps nativos no macOS/Windows) existem no app do Codex quando o usuário os habilitou nas configurações; no Codex CLI puro, não. Adapte conforme a tabela:

1. **"Claude in Chrome" (navegação)** →
   - **Com `@Chrome` disponível**: use-o como equivalente direto — a prospecção pode seguir a skill `prospeccao-maps` original (navegar no Google Maps), e as verificações de site idem. Respeite captcha/login: pare e avise, nunca contorne.
   - **Sem `@Chrome`** (CLI): use a skill **`prospeccao-web`** (empacotada no plugin) — pesquisa assistida via busca web e fontes públicas, mesmos filtros de qualificação. Nunca finja dados de leads: dado não verificado em fonte pública desqualifica o lead.
2. **Conector do Gmail / iCloud via navegador** → e-mail em 3 níveis, do melhor para o fallback:
   - **`@Chrome`**: siga a seção "Envio" da skill `proposta-email` no webmail logado do usuário (Gmail web ou icloud.com/mail) — criar o rascunho com destinatário, assunto e corpo, conferindo o campo "De" (endereço do `envio.endereco` do config). Para `$respostas`, use a busca do webmail. NUNCA digite senha/código do usuário; se pedir login, o usuário faz.
   - **`@Computer Use` (Mac)**: alternativa nativa — criar o rascunho no **Apple Mail** (Arquivo → Nova mensagem, escolher o remetente certo no "De", salvar como rascunho; o rascunho sincroniza com o iCloud). Para `$respostas`, buscar na caixa de entrada do Mail. Só com autorização explícita do usuário na sessão.
   - **Nenhum dos dois** (CLI): gere o e-mail pronto e validado na checklist anti-spam em `emails-prontos/[slug].md` para o usuário copiar/colar; para `$respostas`, peça para colar as respostas (ou use um MCP de e-mail, se configurado).
   - Em TODOS os níveis: modo padrão é RASCUNHO (o usuário revisa e envia); envio direto só se o config disser `"modo": "direto"` e o usuário confirmar na sessão.
3. **AskUserQuestion / formulários** → pergunte em texto simples, uma pergunta por vez.
4. **Ferramenta de apresentação de arquivos** → liste os caminhos dos arquivos gerados.
5. **Deploy** (`$publicar`) → funciona igual: `npx wrangler pages deploy` com as credenciais do config por variável de ambiente (skill `deploy-cloudflare`). Dashboard, redesign, comparador, editor e contrato também funcionam sem adaptação.

## Regras que nunca mudam

- Nenhum fato inventado nos sites (skill `redesign-premium`, incluindo `references/anti-slop.md`).
- Checklist anti-spam bloqueante antes de qualquer e-mail (skill `proposta-email`), incluindo opt-out definitivo de quem pediu para não ser contatado.
- Credenciais (token do Cloudflare) só no arquivo de config — nunca no chat ou em saída.
- Ao mudar status de lead: banco + `dashboard.html` + `leads.md`, sempre juntos.
