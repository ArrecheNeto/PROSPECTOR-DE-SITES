---
name: deploy-vercel
description: Esta skill deve ser usada ao publicar páginas na hospedagem Vercel usando a Vercel CLI — criação de projetos demo, vinculação de domínios customizados definitivos, e verificação da URL pública com HTTPS. Acione quando o usuário disser "publicar", "subir o site", "colocar no ar", "deploy", "vercel" ou rodar /publicar ou o teste de conexão do /setup.
---

# Deploy na Vercel via Vercel CLI

Esta skill orienta a publicação automática das landing pages redesenhadas e páginas de propostas na infraestrutura da Vercel. O deploy é executado diretamente do sandbox chamando a Vercel CLI pré-autenticada no ambiente do usuário.

---

## 1. Credenciais e Integração

Diferente do deploy por FTP/HostGator, **não é necessário salvar senhas locais no prospector-config.json**.
* A Vercel CLI deve estar instalada globalmente e autenticada na máquina local do usuário (`npm i -g vercel && vercel login`).
* O plugin valida a autenticação rodando o comando:
  ```bash
  vercel whoami
  ```
  Se retornar o nome de usuário (ex: `nullvoiddev`), a CLI está pronta para uso. Caso contrário, solicita-se a autenticação ao usuário.

---

## 2. Deploy de Demonstração (Lead Prospectado)

Para cada lead que foi redesenhado, criamos um projeto isolado na Vercel contendo a landing page (`index.html`) e a capa da proposta (`proposta.html`) dentro da pasta estruturada do cliente.

### Passos para Deploy:
1. Navegue até o diretório do cliente: `clientes_gerados/[slug]/`.
2. Execute o script de deploy especializado na raiz do projeto (que usa `--yes` para evitar confirmações no terminal):
   - No Windows: `deploy_vercel.bat ./clientes_gerados/[slug]`
   - No Linux/WSL: `./deploy_vercel.sh ./clientes_gerados/[slug]`
   - *Alternativa de Bypass (se o sandbox estiver bloqueando a CLI)*: Adicione o caminho `./clientes_gerados/[slug]` ao arquivo `pending_deploys.txt` na raiz da pasta para que o script cron externo publique.
3. A Vercel CLI retornará a URL de deploy em stdout. Capture e valide essa URL (ex: `https://demo-[slug].vercel.app`).
4. Grave a URL gerada no banco de dados SQLite (`prospector.db`) no campo `urlNova`, e a URL da proposta como `[URL]/proposta.html`.
5. Atualize o status do lead para `publicado`.

---

## 3. Deploy Definitivo com Domínio Personalizado (Contrato Fechado)

Quando o contrato com o cliente for fechado e ele adquirir um domínio próprio (ex: `drfulando.com.br`), associamos este domínio ao projeto na Vercel.

### Passos para Configuração:
1. Solicite o domínio definitivo do cliente.
2. Associe o domínio ao projeto Vercel executando:
   ```bash
   vercel domains add [dominio-cliente] --cwd "clientes_gerados/[slug]"
   ```
3. Exiba as instruções DNS obrigatórias para o usuário passar ao cliente:
   * **Se for o domínio raiz (ex: drfulando.com.br):**
     * Criar um registro **A** apontando para `76.76.21.21`.
   * **Se for um subdomínio (ex: www.drfulando.com.br ou clinica.drfulando.com.br):**
     * Criar um registro **CNAME** apontando para `cname.vercel-dns.com`.
4. Para aplicar o domínio em ambiente de produção definitivo, force um deploy de produção:
   - No Windows: `deploy_vercel.bat ./clientes_gerados/[slug]`
   - No Linux/WSL: `./deploy_vercel.sh ./clientes_gerados/[slug]`
5. Atualize a `urlNova` no banco SQLite para `https://[dominio-cliente]`.

---

## 4. Verificação de Acesso e HTTPS

A Vercel emite e renova os certificados SSL/TLS automaticamente via Let's Encrypt para todos os domínios e subdomínios (`.vercel.app` ou customizados).

1. Faça uma requisição HTTP teste usando a URL pública com o prefixo `https://`.
2. Se a URL carregar perfeitamente e o certificado for válido, a publicação está finalizada.
3. No caso de domínios personalizados recém-configurados, pode haver um período de propagação de DNS de até 24h. O plugin deve avisar o usuário sobre esta propagação, mas manter a URL definitiva registrada no banco.

---
