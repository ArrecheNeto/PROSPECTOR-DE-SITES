# Prospector de Sites

Prospecção semi-automática de clientes com sites ruins: acha, redesenha, publica e oferta.

## O ciclo

1. `/setup` — roda uma vez: assinatura, nichos padrão, conexão com o Cloudflare Pages (com teste de publicação).
2. `/prospectar [nicho] [cidade]` — busca no Google Maps negócios nota ≥ 4.7 com site fraco e gera `leads.md` com e-mail, motivo e ranking (padrão: 10 leads).
3. `/redesenhar` — recria as páginas dos 5+ melhores leads com estética premium e regras anti-AI-slop, mantendo o conteúdo, logo e paleta reais do cliente.
4. `/editor [cliente]` — gera versão editável no navegador (textos e imagens) com exportação da página final.
5. `/publicar [cliente|todos]` — sobe no Cloudflare Pages em `https://[projeto].pages.dev/[slug]/` (ou domínio próprio), gera a página-capa de apresentação (antes/depois personalizado, `proposta.html`) — HTTPS automático.
6. `/proposta [cliente|todos]` — escreve o e-mail (rapport, sem preço), passa pela checklist anti-spam e cria o rascunho no seu e-mail (Gmail ou iCloud) com a página-capa como único link.
7. `/respostas` — verifica no seu e-mail quem respondeu e atualiza o dashboard sozinho (dica: agende a verificação diária).
8. `/followup [cliente]` — 3+ dias sem resposta? Gera o follow-up gentil (1 por lead, nunca repete) já checando quem respondeu antes.
9. `/contrato [cliente]` — cliente fechou? Gera a minuta do contrato (pronta pra PDF) com os dados do negócio e deixa o rascunho no e-mail.

## Manual e publicação

O pacote inclui `manual.html` — o manual completo do usuário, copiado pra pasta no `/setup` e **atualizado a cada versão do plugin**. A publicação no Cloudflare Pages roda direto do sandbox via wrangler (token de API escopado, lido do `prospector-config.json`); se a rede bloquear, o fallback é o `publicar-agora` local (2 cliques, requer Node.js).

## Dashboard local

O plugin mantém um painel de controle na sua pasta: `prospector.db` (banco SQLite) + `dashboard.html`. Duplo clique em `iniciar-dashboard.bat` (Windows) ou `iniciar-dashboard.command` (Mac) — requer Python — abre o painel completo em http://localhost:8765 — kanban com drag & drop, edição, exclusão, funil, comparador antes/depois integrado, follow-ups, controle de contratos (pendente/enviado/assinado) e painel financeiro (recebido, a receber e MRR das manutenções), tudo salvo no banco.

## Requisitos

- Extensão Claude in Chrome conectada (prospecção no Maps e fallback de deploy)
- E-mail: conector do Gmail OU conta do iCloud Mail — inclusive domínio próprio via iCloud+ (rascunhos de proposta e leitura de respostas)
- Pasta conectada no Cowork (armazena config, leads e sites)
- Conta no Cloudflare (plano grátis) com token de API escopado (permissão Cloudflare Pages: Edit)

## Onde ficam os dados

Tudo na pasta conectada: `prospector-config.json` (preferências e o token do Cloudflare — fica só no seu computador), `leads.md` (pipeline), `sites/[slug]/` (páginas criadas) e `publicar/` (espelho do que está no ar).
