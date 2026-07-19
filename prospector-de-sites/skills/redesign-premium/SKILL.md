---
name: redesign-premium
description: Esta skill deve ser usada ao redesenhar o site de um cliente prospectado — criar uma versão nova, premium e de alta conversão da página existente, mantendo conteúdo, logo e paleta do cliente. Acione quando o usuário disser "redesenhar site", "melhorar página", "refazer o site do cliente" ou rodar /redesenhar ou /editor.
---

# Redesign premium de páginas

Criar uma NOVA VERSÃO da página do cliente — não uma página nova. O cliente precisa reconhecer o próprio negócio, só que elevado ao padrão que o faturamento dele merece.

## Regras invioláveis

1. **Nenhum FATO inventado — mas o texto deve ser APRIMORADO.** Todo serviço, credencial, número, endereço e contato vem do site original (ou do perfil do Google). Sem dados fictícios, sem depoimentos criados, sem serviços que o cliente não oferece. Porém o TEXTO não é copiado cru: reescreva com copy melhor — títulos mais fortes, frases mais claras, hierarquia de leitura — sempre dizendo a mesma verdade que o original diz.
2. **Fotos e logo originais são OBRIGATÓRIOS no site novo.** Toda foto utilizável do site existente (profissional, consultório, logo) deve constar na página nova, pelas URLs originais (colete via `img.currentSrc` no navegador, rolando a página inteira para vencer lazy-load). O cliente precisa se reconhecer na hora.
3. **Identidade preservada.** Manter logo, paleta de cores e fotos do cliente. Se a paleta original for fraca (ex.: cores puras saturadas), refinar os tons — nunca trocar a família de cores.
4. **Mais completo que o original.** O site novo deve ser MUITO mais profissional e bem estruturado. Se o original tem poucas seções, CRIE as seções relevantes que faltam — desde que preenchidas só com informação real: prova social (nota + avaliações reais do Google), "como funciona o atendimento" (se dedutível do original), localização com mapa, horários (do perfil do Maps), FAQ com dúvidas respondíveis pelo conteúdo real. Seção que exigiria inventar fato = não criar.
5. **Pasta estruturada (Vercel-ready).** Salve a página e seus recursos de forma organizada dentro do diretório `clientes_gerados/[slug]/`:
   - `index.html` — a página principal redesenhada.
   - `index-editor.html` — a mesma página com a camada de edição injetada.
   - `assets/css/style.css` — arquivos de estilização (CSS).
   - `assets/js/main.js` — lógicas em JavaScript, incluindo integrações GSAP e ScrollMagic.
   - `assets/img/` — diretório onde todas as fotos, logos e imagens locais do site devem ser salvos.
   As referências no HTML devem ser atualizadas para apontar para caminhos relativos locais, ex: `assets/img/nome-da-imagem.png`, `assets/css/style.css`, `assets/js/main.js`.
6. **Responsividade TOTAL (inegociável).** A página será vista no celular do cliente E dentro da moldura da página-capa (~1000-1500px). Ela deve ser perfeita em QUALQUER largura: 360, 375, 768, 1024, 1280 e 1440px — sem rolagem horizontal, sem texto vazando, sem imagem esticada, sem seção quebrada em nenhum desses pontos. Usar grid/flex fluidos, `clamp()` para tipografia e breakpoints testados um a um. Página que quebra em alguma largura NÃO é entregue.
7. **Editor sempre.** Todo redesign gera junto o `clientes_gerados/[slug]/index-editor.html` (camada de edição de `references/editor-visual.md`) — nunca entregar página sem a versão editável.
8. **Comparador sempre.** Todo lote de redesign termina com `comparar.html` na raiz da pasta conectada, gerado a partir de `references/comparador-template.html` (substituir `__CLIENTES__` pelo array JSON; mesclar com clientes já existentes). A entrega padrão de cada cliente é a pasta estruturada com index + editor + aba no comparador.

## Estrutura da página (adaptar à profissão)

