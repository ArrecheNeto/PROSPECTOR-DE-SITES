# 🎯 Prospector de Sites — v2.1.0

**Plugin para Claude (Cowork) que roda o ciclo completo de prospecção e venda de sites — com CRM local incluso:**

**Achou → Refez → Publicou → Ofertou → Acompanhou → Fechou → Contrato.**

De graça, rodando no seu computador, sem mensalidade.

## O que a v2 faz

| Comando | O que acontece |
|---|---|
| `/setup` | Configura tudo uma vez (pasta, assinatura, nichos) e entrega o manual + dashboard |
| `/prospectar` | Varre o Google Maps: negócios nota ≥ 4.7 com site fraco E e-mail público → planilha no Google Sheets + CRM |
| `/redesenhar` | Recria as páginas com estética premium (fotos/logo/conteúdo REAIS) + editor visual + comparador antes/depois |
| `/editor` | Edita texto e imagem da página no navegador, sem código |
| `/publicar` | Publica na Vercel SOZINHO (via Vercel CLI) + página-capa da proposta + HTTPS validado |
| `/proposta` | E-mail com rapport real, checklist anti-spam e a capa personalizada como link |
| `/respostas` | Lê seu Gmail e move o card sozinho quando o cliente responde (agende diário!) |
| `/followup` | 3+ dias sem resposta? Gera o lembrete gentil — 1 por lead, nunca repete |
| `/contrato` | Fechou? Folha A4 imprimível + Word TRAVADO (cliente só preenche onde você deixar) |

## 📊 CRM local (dashboard)

Kanban com drag & drop, funil, clientes, sites, comparador, follow-ups, contratos e painel financeiro (recebido, a receber, MRR e projeção 12 meses) — tudo num banco SQLite **na sua pasta**. Duplo clique no `iniciar-dashboard.bat` (Windows) ou `iniciar-dashboard.command` (Mac). Requisito: [Python](https://www.python.org/downloads/) (marque "Add to PATH").

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

Claude Cowork · extensão Claude in Chrome · conectores Gmail e Google Drive · conta Vercel (CLI instalada e autenticada) · Python (para o dashboard) · Windows ou Mac.

## Manual

O `/setup` entrega o [manual completo](prospector-de-sites/manual.html) na sua pasta — passo a passo de tudo, incluindo a seção "E no Mac?" e os problemas comuns.

---

Feito por **Helio Arreche** · [YouTube](https://youtube.com/@helioarreche) · [Instagram @helioarreche](https://instagram.com/helioarreche) · Série completa do plugin no canal 🎬
