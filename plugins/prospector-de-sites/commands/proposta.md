---
description: Escreve e cria o rascunho da proposta por e-mail via Gmail
argument-hint: "[nome do cliente ou todos]"
---

Prepare propostas para os leads com página publicada, seguindo a skill `proposta-email`.

## Passos

1. Leia `prospector-config.json` (assinatura e modo de envio) e `leads.md`.
2. Determine os destinatários. No modo padrão, exclua/ignore leads com marcador `[prospector:gmail-draft]` de `kind:"proposal"` e `active:true`, além de leads já enviados; considere somente `status='publicado'` com e-mail confirmado. `$ARGUMENTS` restringe os leads, mas não autoriza duplicar rascunho.
3. Para cada cliente, escreva o e-mail seguindo a skill `proposta-email` na íntegra, usando os dados reais do lead: elogio baseado nas avaliações do Google, o defeito específico apontado na prospecção e — como ÚNICO link — a página-capa publicada (`https://[dominio]/[pastaBase]/[slug]/proposta.html`). Se a capa não foi publicada, gere e publique-a agora (template na skill `proposta-email`, upload pela skill `deploy-hostgator`) antes de criar o rascunho. NUNCA mencione preço.
4. **Checklist anti-spam (bloqueante)**: valide o e-mail contra a checklist da skill `proposta-email` (1 link, sem palavras-gatilho, sem anexo, assunto-pergunta ≤ 60 caracteres, primeira linha personalizada). Reescreva até passar em todos os itens.
5. Se houver marcador ativo, informe o rascunho existente. Uma solicitação explícita de substituição identifica e atualiza o existente por `draftId`/`threadId`, ou pelo par exato `recipient` + `subject`; não cria duplicado. Se o conector não permitir update, pare e peça ao usuário para editar/excluir o rascunho existente no Gmail.
6. Mostre destinatário, assunto e corpo final. Peça confirmação explícita imediatamente antes de criar ou atualizar cada rascunho. Após a confirmação, use o conector do Gmail e informe que o rascunho está pronto para revisão.
7. **Draft creation:** keep status `publicado` (or prior state), persist uma única linha `[prospector:gmail-draft] {"kind":"proposal","draftId":"ID quando disponível","threadId":"ID quando disponível","recipient":"destinatário exato","subject":"assunto aprovado","createdAt":"YYYY-MM-DD","active":true}` em `obs`, and do not set `dataProposta` or status `proposta`. Sem IDs retornados, omita-os; `recipient` + `subject` são o fallback.
8. **Gmail Sent confirmation:** set status `proposta` and `dataProposta` to the actual sent date only after a consulta ao Gmail Sent confirmar que o usuário enviou a mensagem. Atualize o mesmo marcador para `active:false` e grave IDs/data de envio disponíveis.

## Saída

Resuma quantos rascunhos foram criados e para quem, com o link da capa de cada um. Não chame rascunhos de propostas enviadas. Lembre o usuário: após o envio pelo Gmail, `/respostas` confirma Gmail Sent antes de verificar respostas, e `/followup` conta os dias desde o envio confirmado.
