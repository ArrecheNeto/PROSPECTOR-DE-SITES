---
name: deploy-hostgator
description: Esta skill deve ser usada ao publicar páginas na hospedagem HostGator — upload via FTP/cPanel, criação de pastas por cliente, verificação da URL pública e fallback pelo navegador. Acione quando o usuário disser "publicar", "subir o site", "colocar no ar", "deploy", "hostgator" ou rodar /publicar ou o teste de conexão do /setup.
---

# Deploy na HostGator

Publicar cada página do cliente em `public_html/[pastaBase]/[slug]/index.html`, acessível em `https://[dominio]/[pastaBase]/[slug]/`.

Credenciais: ler de `prospector-config.json` (usuário, domínio, servidor, senha do cPanel — na HostGator, as credenciais do cPanel funcionam também para FTP). Se faltarem usuário/domínio/servidor, pedir ao usuário. Se faltar a senha, NUNCA pedir no chat: instruir o usuário a preenchê-la diretamente no campo `"senha"` do `prospector-config.json`. Ao usar a senha em comandos, leia-a do arquivo dentro do próprio comando (ex.: `--user "$(python3 -c 'import json;c=json.load(open("prospector-config.json"));print(c["hostgator"]["usuario"]+":"+c["hostgator"]["senha"])')"`) — nunca exibi-la em saídas ou logs.

## Método 1 — FTP programático (tentar primeiro)

O host FTP normalmente é `ftp.[dominio]` ou o próprio servidor do config. Via bash:

```bash
curl -sS --ftp-create-dirs -T index.html \
  "ftp://ftp.DOMINIO/public_html/clientes/SLUG/index.html" \
  --user "USUARIO:SENHA"
```

- Testar também com o valor de `servidor` do config como host se `ftp.[dominio]` falhar.
- `--ftp-create-dirs` cria as pastas automaticamente.
- Se houver imagens locais ou preview, enviar da mesma forma.
- IMPORTANTE: não expor a senha em mensagens ao usuário; nos logs, mascarar.

## Método 2 — cPanel UAPI via HTTPS (se o FTP falhar)

```bash
curl -sS -u "USUARIO:SENHA" \
  "https://SERVIDOR:2083/execute/Fileman/upload_files" \
  -F "dir=/public_html/clientes/SLUG" -F "file-1=@index.html"
```

Criar a pasta antes, se necessário: `https://SERVIDOR:2083/execute/Fileman/mkdir?path=public_html/clientes&name=SLUG`.

## Método 3 — fallback pelo navegador (se a rede do sandbox bloquear os anteriores)

Usar o Claude in Chrome:

1. Navegar para `https://SERVIDOR:2083` (ou o link do cPanel no painel HostGator) — se pedir login, pedir para o usuário logar (não digitar a senha dele no navegador sem autorização explícita).
2. Abrir o **Gerenciador de Arquivos** → `public_html/[pastaBase]/` → criar pasta `[slug]` → Upload do `index.html`.
3. Como o arquivo está na pasta conectada do usuário (fora do sandbox), o upload via navegador usa o arquivo real do computador dele — indicar o caminho da pasta conectada na janela de seleção.

## Verificação (sempre)

Após o upload, buscar `https://[dominio]/[pastaBase]/[slug]/` e con