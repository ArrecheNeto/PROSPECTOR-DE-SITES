# 🎯 Prospector de Sites — v2.1.0

**Plugin para Claude (Cowork) que roda o ciclo completo de prospecção e venda de sites — com CRM local incluso:**

**Achou → Refez → Publicou → Ofertou → Acompanhou → Fechou → Contrato.**

De graça, rodando no seu computador, sem mensalidade.

## O que a v2 faz

| Comando | O que acontece |
|---|---|
| `/setup` | Configura tudo uma vez (pasta, assinatura, nichos) e entrega o manual + dashboard |
| `/prospectar` | Diagnóstico consultivo B2B: varre o Google Maps (qualquer nicho), dá notas 0-10 de Site/Google/Instagram/Anúncios, classifica em 🔴/🟡/🟢, recomenda serviços, prioriza e já escreve a mensagem de 1º contato (que pede permissão) → planilha no Google Sheets + CRM |
| `/redesenhar` | Recria as páginas com estética premium (fotos/logo/conteúdo REAIS) + editor visual + comparador antes/depois |
| `/editor` | Edita texto e imagem da página no navegador, sem código |
| `/publicar` | Publica na HostGator SOZINHO (publicador automático, sem cPanel) + página-capa da proposta + HTTPS validado |
| `/proposta` | E-mail com rapport real, checklist anti-spam e a capa personalizada como link |
| `/respostas` | Lê seu Gmail e move o card sozinho quando o cliente responde (agende diário!) |
| `/followup` | 3+ dias sem resposta? Gera o lembrete gentil — 1 por lead, nunca repete |
| `/contrato` | Fechou? Folha A4 imprimível + Word TRAVADO (cliente só preenche onde você deixar) |

## 📊 CRM local (dashboard)

Kanban com drag & drop (colunas Novo → **Permissão concedida** → Redesenhado → Publicado → Proposta → Respondeu → Fechado), funil, clientes, sites, comparador, follow-ups, contratos e painel financeiro (recebido, a receber, MRR e projeção 12 meses) — tudo num banco SQLite **na sua pasta**. Duplo clique no `iniciar-dashboard.bat` (Windows) ou `iniciar-dashboard.command` (Mac). Requisito: [Python](https://www.python.org/downloads/) (marque "Add to PATH").

> 🤝 **Funil consultivo:** o `/prospectar` não manda o site pronto de cara — ele diagnostica e **pede permissão**. Quando o cliente autoriza ver a versão, o card entra em *Permissão concedida* e só então você roda `/redesenhar`. Você investe trabalho só em quem já topou.

## Como instalar

**No Claude Cowork:** Plugins → Gerenciar plugins → Adicionar marketplace → cole a URL deste repositório → instale o **prospector-de-sites** → rode `/setup`.

**No Claude Code:**
```
/plugin marketplace add ArrecheNeto/PROSPECTOR-DE-SITES
/plugin install prospector-de-sites@arrecheneto-plugins
```

## 🔄 Já tem o plugin e não atualiza?

Re-adicionar o link NÃO atualiza (fica em cache). Faça:
```
/plugin marketplace update arrecheneto-plugins
```
e reinicie o app — a versão certa é a **2.1.0** (confira em Gerenciar plugins). Se não subir: desinstale o plugin → remova o marketplace → feche o app → adicione e instale de novo. A partir da 2.1.0 a atualização é automática (autoUpdate ativado).

## Requisitos

Claude Cowork · extensão Claude in Chrome · conectores Gmail e Google Drive · hospedagem HostGator (plano M+) · Python (para o dashboard e o publicador) · Windows ou Mac.

## Manual

O `/setup` entrega o [manual completo](prospector-de-sites/manual.html) na sua pasta — passo a passo de tudo, incluindo a seção "E no Mac?" e os problemas comuns.

---

Feito por **Helio Arreche** · [YouTube](https://youtube.com/@helioarreche) · [Instagram @helioarreche](https://instagram.com/helioarreche) · Série completa do plugin no canal 🎬
