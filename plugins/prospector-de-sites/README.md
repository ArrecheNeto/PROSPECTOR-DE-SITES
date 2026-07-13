# Prospector de Sites

Prospecção semi-automática de clientes com sites ruins: acha, redesenha, publica e oferta.

## O ciclo

1. `/setup` — roda uma vez: assinatura, nichos padrão, dados do cPanel da HostGator (com teste de publicação).
2. `/prospectar [nicho] [cidade]` — busca no Google Maps negócios nota ≥ 4.7 com site fraco e gera `leads.md` com e-mail, motivo e ranking (padrão: 10 leads).
3. `/redesenhar` — recria as páginas dos 5+ melhores leads com estética premium, mantendo o conteúdo, logo e paleta reais do cliente.
4. `/editor [cliente]` — gera versão editável no navegador (textos e imagens) com exportação da página final.
5. `/publicar [cliente|todos]` — sobe na HostGator em `dominio.com/clientes/[slug]/`, gera a página-capa de apresentação (antes/depois personalizado, `proposta.html`) e só conclui com HTTPS validado.
6. `/proposta [cliente|todos]` — escreve o e-mail (rapport, sem preço), passa pela checklist anti-spam e cria o rascunho no Gmail com a página-capa como único link.
7. `/respostas` — verifica no Gmail quem respondeu e atualiza o dashboard sozinho (dica: agende a verificação diária).
8. `/followup [cliente]` — 3+ dias sem resposta? Gera o follow-up gentil (1 por lead, nunca repete) já checando quem respondeu antes.
9. `/contrato [cliente]` — cliente fechou? Gera a minuta do contrato (pronta pra PDF) com os dados do negócio e deixa o rascunho no Gmail.

## Uso no Codex

O Codex ativa o fluxo por linguagem natural, sem depender dos comandos `/...` do Claude. Exemplos:

- “Configure meu workspace do Prospector de Sites.”
- “Prospecte 10 restaurantes em Roma.”
- “Redesenhe os próximos cinco leads qualificados.”
- “Continue o pipeline usando os arquivos existentes.”
- “Confira respostas e prepare os follow-ups elegíveis.”

O Codex pede confirmação antes de publicar ou criar mensagens externas e mantém o estado nos mesmos arquivos locais usados pelo fluxo original.

## Manual e publicação automática

O pacote inclui `manual.html` — o manual completo do usuário, copiado pra pasta no `/setup` e **atualizado a cada versão do plugin**. A publicação na HostGator é automática: senha preenchida uma vez no `prospector-config.json` + `publicar-agora.bat` (2 cliques) quando a rede do sandbox não alcança o FTP — sem login no cPanel.

## Dashboard local

O plugin mantém um painel de controle na sua pasta: `prospector.db` (banco SQLite) + `dashboard.html`. Duplo clique em `iniciar-dashboard.bat` (requer Python) abre o painel completo em http://localhost:8765 — kanban com drag & drop, edição, exclusão, funil, comparador antes/depois integrado, follow-ups, controle de contratos (pendente/enviado/assinado) e painel financeiro (recebido, a receber e MRR das manutenções), tudo salvo no banco.

## Requisitos

- Claude Cowork/Claude Code ou Codex
- No Claude: extensão Claude in Chrome e pasta conectada no Cowork
- No Codex: recursos de navegador, Gmail e sistema de arquivos disponíveis para as etapas correspondentes
- Conector do Gmail (rascunhos de proposta)
- Hospedagem HostGator com acesso ao cPanel

## Onde ficam os dados

Tudo na pasta conectada: `prospector-config.json` (preferências e credenciais — a senha do cPanel fica em texto no seu computador), `leads.md` (pipeline) e `sites/[slug]/` (páginas criadas).
