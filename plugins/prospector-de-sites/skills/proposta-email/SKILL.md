---
name: proposta-email
description: Esta skill deve ser usada ao escrever e preparar a proposta comercial por e-mail para um lead prospectado — e-mail de apresentação da nova versão do site, com rapport e sem preço. Acione quando o usuário disser "enviar proposta", "e-mail para o cliente", "mandar o site para o cliente" ou rodar /proposta ou /followup.
---

# Proposta por e-mail

O e-mail NÃO vende — ele desperta curiosidade e prova trabalho feito. O fechamento (preço, escopo, reunião) acontece na resposta. Um e-mail que parece de vendedor morre no spam; um e-mail que parece de uma pessoa que já trabalhou de graça pro destinatário é aberto e respondido.

## Princípios

1. **Rapport primeiro.** Abrir com elogio ESPECÍFICO e verificável: a nota no Google, uma avaliação real citada, uma credencial do site. Nunca elogio genérico.
2. **A dor sem ofensa.** Apontar 1-2 defeitos objetivos do site atual como oportunidade ("notei que no celular o site fica difícil de ler"), nunca como crítica ao profissional.
3. **A prova antes do pedido.** O trabalho JÁ está feito e no ar. O link é a proposta.
4. **Zero preço.** Preço só na conversa que a resposta abre.
5. **Zero pressão.** Sem urgência falsa, sem "últimas vagas". Um único CTA: dar uma olhada e responder o que achou.
6. **Curto.** 120-180 palavras. Profissional ocupado não lê e-mail longo de desconhecido.

## Estrutura

- **Assunto**: pergunta pessoal e específica, ≤ 60 caracteres, sem cara de marketing. Ex.: `Dra. [Nome], posso te mostrar uma coisa sobre seu site?` ou `Preparei algo para a [Clínica X]`.
- **Parágrafo 1**: quem encontrou + elogio específico (avaliações/credencial).
- **Parágrafo 2**: observação sobre o site atual (1-2 pontos objetivos).
- **Parágrafo 3**: "preparei uma nova versão, já no ar" + O ÚNICO LINK do e-mail: a página-capa (`.../proposta.html`), que mostra antes e depois lado a lado. Se a capa não existir, linkar a página nova direto.
- **Parágrafo 4**: CTA — abrir no celular também, responder com a impressão.
- **Assinatura**: nome, apresentação e WhatsApp do config (assinatura completa humaniza e reduz suspeita).

## Checklist anti-spam (BLOQUEANTE — rodar antes de criar o rascunho)

Revise o e-mail pronto contra CADA item; se falhar em qualquer um, reescreva antes de criar o rascunho:

- [ ] **1 link só** (a página-capa). Dois links no máximo se incluir o site antigo — nunca mais que isso.
- [ ] **Sem encurtador de URL** (bit.ly e afins = spam na certa). O link é o domínio real, com `https://`.
- [ ] **Link como âncora HTML com texto visível limpo.** O Gmail embrulha TODO link em um redirect próprio (`google.com/url?q=...`) ao salvar — não dá pra impedir, e em corpo de texto puro o embrulho fica VISÍVEL, o que parece golpe. Por isso o rascunho é criado com corpo HTML e o link como âncora: `<a href="https://[dominio]/[pastaBase]/[slug]/proposta.html">https://[dominio]/[pastaBase]/[slug]/proposta.html</a>` — texto visível = a URL limpa montada a partir do config (nunca copiada de outro e-mail). O redirect do Google fica só no href invisível, como em qualquer e-mail do Gmail. Depois de criar, confira o rascunho: o texto visível deve começar em `https://[dominio do config]`.
- [ ] **Domínio limpo e humano.** Se o domínio do config for um subdomínio técnico/temporário (cheio de números, tipo `nome1783367206076.1711244.meusitehostgator.com.br`), PARE antes de enviar qualquer proposta: link assim parece golpe e mata a confiança que a capa constrói. Oriente o usuário a ativar o domínio próprio (grátis no plano da HostGator: cPanel → Domains, ou registro em registro.br) e atualizar o campo `dominio` nas Configurações do dashboard. Proposta só sai com domínio apresentável.
- [ ] **Sem palavras-gatilho**: grátis, promoção, imperdível, oferta, desconto, clique aqui, 100%, garantido, urgente.
- [ ] **Sem CAIXA ALTA no assunto, sem "!!", sem emoji** no assunto.
- [ ] **Texto simples** — corpo HTML minimalista (só parágrafos e a âncora do link; zero cores, botões, imagens ou anexos) (anexo de desconhecido aumenta score de spam E medo de abrir; a capa no link substitui o preview).
- [ ] **Assunto ≤ 60 caracteres**, formulado como pergunta ou frase pessoal com o nome do negócio.
- [ ] **Primeira linha 100% personalizada** (nome + fato real das avaliações) — filtros de spam e humanos reconhecem template genérico.
- [ ] **Remetente = conta Gmail pessoal ativa do usuário** (já tem SPF/DKIM do Google). Nunca sugerir disparo em massa: os envios são 1 a 1, poucos por dia — padrão humano.

