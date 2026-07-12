---
description: Escreve e envia (ou cria rascunho) da proposta por e-mail (Gmail ou iCloud, conforme o config)
argument-hint: "[nome do cliente ou todos]"
---

Envie propostas para os leads com página publicada, seguindo a skill `proposta-email`.

## Passos

1. Leia `prospector-config.json` (assinatura e modo de envio) e `leads.md`.
2. Determine os destinatários: `$ARGUMENTS`, ou todos os leads com status `publicado` que ainda não receberam proposta. Somente leads com e-mail confirmado — para os demais, informe que a abordagem fica manual via WhatsApp (ofereça o texto adaptado).
3. Para cada cliente, escreva o e-mail seguindo a skill `proposta-email` na íntegra, usando os dados reais do lead: elogio baseado nas avaliações do Google, o defeito específico apontado na prospecção e — como ÚNICO link — a página-capa publicada (`https://[urlBase]/[slug]/proposta.html`). Se a capa não foi publicada, gere e publique-a agora (template na skill `proposta-email`, deploy pela skill `deploy-cloudflare`) antes de criar o rascunho. NUNCA mencione preço.
4. **Checklist anti-spam (bloqueante)**: valide o e-mail contra a checklist da skill `proposta-email` (1 link, sem palavras-gatilho, sem anexo, assunto-pergunta ≤ 60 caracteres, primeira linha personalizada). Reescreva até passar em todos os itens.
5. Envio conforme `envio.modo` e `envio.provedor` do config (seção "Envio" da skill `proposta-email`):
   - **gmail**: rascunho pelo conector do Gmail (padrão) ou envio direto (conector/Gmail web).
   - **icloud**: rascunho ou envio pelo iCloud Mail web (icloud.com/mail) via Claude in Chrome — o usuário faz o próprio login se for pedido; conferir que o campo "De" é o endereço profissional do config.
6. Atualize `leads.md` e o banco do dashboard: status `proposta` + data de envio.

## Saída

Resuma: quantas propostas criadas/enviadas e para quem, com o link da capa de cada uma. Lembre o usuário: `/respostas` verifica quem respondeu (dá pra agendar diário) e `/followup` cuida de quem está 3+ dias sem responder.
