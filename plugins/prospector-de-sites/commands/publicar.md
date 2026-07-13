---
description: Publica as páginas redesenhadas na HostGator e retorna as URLs públicas
argument-hint: "[nome do cliente ou todos]"
---

Publique páginas na HostGator seguindo a skill `deploy-hostgator`.

## Passos

1. Leia `prospector-config.json`. Se os dados da HostGator não estiverem preenchidos, colete-os agora (usuário, domínio, servidor — e oriente o usuário a preencher a senha diretamente no config, nunca no chat) — não prossiga sem eles.
2. Determine o que publicar: `$ARGUMENTS` (um cliente ou "todos"), ou liste as páginas com status `redesenhado` em `leads.md` e pergunte.
3. **Gere a página-capa de cada cliente**: preencha `references/capa-proposta-template.html` (skill `proposta-email`) com os dados do lead + assinatura do config e salve como `sites/[slug]/proposta.html`. É ela que vai no e-mail de proposta.
4. **Publique seguindo a skill `deploy-hostgator`**, nesta ordem: tente o FTP silencioso do sandbox; se a rede bloquear, use o publicador automático local — garanta os 4 arquivos do publicador na pasta, monte a `fila-publicacao.txt` com página (`index.html`) e capa (`proposta.html`) de cada cliente e aguarde ~90s: a tarefa agendada publica sozinha (confira a fila renomeada e o `publicador-log.txt`). Se a tarefa ainda não foi instalada, peça o duplo clique único no `instalar-publicador.bat`. Sem cPanel, sem login, senha só no config.
5. **Verificação HTTPS (bloqueante)**: abra cada URL com `https://` e confirme que carrega com cadeado válido. Se o HTTPS falhar, siga a seção "HTTPS obrigatório" da skill `deploy-hostgator` (AutoSSL no cPanel) antes de considerar publicado — link `http://` NUNCA vai para cliente.
6. Atualize `leads.md` e o banco do dashboard: status `publicado` + URL pública nova.

## Saída

Liste, por cliente: URL da página nova e URL da capa (`.../proposta.html`), ambas testadas em https. Sugira o próximo passo: `/proposta` para enviar os e-mails.