## Envio

- **Confirmação do rascunho:** require explicit confirmation immediately before Gmail draft creation. Mostrar destinatário, assunto e corpo final para revisão não cria o rascunho. Só depois da confirmação imediata, criar via conector do Gmail (`create_draft`) com destinatário, assunto e corpo aprovados.
- **Draft-only workflow:** create drafts only. Avisar o usuário para revisar o rascunho no Gmail. Never silently send.
- Se o usuário pedir envio direto em uma etapa separada, require explicit confirmation immediately before any send. Esta skill ainda termina no rascunho; o usuário envia no Gmail ou autoriza um fluxo de envio separado que tenha seu próprio gate imediato.
- Nunca enviar para lead sem e-mail confirmado; nesses casos, sugerir contato via WhatsApp com a mesma mensagem adaptada.

## Página-capa (o que o cliente vê ao clicar)

O link do e-mail leva à página-capa gerada no `/publicar` (template em `references/capa-proposta-template.html`): nome do cliente no topo, antes/depois lado a lado e a assinatura do usuário. Ela existe para dar credibilidade ao clique — o cliente vê o próprio negócio, não um link estranho. Exigências: servida em `https://`, personalizada com dados reais, sem pedido de dado pessoal nenhum.

## Estado do lead

- **Marcador durável:** cada rascunho ativo ocupa uma única linha de `obs` no formato `[prospector:gmail-draft] {"kind":"proposal","draftId":"...","threadId":"...","recipient":"lead@example.com","subject":"Assunto aprovado","createdAt":"YYYY-MM-DD","active":true}`. Grave `draftId` e `threadId` quando retornados pelo Gmail; se o conector não retornar ID, omita-os e use `recipient` + `subject` exatos como identidade fallback. Para follow-up, use `kind:"followup"`. Preserve outras observações.
- **Draft creation:** keep status `publicado` (or prior state), persist the `[prospector:gmail-draft]` marker with `draftId` when available, exact `recipient`, approved `subject`, `createdAt`, and `active:true`; do not set `dataProposta` or status `proposta`. Criar o rascunho não inicia contagem de follow-up.
- **Sem duplicados:** antes de criar, procure marcador do mesmo `kind` com `active:true`. O fluxo padrão pula o lead. Uma substituição explícita identifica e atualiza o rascunho existente por `draftId`/`threadId`, ou por `recipient` + `subject` exatos; se atualização não for suportada, pare e informe em vez de criar outro rascunho.
- **Follow-up ativo:** marcador `kind:"followup"` com `active:true` deve ser substituído/continuado no rascunho existente; não crie duplicado.
- **Follow-up já enviado:** marcador `kind:"followup"` com `active:false` e `sentAt`, `messageId` ou `threadId` confirma envio e bloqueia permanentemente outro follow-up; o lead fica inelegível mesmo sem a frase legada `Follow-up enviado`.
- **Gmail Sent confirmation:** set status `proposta` and `dataProposta` to the actual sent date only after the message appears in Gmail Sent. A intenção de enviar, o rascunho e a confirmação do usuário não são prova de envio.
- Ao confirmar envio, altere o marcador existente para `active:false` e registre `messageId`, `threadId` e `sentAt` quando disponíveis; não acrescente outro marcador ativo.
- `/respostas` e `/followup` só processam leads com `status='proposta'` e mensagem original confirmada no Gmail Sent.

As respostas são verificadas pelo comando `/respostas` (Gmail via conector) — sugira ao usuário agendar a verificação diária. Follow-up pelo `/followup` após 3+ dias úteis do envio confirmado sem resposta (1 único follow-up enviado por lead: curto, gentil, "conseguiu ver a página?").
