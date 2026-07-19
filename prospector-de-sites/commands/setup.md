---
description: Configura o plugin — assinatura, preferências e integração com a Vercel CLI (roda uma vez)
---

Configure o ambiente do Prospector de Sites. Siga esta ordem:

## 1. Pasta de trabalho

Verifique se há uma pasta do usuário conectada. Se não houver, peça para conectar uma pasta (ex.: "Clientes") usando a ferramenta de solicitação de pasta — tudo (config, leads e sites criados) será salvo nela para persistir entre sessões.

## 2. Verificar config existente

Procure `prospector-config.json` na pasta conectada. Se existir, mostre um resumo e pergunte o que o usuário quer atualizar. Se não existir, colete os dados abaixo.

## 3. Dados do usuário (perguntar via AskUserQuestion / formulário)

Colete:

- **Assinatura da proposta**: nome completo, como quer se apresentar (ex.: "Designer de páginas de alta conversão") e WhatsApp/telefone de contato.
- **Nichos padrão de prospecção**: sugira nutricionistas, psicólogos, advogados e psiquiatras como ponto de partida, mas deixe o usuário editar livremente.
- **Cidade/região padrão**.
- **Leads qualificados por busca**: padrão 10.
- **Modo de envio da proposta**: padrão "criar rascunho no Gmail para revisão" (recomendado). Alternativa: enviar direto.

## 4. Integração com a Vercel CLI

Verifique se a Vercel CLI está ativa e autenticada no ambiente do usuário.
1. Execute silenciosamente o comando `vercel whoami`.
2. Se o comando falhar ou retornar erro (ex: não autenticado), instrua o usuário:
   - "A Vercel CLI precisa estar instalada e autenticada. Abra seu terminal e rode: `npm i -g vercel && vercel login`."
   - Peça para ele avisar quando terminar e rode `/setup` novamente.
3. Se o comando retornar o usuário logado com sucesso, salve o nome de usuário retornado no arquivo de configuração e prossiga.

## 5. Salvar e testar

Salve tudo em `prospector-config.json` na pasta conectada, neste formato:

```json
{
  "assinatura": { "nome": "", "apresentacao": "", "whatsapp": "" },
  "prospeccao": { "nichos": ["nutricionistas", "psicologos", "advogados", "psiquiatras"], "cidade": "", "leadsPorBusca": 10 },
  "envio": { "modo": "rascunho" },
  "vercel": { "usuario": "[nome_usuario_detectado]", "projetoBase": "prospector-sites" }
}
```

Rode o teste de publicação seguindo a skill `deploy-vercel`:
1. Crie uma pasta temporária `clientes_gerados/teste/` e salve nela um arquivo `index.html` simples (contendo `<h1>Funcionou!</h1>`).
2. Execute o deploy de teste com a CLI ou script de deploy:
   ```bash
   deploy_vercel.bat ./clientes_gerados/teste
   ```
3. Capture a URL gerada pela Vercel e mostre ao usuário. Se funcionar, a integração está validada! Se falhar, diagnostique antes de concluir.

## 6. Dashboard inicial

Siga a seção "Setup" da skill `dashboard-leads`: copie `dashboard-server.py` e `iniciar-dashboard.bat` para a raiz da pasta conectada, crie o banco `prospector.db` (schema da skill) e gere o `dashboard.html` do template. Explique ao usuário: duplo clique em `iniciar-dashboard.bat` abre o painel completo em http://localhost:8765 com edição/exclusão salvando no banco (requer Python no Windows; sem ele, o dashboard.html abre no modo leitura).

## 7B. Entregar o manual e iniciadores

Copie da pasta do plugin para a pasta conectada (sobrescrevendo versões antigas): `manual.html` (manual do usuário) e o iniciador do dashboard certo (`iniciar-dashboard.bat` para Windows ou `iniciar-dashboard.command` para Mac).
*(Nota: Os scripts antigos da HostGator foram removidos e não são mais necessários, pois o deploy é feito diretamente usando a Vercel CLI).*
Apresente o `manual.html` ao usuário com a frase: "Esse é o seu manual — guarda ele que responde 90% das dúvidas."

## 7. Encerrar

Confirme o que foi salvo e explique o ciclo (guiando SEMPRE o próximo passo ao fim de cada comando): `/prospectar` → `/redesenhar` → `/publicar` → `/proposta`, com `/editor` opcional para ajustes manuais e o `dashboard.html` como painel de controle de tudo.
