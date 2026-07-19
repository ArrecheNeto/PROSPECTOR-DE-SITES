# Plano de Ação: Modernização de Deploy (Vercel) e Aprimoramento do Frontend (GSAP & ScrollMagic)

Este plano de ação detalha o roteiro de refatoração do plugin **Prospector de Sites** para migrar o sistema de publicação do HostGator para a **Vercel** e integrar bibliotecas de animação de alta performance (**GSAP** e **ScrollMagic**), elevando a qualidade visual e de conversão dos sites gerados.

---

## 1. Migração do Sistema de Deploy (HostGator → Vercel CLI)

### A. Nova Arquitetura de Deploy
Atualmente, o deploy na HostGator depende de um sistema complexo de sincronização de fila (`fila-publicacao.txt`) e scripts locais via Agendador de Tarefas do Windows/launchd do macOS, porque a rede do sandbox do Cowork geralmente bloqueia conexões diretas de FTP (Método 2).
Com a **Vercel CLI** instalada e autenticada na máquina local do usuário, o agente de execução poderá realizar o deploy **diretamente a partir do sandbox** executando comandos shell no terminal local (`run_command`). Isso elimina totalmente a necessidade de scripts de fila em segundo plano (`instalar-publicador.bat`, `publicador-oculto.vbs`, etc.).

### B. Fluxo de Publicação e Domínios
O novo fluxo dividirá o deploy em duas fases de acordo com o status comercial do lead:

1. **Deploy de Demonstração (Lead Prospectado):**
   * Ao rodar `/publicar [cliente]`, o plugin irá criar e configurar o projeto na Vercel para o cliente usando a pasta `sites/[slug]`.
   * Comando de deploy silencioso:
     ```bash
     vercel deploy --name "demo-[slug]" --yes --cwd "C:/Users/keito/Documents/Projeto/Plugins Claude/sites/[slug]"
     ```
   * O comando retornará a URL de demonstração automática gerada pela Vercel (ex: `https://demo-[slug].vercel.app`).
   * A página de proposta (`proposta.html`) e a landing page (`index.html`) ficarão disponíveis sob a mesma URL base.
   * O banco de dados `prospector.db` será atualizado com o status `publicado` e o link da demonstração.

2. **Deploy Definitivo (Contrato Fechado):**
   * Ao rodar `/contrato [cliente]` ou alterar o status do lead para `fechado` no Kanban do dashboard, o sistema iniciará a vinculação de domínio personalizado definitivo.
   * O plugin solicitará ao usuário o domínio próprio comprado pelo cliente (ex: `drfulando.com.br`).
   * Vinculação do domínio ao projeto da Vercel:
     ```bash
     vercel domains add [dominio-cliente] --cwd "C:/Users/keito/Documents/Projeto/Plugins Claude/sites/[slug]"
     ```
   * O plugin exibirá os registros DNS necessários (geralmente tipo `A` apontando para `76.76.21.21` ou `CNAME` apontando para `cname.vercel-dns.com`) para que o usuário informe ao cliente ou configure no registrador do domínio.
   * O banco de dados e o CRM local atualizarão a `urlNova` para a URL definitiva.

### C. Alterações nos Arquivos de Configuração
* **`prospector-config.json`:**
  * Remover os campos do bloco `hostgator` (`usuario`, `servidor`, `senha`).
  * Adicionar ou manter apenas parâmetros de organização (como `vercel_org` ou `vercel_team` se houver, embora o CLI configurado por padrão use o escopo do usuário conectado).
* **`commands/setup.md` e `commands/publicar.md`:**
  * Remover instruções de configuração de FTP/cPanel.
  * Substituir o teste de conexão por um comando de verificação da CLI (`vercel whoami`).
* **`skills/deploy-hostgator`:**
  * Excluir ou renomear para `skills/deploy-vercel`, alterando as instruções no `SKILL.md` e apagando os scripts de FTP em `references/`.

---

## 2. Aprimoramento do Frontend (ScrollMagic, GSAP e Frontend Design)

Para elevar a estética visual das páginas redesenhadas a um patamar premium de estúdio de design, a estrutura HTML estática das landing pages receberá animações suaves e interações modernas de scroll.

### A. Método de Injeção das Bibliotecas
Como os sites redesenhados devem permanecer autocontidos em arquivos HTML únicos sem dependência de processos de build (regra de negócio), as bibliotecas serão injetadas via CDN no final do `<head>` ou do `<body>` do arquivo `sites/[slug]/index.html`:

```html
<!-- GSAP (GreenSock Animation Platform) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>

<!-- ScrollMagic -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/ScrollMagic.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/plugins/animation.gsap.min.js"></script>
```

### B. Padrão de Animação e Layout (Skill Frontend-Design)
As animações e estilos visuais injetados pelo plugin seguirão as diretrizes de design moderno e refinado:

