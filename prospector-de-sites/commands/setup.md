---
description: Configura o plugin — assinatura, preferências e conexão com o Cloudflare (roda uma vez)
---

Configure o ambiente do Prospector de Sites. Siga esta ordem:

## 1. Pasta de trabalho

Verifique se há uma pasta do usuário conectada. Se não houver, peça para conectar uma pasta (ex.: "Clientes") usando a ferramenta de solicitação de pasta — tudo (config, leads e sites criados) será salvo nela para persistir entre sessões.

## 2. Verificar config existente

Procure `prospector-config.json` na pasta conectada. Se existir, mostre um resumo (sem exibir o token de API) e pergunte o que o usuário quer atualizar. Se não existir, colete os dados abaixo.

## 3. Dados do usuário (perguntar via AskUserQuestion / formulário)

Colete:

- **Assinatura da proposta**: nome completo, como quer se apresentar (ex.: "Designer de páginas de alta conversão") e WhatsApp/telefone de contato.
- **Nichos padrão de prospecção**: sugira nutricionistas, psicólogos, advogados e psiquiatras como ponto de partida, mas deixe o usuário editar livremente.
- **Cidade/região padrão**.
- **Leads qualificados por busca**: padrão 10.
- **E-mail de envio das propostas**: qual provedor e endereço o usuário usa —
  - `gmail` (conector do Gmail — verifique se está ativo em Configurações → Conectores), ou
  - `icloud` (iCloud Mail, inclusive domínio próprio via iCloud+, ex. `contato@seudominio.com` — funciona pelo icloud.com/mail via Claude in Chrome, sem conector e sem senha no config; peça o endereço exato que aparece no campo "De").
- **Modo de envio**: padrão "criar rascunho para revisão" (recomendado). Alternativa: enviar direto.

## 4. Conexão com o Cloudflare

Pergunte se o usuário já tem conta no Cloudflare (a hospedagem das páginas é o Cloudflare Pages — plano grátis basta, HTTPS automático).

- **Se ainda não tem**: explique brevemente que basta criar a conta grátis em dash.cloudflare.com (não precisa de domínio nem cartão), e que depois deve voltar e rodar `/setup` de novo. Salve o config parcial e encerre.
- **Se já tem**: NÃO colete o token pelo chat. Tudo vai num lugar só, a aba Configurações do dashboard:
  1. Guie a criação do token: dash.cloudflare.com/profile/api-tokens → **Create Token** → Custom token → permissão **Cloudflare Pages: Edit** (apenas essa). O **Account ID** aparece na barra lateral da visão geral da conta (ou na URL do dashboard).
  2. Instrua: abra o dashboard local (`iniciar-dashboard.bat` no Windows / `iniciar-dashboard.command` no Mac) → aba **Configurações** → seção **Conexão Cloudflare** → preencher Account ID, API Token, nome do projeto (padrão `prospector` — vira a URL `https://[projeto].pages.dev`) e, se tiver, o domínio próprio. Clica em "Salvar conexão" → tudo vai do navegador direto pro `prospector-config.json` no computador dele, sem passar pelo chat.
  3. Peça para ele avisar quando salvar ("salvei") — aí você LÊ o config (verificando que os campos estão preenchidos, sem nunca exibir o token) e roda o teste de conexão.

  Nunca exiba, imprima ou registre o token em nenhuma saída. Se ele preferir, editar o `prospector-config.json` na mão também vale.

## 5. Salvar e testar

Salve tudo em `prospector-config.json` na pasta conectada, neste formato:

```json
{
  "assinatura": { "nome": "", "apresentacao": "", "whatsapp": "" },
  "prospeccao": { "nichos": ["nutricionistas", "psicologos", "advogados", "psiquiatras"], "cidade": "", "leadsPorBusca": 10 },
  "envio": { "modo": "rascunho", "provedor": "gmail", "endereco": "" },
  "cloudflare": { "accountId": "", "apiToken": "", "projeto": "prospector", "dominio": "" }
}
```

Se os dados do Cloudflare foram informados, teste a conexão seguindo a skill `deploy-cloudflare`: publique `publicar/teste/index.html` simples e informe a URL pública `https://[urlBase]/teste/` ao usuário. Se o teste falhar, diagnostique (token sem permissão Pages:Edit, Account ID errado, projeto) antes de concluir.

## 6. Dashboard inicial

Siga a seção "Setup" da skill `dashboard-leads`: copie `dashboard-server.py` e o iniciador do sistema do usuário (`iniciar-dashboard.bat` no Windows / `iniciar-dashboard.command` no Mac — neste caso rode `chmod +x` no arquivo copiado) para a raiz da pasta conectada, crie o banco `prospector.db` (schema da skill) e gere o `dashboard.html` do template. Explique ao usuário: duplo clique no iniciador abre o painel completo em http://localhost:8765 com edição/exclusão salvando no banco (requer Python; sem ele, o dashboard.html abre no modo leitura).

## 7. Entregar o manual e os scripts

Copie da pasta do plugin para a pasta conectada (sobrescrevendo versões antigas): `manual.html` (manual do usuário) e os scripts de publicação de fallback conforme o sistema (skill `deploy-cloudflare`, references) — Windows: `publicar-agora.ps1` + `publicar-agora.bat` · Mac: `publicar-agora.command` (com `chmod +x`). Eles só serão necessários se o deploy direto do sandbox falhar. Apresente o `manual.html` ao usuário com a frase: "Esse é o seu manual — guarda ele que responde 90% das dúvidas."

## 8. Encerrar

Confirme o que foi salvo e explique o ciclo (guiando SEMPRE o próximo passo ao fim de cada comando): `/prospectar` → `/redesenhar` → `/publicar` → `/proposta`, com `/editor` opcional para ajustes manuais e o `dashboard.html` como painel de controle de tudo.
