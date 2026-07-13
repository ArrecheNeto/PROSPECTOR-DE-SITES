---
description: Gera follow-up para propostas sem resposta há 3+ dias (1 por lead, nunca repete)
argument-hint: "[nome do cliente] — opcional, padrão: todos os elegíveis"
---

Gere follow-ups educados para propostas paradas, seguindo a skill `proposta-email`.

## Passos

1. **Confirme envio e verifique respostas ANTES**: exija `status='proposta'` e Gmail Sent confirmado para a mensagem original; depois rode a lógica do `/respostas` para não fazer follow-up de quem já respondeu. Rascunho não é elegível. Quem respondeu vira status `respondeu` e sai da lista.
2. Selecione os elegíveis: leads com envio confirmado e `dataProposta` há **3+ dias**. Um marcador `kind:"followup"` com `active:false` e `sentAt`, `messageId` ou `threadId` bloqueia permanentemente outro follow-up e torna o lead inelegível, mesmo sem a frase legada `Follow-up enviado`. Se `$ARGUMENTS` indicar um cliente, aplique a mesma regra.
3. Para cada elegível, escreva o follow-up — máximo 4 linhas, tom de quem lembra com gentileza, nunca cobra:
   - Referência leve ao primeiro e-mail ("te escrevi semana passada sobre o site").
   - Pergunta única: "conseguiu ver a página que preparei?" + o mesmo link da capa (único link).
   - Sem preço, sem urgência, sem "última chance". Passar pela checklist anti-spam da skill.
4. Marcador `[prospector:gmail-draft]` com `kind:"followup"` e `active:true` deve ser substituído/continuado no rascunho existente; não crie duplicado. Identifique pelo `draftId`/`threadId` ou fallback exato `recipient` + `subject`; atualize somente quando o usuário pedir substituição explícita e o conector suportar update.
5. Mostre o conteúdo final e peça confirmação explícita imediatamente antes de criar ou atualizar cada rascunho. Crie somente rascunhos no Gmail.
6. Persista uma única linha `[prospector:gmail-draft] {"kind":"followup","draftId":"ID quando disponível","threadId":"ID quando disponível","recipient":"destinatário exato","subject":"assunto aprovado","createdAt":"YYYY-MM-DD","active":true}` em `obs`; sem IDs, use `recipient` + `subject` exatos. Somente após confirmação no Gmail Sent, mude o marcador para `active:false` e registre `messageId`/`threadId`/`sentAt`. **1 follow-up enviado por lead, para sempre**.

## Saída

Liste: rascunhos de follow-up criados, leads que responderam nesse meio-tempo e leads sem resposta que já tiveram envio de follow-up confirmado. Ofereça agendar `/respostas` + `/followup` como verificação diária automática.
