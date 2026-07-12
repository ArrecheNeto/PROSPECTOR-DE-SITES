---
name: proposta-email
description: Esta skill deve ser usada ao escrever e enviar a proposta comercial por e-mail para um lead prospectado — e-mail de apresentação da nova versão do site, com rapport e sem preço. Acione quando o usuário disser "enviar proposta", "e-mail para o cliente", "mandar o site para o cliente" ou rodar /proposta ou /followup.
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
- [ ] **Link com texto visível limpo.** O texto visível do link deve ser a URL real montada a partir do config (nunca copiada de outro e-mail). No **Gmail** (conector): o Gmail embrulha todo link em redirect próprio (`google.com/url?q=...`) ao salvar — não dá pra impedir, e em texto puro o embrulho fica VISÍVEL, o que parece golpe; por isso o rascunho é criado com corpo HTML e o link como âncora `<a href="https://[urlBase]/[slug]/proposta.html">https://[urlBase]/[slug]/proposta.html</a>` (o redirect fica só no href invisível). No **iCloud Mail** (via navegador): não há embrulho — cole a URL limpa como texto mesmo (o Mail a torna clicável). Depois de criar, confira o rascunho: o texto visível deve começar em `https://[urlBase do config]`.
- [ ] **Domínio limpo e humano.** `[projeto].pages.dev` é apresentável (curto, HTTPS, sem números aleatórios) desde que o nome do projeto seja limpo — `prospector.pages.dev` passa; `site-x9k2j1.pages.dev` não. Se o nome do projeto parecer técnico/aleatório, oriente a renomear o projeto ou conectar um domínio próprio (registro.br → Cloudflare Pages → Custom domains) e atualizar o campo `dominio` nas Configurações do dashboard. Proposta só sai com URL apresentável.
- [ ] **Sem palavras-gatilho**: grátis, promoção, imperdível, oferta, desconto, clique aqui, 100%, garantido, urgente.
- [ ] **Sem CAIXA ALTA no assunto, sem "!!", sem emoji** no assunto.
- [ ] **Texto simples** — corpo HTML minimalista (só parágrafos e a âncora do link; zero cores, botões, imagens ou anexos) (anexo de desconhecido aumenta score de spam E medo de abrir; a capa no link substitui o preview).
- [ ] **Assunto ≤ 60 caracteres**, formulado como pergunta ou frase pessoal com o nome do negócio.
- [ ] **Primeira linha 100% personalizada** (nome + fato real das avaliações) — filtros de spam e humanos reconhecem template genérico.
- [ ] **Remetente = conta de e-mail real e ativa do usuário, com SPF/DKIM válidos.** Gmail já tem (Google assina tudo). Domínio próprio no iCloud (iCloud+ Custom Email Domain) também: a Apple exige os registros SPF/DKIM na configuração do domínio — se o usuário recebe e envia normalmente por ele, está assinado (recomende adicionar também um registro DMARC no DNS, ex. `v=DMARC1; p=none`, melhora a entrega). Domínio próprio como remetente passa MAIS credibilidade que @gmail.com em proposta comercial. Nunca sugerir disparo em massa: os envios são 1 a 1, poucos por dia — padrão humano.

## Envio (conforme `envio.provedor` do config)

**Provedor `gmail`** (conector do Gmail):
- Modo **rascunho** (padrão): criar via conector (`create_draft`) com destinatário, assunto e corpo prontos. Avisar o usuário para revisar antes de enviar.
- Modo **enviar direto**: se o conector não suportar envio, abrir o Gmail web via Claude in Chrome, ou criar o rascunho e avisar.

**Provedor `icloud`** (iCloud Mail — inclui domínio próprio via iCloud+; NÃO há conector nem acesso IMAP do sandbox — tudo pelo navegador):
- Abra `https://www.icloud.com/mail` via Claude in Chrome. Se pedir login, o USUÁRIO faz o login dele (nunca peça senha/código no chat) — a sessão costuma persistir nas próximas vezes.
- Modo **rascunho** (padrão): clique em novo e-mail, preencha destinatário, assunto e corpo (o remetente deve ser o endereço do config, ex. selecionando o alias certo no campo "De"), e feche/salve — o iCloud salva em Rascunhos automaticamente. Avise o usuário para revisar na pasta Rascunhos (Mail do Mac, iPhone ou icloud.com) antes de enviar.
- Modo **enviar direto**: mesmo fluxo, clicando em enviar ao final.
- Confira o campo "De" em TODO e-mail: precisa ser o endereço profissional do config, não o @icloud.com pessoal.

Em ambos: nunca enviar para lead sem e-mail confirmado; nesses casos, sugerir contato via WhatsApp com a mesma mensagem adaptada.

## Página-capa (o que o cliente vê ao clicar)

O link do e-mail leva à página-capa gerada no `/publicar` (template em `references/capa-proposta-template.html`): nome do cliente no topo, antes/depois lado a lado e a assinatura do usuário. Ela existe para dar credibilidade ao clique — o cliente vê o próprio negócio, não um link estranho. Exigências: servida em `https://`, personalizada com dados reais, sem pedido de dado pessoal nenhum.

## Depois do envio

Registrar no banco/`leads.md` (status + data) e no dashboard. As respostas são verificadas pelo comando `/respostas` (Gmail via conector; iCloud pela busca do webmail via navegador) — sugira ao usuário agendar a verificação diária. Follow-up pelo `/followup` após 3+ dias úteis sem resposta (1 único follow-up por lead: curto, gentil, "conseguiu ver a página?").

## Respeito ao destinatário (LGPD e reputação)

- O contato usa dado publicado pelo próprio negócio para fins comerciais (e-mail público no site) — mantenha SEMPRE esse lastro: nunca usar e-mail obtido de lista comprada ou raspagem de dado não público.
- Se o lead responder qualquer variação de "não tenho interesse" ou "não me contate": marque `descartado` no banco com a data em `obs` e NUNCA mais o contate (nem follow-up, nem WhatsApp). O `/followup` deve conferir isso antes de gerar qualquer rascunho.
- Volume humano: poucos envios por dia, 1 a 1 — além de reputação de remetente, é o que diferencia prospecção pessoal de spam.