1. **Hero**: nome + especialidade, promessa clara em 1 linha, CTA primário (WhatsApp) visível sem rolar, foto do profissional/clínica.
2. **Prova social**: nota do Google em destaque ("5.0 ★ · 121 avaliações no Google") — é real e verificável. Citar 2-3 trechos de avaliações reais do Google Maps se coletados.
3. **Serviços/áreas de atuação**: cards clicáveis — cada card leva à âncora da seção detalhada ou direto ao WhatsApp com mensagem pré-preenchida (`https://wa.me/55DDDNUMERO?text=Olá! Vim pelo site e quero saber sobre [serviço]`).
4. **Sobre**: formação e credenciais reais (geram autoridade — nunca cortar).
5. **Oferta estruturada** (quando fizer sentido): transformar "agende uma consulta" em opções de engajamento (ex.: sessão pontual, acompanhamento 90 dias, plano semestral) — SEM preços, apenas nomes e o que incluem, todos levando ao WhatsApp. Só criar planos que sejam agrupamento óbvio do serviço já oferecido.
6. **Localização e contato**: endereço, mapa (iframe do Google Maps), horários, telefone, redes.
7. **Rodapé**: dados do profissional (registro de classe se existir no original).

## Copywriting (aprimorar sem inventar — reescrever é obrigatório)

O texto do site novo NUNCA é o texto do site velho colado. Reescreva tudo com técnica, dizendo apenas o que o cliente já diz/oferece:

- **Headline do hero = benefício, não rótulo.** "Nutrição esportiva em SP" é rótulo; "Seu treino merece resultados que aparecem" é headline (com o rótulo virando kicker/subtítulo pra SEO).
- **Estrutura PAS suave** ao longo da página: toque na dor real do público, mostre o caminho, apresente o serviço como solução — no tom do nicho, sem agressividade de lançamento.
- **Escaneabilidade**: ninguém lê parágrafo de 8 linhas. Quebre em blocos de 2-3 linhas, bullets com verbo, subtítulos que contam a história sozinhos (quem só lê os títulos entende a página).
- **1 CTA por dobra**, sempre orientado à ação e ao benefício ("Quero minha avaliação" > "Clique aqui"), todos pro WhatsApp com mensagem pré-preenchida contextual.
- **Prova social costurada**, não empilhada: nota do Google perto do CTA, citação real perto da seção a que se refere.
- **Microcopy**: legendas sob botões ("resposta em poucos minutos"), rótulos humanos em formulários e seções.
- Proibido: clichês vazios ("qualidade e compromisso", "excelência no atendimento") sem fato que os sustente; superlativos inventados; promessas de resultado que o cliente não faz.

## Barra de qualidade estrutural (o "profissional de verdade")

A página pronta deve parecer feita por um estúdio de design — teste honesto: colocada ao lado de um template premium do nicho (clínicas/consultórios de alto padrão), ela não pode dever nada. Isso significa: grid consistente (mesmo espaçamento entre TODAS as seções), alinhamento impecável, alternância de ritmo entre seções (fundo claro/escuro/acento, largura cheia/contida), imagens com tratamento coerente (mesmo raio de borda, mesma temperatura), tipografia com no máximo 2 famílias e escala harmônica, e nenhuma seção "órfã" que pareça colada de outro site.

## Padrão estético e Frontend Design Premium

A página deve seguir diretrizes modernas de **Frontend-design** para transmitir altíssima credibilidade e sofisticação:

1. **Tipografia e Layout Fluidos:**
   - Usar no máximo 2 famílias de fontes do Google Fonts (ex: Playfair Display + Inter) com carregamento otimizado (`&display=swap`).
   - Tipografia fluida usando `clamp()` para títulos (ex: `font-size: clamp(2rem, 5vw, 3.5rem)`), garantindo legibilidade perfeita e proporcionalidade de tela.
   - Espaçamento generoso e dinâmico com grids de respiro vertical consistentes (ex: `padding: clamp(4rem, 8vw, 8rem) 0`).
