---
name: deploy-hostgator
description: Esta skill deve ser usada ao publicar páginas na hospedagem HostGator — upload via script local automático, FTP ou cPanel, criação de pastas por cliente, verificação da URL pública e HTTPS. Acione quando o usuário disser "publicar", "subir o site", "colocar no ar", "deploy", "hostgator" ou rodar /publicar ou o teste de conexão do /setup.
---

# Deploy na HostGator

Publicar páginas em `public_html/[pastaBase]/[slug]/` e garantir a URL pública `https://[dominio]/[pastaBase]/[slug]/` funcionando.

## Credenciais

Tudo vem de `prospector-config.json` (bloco `hostgator`): `usuario`, `dominio`, `servidor`, `senha`, `pastaBase` (padrão `clientes`). **A senha vive SÓ nesse arquivo, no computador do usuário — nunca é digitada no chat, nunca é exibida em nenhuma saída, log ou argumento de processo.** Se a senha estiver vazia, oriente o usuário: dashboard → aba Configurações → Conexão HostGator → colar a senha e salvar (ou editar o arquivo na mão). Nunca pelo chat.

Codex não deve montar comandos FTP autenticados nem transferir credenciais do config para a linha de comando. Use somente um publicador local que leia o config dentro do processo, ou uma authenticated browser session na qual o usuário faça login diretamente.

## Confirmação obrigatória

Require explicit confirmation immediately before publication. Preparar e revisar arquivos é permitido antes da confirmação; criar `fila-publicacao.txt`, iniciar o publicador local, fazer upload no navegador ou executar o teste de conexão publica conteúdo e exige confirmação nesse momento. Confirmações anteriores, incluindo pedido para rodar o pipeline inteiro ou `/setup`, não valem para esta etapa.

## Método 1 — Publicador automático local (RECOMENDADO: instala uma vez, nunca mais clica)

A rede do sandbox do Cowork NÃO alcança FTP nem cPanel — isso vale para todo usuário. A publicação roda na máquina do usuário via um publicador instalado no agendador do Windows: a cada minuto ele verifica a fila e sobe o que houver, escondido, lendo as credenciais do config. O usuário instala UMA vez e o /publicar vira 100% automático.

1. **Garanta os arquivos do publicador na pasta conectada** (copie de `references/` desta skill, sobrescrevendo versões antigas), conforme o sistema do usuário — pergunte ou detecte:
   - **Windows**: `publicar-agora.ps1`, `publicar-agora.bat`, `publicador-oculto.vbs`, `instalar-publicador.bat`.
   - **Mac**: `publicar-agora.command` e `instalar-publicador.command` (o instalador registra o publicador no launchd, a cada 60s; desinstalar = `launchctl unload` do plist com.prospector.publicador).
   Em dúvida, copie todos — cada sistema ignora os do outro.
2. **Primeira vez**: peça UM duplo clique no `instalar-publicador.bat` (Windows — cria a tarefa "ProspectorPublicador"; erro de permissão = botão direito → Executar como administrador) ou no `instalar-publicador.command` (Mac — se o macOS bloquear por segurança: botão direito → Abrir na primeira vez). Só uma vez na vida.
3. **Após a confirmação imediata, monte a fila**: escreva `fila-publicacao.txt` na raiz da pasta conectada, uma linha por arquivo: `caminho/local/arquivo.html|public_html/[pastaBase]/[slug]/index.html`. Inclua página (`index.html`) e capa (`proposta.html`) de cada cliente. Em até 1 minuto o publicador sobe tudo sozinho e renomeia a fila para `fila-publicada-[data].txt` (o log fica em `publicador-log.txt`).
4. **Aguarde ~90s e verifique**: confira se a fila foi renomeada e teste as URLs (verificação abaixo). Sem tarefa instalada, o fallback manual é o duplo clique no `publicar-agora.bat` (Windows) ou `publicar-agora.command` (Mac).

## Método 2 — Navegador (fallback seguro)

Se o publicador local falhar, use o cPanel File Manager em uma sessão autenticada do navegador. O USUÁRIO faz o login diretamente na interface; nunca peça, leia ou repita a senha no chat. Peça a confirmação obrigatória imediatamente antes de iniciar o upload, então navegue, crie as pastas e envie os arquivos pela interface.

## Verificação (obrigatória, após qualquer método)

1. Abra `https://[dominio]/[pastaBase]/[slug]/` e a capa `.../proposta.html` — confirme que carregam com conteúdo certo.
2. **HTTPS obrigatório**: precisa carregar com cadeado válido. Se der erro de certificado: HostGator tem SSL grátis — guie: cPanel → **SSL/TLS Status** → marcar o domínio → **Run AutoSSL** (minutos). Enquanto o HTTPS não valida, a publicação NÃO está concluída — link `http://` NUNCA vai para cliente.
3. Atualize `leads.md` + dashboard com status `publicado` e a URL.

## Teste de conexão do /setup

Prepare `teste.html` simples ("Funcionou!") para `public_html/[pastaBase]/teste/index.html`. Peça confirmação imediatamente antes de publicar o teste. Depois da confirmação, use o publicador local; se bloqueado, use a sessão autenticada do navegador. Assim o usuário aprende o fluxo logo no setup sem expor credenciais.