1. **Scroll Revealing (Revelação na Rolagem):**
   * As seções da página terão um estado inicial invisível (ex: `opacity: 0; transform: translateY(30px);`).
   * O ScrollMagic acionará a animação do GSAP correspondente no momento em que a seção entrar na janela de visualização (*viewport*).
2. **Preset de Código de Animação Padrão (injetado no HTML):**
   ```html
   <script>
     document.addEventListener("DOMContentLoaded", function() {
       // Inicializa o controle do ScrollMagic
       const controller = new ScrollMagic.Controller();

       // Animação de entrada dos cards de serviços em cascata (Stagger)
       const cards = document.querySelectorAll('.service-card');
       if (cards.length > 0) {
         const cardTween = gsap.fromTo(cards, 
           { opacity: 0, y: 50 },
           { opacity: 1, y: 0, duration: 0.8, stagger: 0.2, ease: "power2.out" }
         );

         new ScrollMagic.Scene({
           triggerElement: ".services-section",
           triggerHook: 0.85,
           reverse: false
         })
         .setTween(cardTween)
         .addTo(controller);
       }

       // Revelação suave de cada seção principal
       document.querySelectorAll('.animate-on-scroll').forEach(section => {
         const sectionTween = gsap.fromTo(section,
           { opacity: 0, y: 40 },
           { opacity: 1, y: 0, duration: 1, ease: "power3.out" }
         );

         new ScrollMagic.Scene({
           triggerElement: section,
           triggerHook: 0.8,
           reverse: false
         })
         .setTween(sectionTween)
         .addTo(controller);
       });
     });
   </script>
   ```
3. **Estética Visual Avançada:**
   * Utilização de tipografia dinâmica com escala baseada na função `clamp()` do CSS.
   * Alternação de contraste rica (seções claras alternadas com fundos escuros refinados e detalhes em HSL/RGB dinâmicos).
   * Micro-animações nativas com CSS em botões (CTAs) de agendamento (ex: transição suave de escala de `1` para `1.03` no hover e brilhos sutis nas bordas).
   * Desativação inteligente de animações pesadas de scroll no mobile (`window.innerWidth < 768`) para poupar bateria e evitar travamentos no celular do cliente.

---

## 3. Cronograma de Execução (Passo a Passo para a Próxima Etapa)

O agente de execução que assumir o projeto deve seguir esta sequência ordenada:

### Fase A: Preparação e Limpeza
* [ ] **Passo 1:** Fazer backup e remover os scripts antigos da HostGator localizados em `prospector-de-sites/skills/deploy-hostgator/references/`.
* [ ] **Passo 2:** Atualizar a declaração do plugin em `prospector-de-sites/.claude-plugin/plugin.json` e `README.md` alterando as referências do deploy de HostGator para Vercel.

### Fase B: Refatoração dos Comandos do Plugin
* [ ] **Passo 3:** Refatorar `commands/setup.md`:
  * Alterar o fluxo de configuração do HostGator para validação da Vercel CLI.
  * O teste de deploy no setup deve ser feito enviando uma página simples para a Vercel.
* [ ] **Passo 4:** Refatorar `commands/publicar.md`:
  * Modificar o método de deploy para rodar comandos `vercel deploy` no diretório do cliente usando a CLI.
  * Capturar a URL final gerada no output do terminal e utilizá-la para preencher o banco de dados e os links de proposta.
* [ ] **Passo 5:** Atualizar a skill de publicação: renomear `skills/deploy-hostgator` para `skills/deploy-vercel` e reescrever o `SKILL.md` focando exclusivamente nos comandos da Vercel CLI (deploys demo e definitivos com link de domínios).

### Fase C: Dashboard e CRM Local
* [ ] **Passo 6:** Editar o arquivo `skills/dashboard-leads/references/dashboard-template.html`:
  * Atualizar a aba de Configurações, trocando o formulário de conexão HostGator por configurações e status da conta Vercel (exibindo se a CLI está ativa e qual o usuário conectado).
  * Criar um botão "Vincular Domínio Próprio" no card do cliente no Kanban (para leads com status `fechado`), que dispara o comando CLI para adicionar o domínio do cliente na Vercel e retorna as instruções DNS.

### Fase D: Aprimoramento da Skill de Redesign
* [ ] **Passo 7:** Modificar `skills/redesign-premium/SKILL.md`:
  * Incluir a regra de injeção dos scripts do GSAP e ScrollMagic via CDN na estrutura padrão de páginas novas.
  * Adicionar diretivas detalhadas sobre o padrão de classes (como `.animate-on-scroll`) e o script básico de controle de scroll.
  * Adicionar requisitos de design premium adicionais da skill `frontend-design`.

---