2. **Micro-interações Modernas:**
   - Botões de CTA com transição suave (`transition: all 0.3s ease`) exibindo efeitos discretos como ampliação suave (`transform: scale(1.03)`) ou efeitos de brilho linear e bordas dinâmicas.
   - Sombras leves e finas para simular profundidade (ex: `box-shadow: 0 4px 20px rgba(0,0,0,0.05)`).
   - Efeito Glassmorphism (blur de fundo com opacidade parcial) para elementos flutuantes ou cabeçalhos fixos (`backdrop-filter: blur(12px); background: rgba(255,255,255,0.8);`).
   - Botão de WhatsApp flutuante fixo no canto inferior direito com pulso de atenção sutil.
3. **Acessibilidade e Desempenho:**
   - Taxa de contraste das cores de acordo com o padrão WCAG AA no mínimo (4.5:1).
   - Zero dependências pesadas ou frameworks de build. Arquivos estruturados em diretórios locais limpos e lincados por caminhos relativos.

## Integração de Animações (GSAP e ScrollMagic)

Para tornar a navegação interativa e elegante, integramos animações que reagem à rolagem da página. Os scripts necessários devem ser injetados via CDN na estrutura HTML padrão:

### 1. Injeção das Bibliotecas via CDN
No final do `<body>` da landing page, devem ser incluídos os scripts:
```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/ScrollMagic.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/plugins/animation.gsap.min.js"></script>
```

### 2. Padrão de Classes de Animação
* `.animate-on-scroll`: Aplicada a seções ou elementos principais que devem surgir com efeito fade-in e movimentação vertical suave.
* `.stagger-card`: Aplicada a elementos em grid (cards de serviços ou depoimentos) para que surjam sequencialmente.

### 3. Script Básico de Scroll (Injetado no HTML)
Injetar o seguinte bloco `<script>` após a importação das bibliotecas CDNs:
```html
<script>
  document.addEventListener("DOMContentLoaded", function() {
    // Desativa animações pesadas de scroll no mobile para manter performance
    if (window.innerWidth < 768) {
      document.querySelectorAll('.animate-on-scroll, .stagger-card').forEach(function(el) {
        el.style.opacity = "1";
        el.style.transform = "none";
      });
      return;
    }

    const controller = new ScrollMagic.Controller();

    // Revelação suave de seções individuais (.animate-on-scroll)
    document.querySelectorAll('.animate-on-scroll').forEach(function(el) {
      const tween = gsap.fromTo(el,
        { opacity: 0, y: 30 },
        { opacity: 1, y: 0, duration: 0.8, ease: "power2.out" }
      );
      new ScrollMagic.Scene({
        triggerElement: el,
        triggerHook: 0.85,
        reverse: false
      })
      .setTween(tween)
      .addTo(controller);
    });

    // Revelação sequencial em cascata (Stagger) para grids/cards
    const cards = document.querySelectorAll('.stagger-card');
    if (cards.length > 0) {
      const staggerTween = gsap.fromTo(cards,
        { opacity: 0, y: 40 },
        { opacity: 1, y: 0, duration: 0.8, stagger: 0.15, ease: "power2.out" }
      );
      new ScrollMagic.Scene({
        triggerElement: cards[0].parentElement,
        triggerHook: 0.85,
        reverse: false
      })
      .setTween(staggerTween)
      .addTo(controller);
    }
  });
</script>
```

## Checklist final (obrigatório antes de entregar)

- [ ] Zero texto placeholder / lorem ipsum
- [ ] Todos os links e CTAs apontam para contato REAL do cliente
- [ ] Número do WhatsApp no formato wa.me correto (55 + DDD + número)
- [ ] Responsivo verificado em 360, 375, 768, 1024, 1280 e 1440px — zero rolagem horizontal e zero quebra em TODAS
- [ ] Título e meta description preenchidos com nome + especialidade + cidade
- [ ] Comparação com o original: todo conteúdo importante do site antigo está presente
- [ ] Logo e fotos ORIGINAIS do cliente presentes na página nova
- [ ] `index-editor.html` gerado na pasta estruturada e `comparar.html` atualizado

## Editor visual e comparador

A camada de edição visual (para gerar `index-editor.html`) está em `references/editor-visual.md` — injetar o script exatamente como documentado lá. O comparador antes/depois está em `references/comparador-template.html` — substituir `__CLIENTES__` pelo array JSON e salvar como `comparar.html` na raiz da pasta conectada (mesclando com clientes existentes).
