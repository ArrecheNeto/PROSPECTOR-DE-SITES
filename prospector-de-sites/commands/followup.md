---
description: Gera follow-up para propostas sem resposta há 3+ dias (1 por lead, nunca repete)
argument-hint: "[nome do cliente] — opcional, padrão: todos os elegíveis"
---

Gere follow-ups educados para propostas paradas, seguindo a skill `proposta-email`.

## Passos

1. **Verifique respostas ANTES**: rode a lógica do `/respostas` (Gmail via conector ou iCloud Mail via navegador, conforme `envio.provedor`) para não fazer follow-up de quem já respondeu — quem respondeu vira status `respondeu` e sai da lista. Lead marcado `descartado` por pedir para não ser contatado NUNCA recebe follow-up.
2. Selecione os elegíveis: leads com status `proposta`, data de envio há **3+ dias**, e SEM follow-up registrado (procure "follow-up" no campo `obs` do banco/`leads.md`). Se `$ARGUMENTS` indicar um cliente, restrinja a ele (mas respeite a regra de nunca repetir follow-up).
3. Para cada elegível, escreva o follow-up — máximo 4 linhas, tom de quem lembra com gentileza, nunca cobra:
   - Referência leve ao primeiro e-mail ("te escrevi semana passada sobre o site").
   - Pergunta única: "conseguiu ver a página que preparei?" + o mesmo link da capa (único link).
   - Sem preço, sem urgência, sem "última chance". Passar pela checklist anti-spam da skill.
4. Crie os rascunhos no provedor do config (Gmail via conector ou iCloud Mail via navegador — seção "Envio" da skill `proposta-email`). **1 follow-up por lead, para sempre** — se não responder ao follow-up, o lead é marcado como frio manualmente pelo usuário no dashboard.
5. Registre em cada lead: `obs` += "Follow-up enviado em [data]" (no banco via API do dashboard se estiver rodando, senão direto no SQLite/`leads.md`).

## Saída

Liste: follow-ups criados, leads que responderam nesse meio-tempo (celebre!), e leads sem resposta que já receberam follow-up (sugerir marcar como frio ou tentar WhatsApp). Ofereça agendar `/respostas` + `/followup` como verificação diária automática.
