# Agent.md: Onboarding e Domínio do Projeto

Este documento serve como onboarding e guia de domínio técnico e de negócios do plugin **Prospector de Sites (v2.1.0)** para o framework Antigravity e agentes inteligentes do Claude. Ele fornece o contexto necessário para que qualquer agente futuro entenda o ecossistema, regras de negócio e stack do repositório.

---

## 1. Resumo do Projeto

O **Prospector de Sites** é um plugin de automação de prospecção e vendas de websites voltado para agências, freelancers ou designers de páginas de alta conversão. Ele gerencia o ciclo completo de prospecção fria (*cold outreach*), venda e fechamento de clientes através de um funil semi-automático:

1. **Descoberta (/prospectar):** Encontra no Google Maps empresas com alta avaliação (nota ≥ 4.7) e muitas avaliações (≥ 40), mas que possuam um site desatualizado, lento ou com falhas de conversão (o "cliente ouro").
2. **Redesign (/redesenhar & /editor):** Cria uma versão moderna e de alto padrão estética da página web do cliente, mantendo sua identidade real (logos, fotos e paleta refinada), com uma interface de edição no navegador (sem código) e uma página de comparação de antes/depois.
3. **Publicação (/publicar):** Realiza o deploy automático da demonstração (atualmente na HostGator) e gera uma página-capa de proposta personalizada (`proposta.html`).
4. **Outreach (/proposta & /followup):** Gera e-mails de proposta personalizados, estruturados com técnicas anti-spam, e cria rascunhos no Gmail do usuário vinculando a página-capa de demonstração. Oferece follow-up inteligente após 3+ dias sem resposta.
5. **CRM & Fechamento (/respostas & /contrato):** Um painel Kanban local (`dashboard.html` servido via Python e SQLite) permite gerenciar o progresso de cada lead, detectar respostas via leitura de inbox do Gmail e gerar minutas de contratos de prestação de serviço em HTML e DOCX travado de forma ágil.

---

## 2. Stack Tecnológica

O projeto é estruturado como um plugin extensível para Claude (Cowork ou Claude Code). A arquitetura é distribuída entre comandos interpretados e scripts locais na máquina do usuário:

* **Arquitetura de Extensão:**
  * `commands/`: Arquivos Markdown contendo as diretrizes de prompt e fluxos operacionais de cada comando (ex: `/setup`, `/prospectar`, `/redesenhar`, `/publicar`, `/proposta`, `/respostas`, `/followup`, `/contrato`).
  * `skills/`: Diretórios de competências específicas (skills) que contêm o `SKILL.md` (prompts de sistema) e a pasta `references/` com templates e scripts de suporte.
* **Backend, Automação e Scripting:**
  * **Python 3:** Usado para rodar o servidor local do dashboard (`dashboard-server.py`) e para compilar arquivos `.docx` protegidos (`gerar-docx.py`).
  * **Shell Scripts & Automatizadores:** Scripts Windows (`.bat`, `.ps1`, `.vbs`) e macOS (`.command`) para gerenciar tarefas agendadas em segundo plano (como o publicador automático via FTP).
* **Banco de Dados (CRM Local):**
  * **SQLite 3:** Banco de dados local `prospector.db` persistido na pasta conectada do usuário.
* **Frontend (Apresentação, Editor e Dashboard):**
  * **HTML5, Vanilla CSS e Vanilla JavaScript:** Interfaces leves e autocontidas, sem frameworks pesados de build.
  * **Editor Visual:** Camada injetada via script JavaScript no HTML gerado para permitir edição de textos e imagens diretamente no navegador.
  * **Comparador de Sites:** Página com efeito slider antes/depois gerada dinamicamente (`comparar.html`).
* **Integrações e Dependências:**
  * **Navegador (Claude in Chrome):** Utilizado para realizar scraping no Google Maps e acessar interfaces administrativas (cPanel) se necessário.
  * **APIs de Conectores (Gmail e Google Drive):** Rascunhos de e-mail e persistência de dados em planilha de leads.
  * **Bibliotecas Python:** `python-docx` para geração de contratos.

---

## 3. Regras de Negócio e Contextos Importantes

Qualquer agente que venha a atuar no código ou fluxos deste plugin deve respeitar as seguintes regras invioláveis de negócio e segurança:

### A. Privacidade e Segurança de Credenciais
* **JAMAIS solicitar ou exibir senhas no chat:** As credenciais de cPanel, FTP ou APIs sensíveis residem unicamente em `prospector-config.json` no computador do usuário.
* **Exibição Protegida:** Em qualquer log, status ou comando printado, a senha deve ser mascarada ou omitida por completo.
* **Interface de Configuração:** O usuário deve ser instruído a salvar as credenciais através da aba de Configurações no dashboard local ou diretamente editando o arquivo de configuração local, nunca digitando-as nas mensagens.

### B. Diretrizes para Redesign Premium de Sites
1. **Fidelidade Factual:** É terminantemente proibido inventar fatos, serviços que a empresa não oferece, avaliações fictícias ou certificados inexistentes. O texto deve ser aprimorado com técnicas de copy (ex: framework PAS), mas focado no que é real.
2. **Ativos Reais:** O uso do logo real e de fotos reais do site original do cliente é obrigatório. As imagens são referenciadas pelas URLs originais para manter a autenticidade.
3. **Preservação de Identidade:** Manter a paleta de cores original do negócio, aplicando refinamentos harmônicos se a paleta antiga for muito saturada ou de baixo contraste.
4. **Responsividade Inegociável:** Os sites gerados devem ser perfeitamente responsivos (de 360px a 1440px) e estar estruturados em diretórios organizados na pasta `clientes_gerados/[slug]/` com HTML, CSS, JS e imagens locais, sem dependências externas de build.
5. **Entregável Estruturado:** Cada redesign gera o site estruturado na pasta `/clientes_gerados/[slug]/` (`index.html`), a versão com o editor visual habilitado (`index-editor.html`), assets locais (`assets/css/style.css`, `assets/js/main.js`, `assets/img/`), e atualiza o arquivo global `comparar.html`.

### C. Estratégia de E-mail de Proposta e Anti-Spam
1. **Curto e Focado em Curiosidade:** O e-mail deve ter de 120 a 180 palavras, conter rapport personalizado na primeira linha (baseado em avaliações reais) e focar em fazer o cliente clicar no link do redesign.
2. **Zero Menção a Preços:** Nunca colocar preços na proposta inicial por e-mail.
3. **Limitação de Links (Max. 1-2):** Idealmente, incluir apenas o link para a página-capa (`proposta.html`).
4. **Formato de Link Limpo:** Criar o rascunho em HTML de modo que o texto visível da âncora `<a>` seja a própria URL limpa (ex: `https://dominio.com/...`), evitando o visual "sujo" causado pelo redirecionamento automático do Gmail (`google.com/url?q=...`).
5. **Sem Gatilhos de Spam:** Banido o uso de palavras comerciais ("grátis", "desconto", "oferta", "urgente") ou caixa alta/emojis no assunto.
6. **Frequência Humana:** Os e-mails são gerados em modo rascunho no Gmail pessoal do usuário para envio individual e manual, evitando bloqueios por disparos em massa.

### D. CRM e Sincronização Local
* O banco SQLite (`prospector.db`) é a única fonte da verdade do status dos leads.
* Sempre que um comando alterar o status de um lead, ele deve atualizar o banco SQLite e atualizar o snapshot JSON contido em `dashboard.html` para garantir que o painel exiba as informações corretas, mesmo se o usuário abrir o arquivo diretamente no navegador (sem o servidor Python ativo).

---
