---
description: Verifica no Gmail se os clientes responderam as propostas e atualiza o dashboard
argument-hint: "[nome do cliente] — opcional, padrão verifica todos com proposta na rua"
---

Verifique respostas às propostas enviadas e atualize o pipeline.

## Passos

1. Leia o banco `prospector.db` (ou `leads.md` como fallback). Inclua leads com `status='proposta'` e leads no estado anterior cuja `obs` contenha marcador `[prospector:gmail-draft]` de proposta com `active:true`.
2. Para cada marcador `Rascunho Gmail` ativo, consulte Gmail Sent por `threadId` ou `messageId` primeiro (prioridade), depois por `draftId` quando disponível. Se lookup por ID/identificador não encontrar mensagem no Sent, faça sempre fallback por `recipient` + `subject` exatos, mesmo quando havia ID; não use busca aproximada. Rascunho sozinho não é envio.
3. **Gmail Sent confirmado:** promova para status `proposta`, defina `dataProposta` com a data real do envio e atualize o mesmo marcador para `active:false`, registrando `messageId`, `threadId` e `sentAt` disponíveis. Sem confirmação, mantenha `publicado`/estado anterior, marcador ativo e `dataProposta` vazia.
4. Processe respostas somente depois da reconciliação: respostas exigem `status='proposta'` e mensagem original confirmada no Gmail Sent.
5. Para cada lead confirmado, busque no Gmail via conector (`search_threads`) por conversas com o e-mail do lead a partir da `dataProposta` — query típica: `from:[email do lead] after:[dataProposta]` e também a thread da proposta original (`to:[email] [primeiras palavras do assunto]`).
6. Classifique:
   - **Respondeu**: existe mensagem DO lead na thread → atualize o banco (`status='respondeu'`, resumo curto da resposta em `obs`, ex.: "Respondeu 09/07: gostou, pediu valores").
   - **Sem resposta**: mantenha `proposta` (o dashboard cuida do alerta de follow-up).
7. Atualize conforme a skill `dashboard-leads` (upsert no banco + regenerar o snapshot do `dashboard.html`) e regenere a planilha do Google se houver mudanças.
8. Resuma para o usuário: quem respondeu (com a essência de cada resposta), quem segue sem resposta e há quantos dias desde o envio confirmado, e sugira as ações (responder o cliente, follow-up dos parados).

## Automação (sugerir na primeira execução)

Ofereça deixar isso automático com uma tarefa agendada do Cowork: "quer que eu verifique as respostas todo dia de manhã e deixe o dashboard atualizado?" — se aceitar, crie a tarefa agendada diária que executa este comando.

## Regras

- NUNCA marque `fechado` sozinho — fechamento envolve preço/acordo; apenas o usuário confirma (aí registre `valor`).
- Não responda e-mails automaticamente: leitura e classificação apenas. Se o usuário quiser, ofereça rascunho de resposta.
