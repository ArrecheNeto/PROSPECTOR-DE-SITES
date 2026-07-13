---
description: Gera o contrato de prestação de serviço do cliente que fechou e deixa o rascunho no Gmail
argument-hint: "[nome do cliente]"
---

Gere o contrato de um cliente fechado seguindo a skill `contrato-servico`.

## Passos

1. Identifique o cliente por `$ARGUMENTS` ou liste os leads com status `fechado`/`respondeu` do banco e pergunte qual.
2. Reúna os dados que o plugin JÁ tem: nome do cliente, cidade, valor fechado (banco), URL da página publicada, escopo (página única redesenhada + publicação), dados do prestador (assinatura do `prospector-config.json`).
3. Antes de perguntar, LEIA as fontes: dados do prestador em `prospector-config.json` → campo `contratante` (o usuário preenche na vista Configurações do dashboard ou no /setup); dados do cliente nas colunas `docCliente`/`endCliente` do banco. Pergunte APENAS o que ainda faltar — e se o usuário colar a mensagem do cliente com CPF/endereço, extraia e salve no banco (`docCliente`, `endCliente`) para não perguntar de novo. Também confirme: forma de pagamento, prazo de entrega e manutenção mensal (valor).
4. Gere as DUAS versões do contrato:
   - **HTML** (folha ao vivo do dashboard): a partir de `references/contrato-template.html` (substitua TODOS os `{{...}}`). Salve em `sites/[slug]/contrato-[slug].html`.
   - **DOCX travado** (o que vai pro cliente): monte um `dados.json` com as mesmas chaves + `MANUTENCAO`/`VALOR_MANUTENCAO` e rode `python3 references/gerar-docx.py dados.json sites/[slug]/contrato-[slug].docx` (skill `contrato-servico`; instale `python-docx` com `pip install python-docx --break-system-packages` se preciso). O documento sai SOMENTE LEITURA com regiões editáveis destacadas em amarelo — o cliente só consegue preencher CPF/endereço (se faltarem), data e assinatura. Campos que você já tiver ficam fixos.
5. Crie o rascunho no Gmail via conector para o e-mail do cliente: assunto "Contrato de prestação de serviço — [serviço]", corpo curto e cordial (skill tem o modelo) orientando: ler, preencher os campos destacados e devolver respondendo o e-mail. TENTE anexar o `.docx` pelo conector (campo `attachments`, base64); se o conector recusar anexos, informe o caminho do arquivo pro usuário anexar manualmente antes de enviar.
6. Atualize o banco/dashboard (skill `dashboard-leads`): `contratoStatus='enviado'`, `contratoEm=[data de hoje]`, `manutencao=[valor mensal, se contratada]`. Quando o usuário contar que o cliente assinou, atualize `contratoStatus='assinado'`; quando contar que recebeu o pagamento, `pago=1`. Esses campos alimentam as vistas Contratos e Financeiro do dashboard.

## Devolução assinada

Quando o cliente devolver o contrato preenchido/assinado, salve o arquivo como `sites/[slug]/contrato-[slug]-assinado.docx` (ou .pdf) na pasta e atualize `contratoStatus='assinado'` — a vista Contratos do dashboard passa a linká-lo.

## Regras

- O contrato é MINUTA BASE: o rodapé do template contém o aviso de revisão jurídica — nunca o remova.
- Valores, prazos e formas de pagamento vêm do usuário/banco — nunca invente.
- Se o config não tiver os dados completos do prestador, colete uma vez e salve no `prospector-config.json` (campo `contratante`).
