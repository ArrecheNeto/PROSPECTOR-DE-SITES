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

As skills citam ferramentas do Claude que NÃO existem aqui. Substituições:

1. **"Claude in Chrome" (navegação)** → não disponível. Para a prospecção no Google Maps (`$prospectar`), prefira: pedir ao usuário que exporte/cole os dados dos estabelecimentos, ou usar um script Playwright local se o ambiente permitir navegador — e PARE e avise se o Google pedir captcha/login. Nunca finja dados de leads: se não conseguir verificar nota/avaliações/site, não inclua o lead.
2. **Conector do Gmail** → não disponível. Para `$proposta`/`$followup`/`$contrato`: gere o e-mail pronto (assunto + corpo, já validado na checklist anti-spam da skill `proposta-email`) e grave em `emails-prontos/[slug].md` para o usuário copiar/colar no Gmail ou iCloud Mail; se houver um MCP de e-mail configurado no Codex, use-o. Para `$respostas`: peça ao usuário para colar as respostas recebidas, ou use o MCP de e-mail se existir.
3. **AskUserQuestion / formulários** → pergunte em texto simples, uma pergunta por vez.
4. **Ferramenta de apresentação de arquivos** → liste os caminhos dos arquivos gerados.
5. **Deploy** (`$publicar`) → funciona igual: `npx wrangler pages deploy` com as credenciais do config por variável de ambiente (skill `deploy-cloudflare`). Dashboard, redesign, comparador, editor e contrato também funcionam sem adaptação.

## Regras que nunca mudam

- Nenhum fato inventado nos sites (skill `redesign-premium`, incluindo `references/anti-slop.md`).
- Checklist anti-spam bloqueante antes de qualquer e-mail (skill `proposta-email`), incluindo opt-out definitivo de quem pediu para não ser contatado.
- Credenciais (token do Cloudflare) só no arquivo de config — nunca no chat ou em saída.
- Ao mudar status de lead: banco + `dashboard.html` + `leads.md`, sempre juntos.
