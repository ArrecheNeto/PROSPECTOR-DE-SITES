# Anti-slop — a página não pode parecer feita por IA

Regras destiladas de detectores de "AI slop" (impeccable, taste-skill), adaptadas ao caso deste plugin: landing page estática de arquivo único, para negócio local real, preservando a identidade do cliente. O teste central: **se o nicho sozinho prevê o layout e a paleta que você escolheu, é reflexo de treinamento — refaça a escolha.** Duas páginas de clientes diferentes no mesmo lote NUNCA podem parecer o mesmo template com cores trocadas.

## Proibições visuais (reescrever se aparecer)

- **Texto em gradiente** (`background-clip: text`) — nunca.
- **Glassmorphism decorativo** (cartões de vidro desfocado sem função) — nunca.
- **Borda lateral colorida** (`border-left` grosso em cards/destaques) — o clichê nº 1 de IA.
- **Grade de cards idênticos** (ícone + título + texto repetido N vezes, tudo do mesmo tamanho). Se a seção de serviços pede cards, varie: tamanhos, um card com foto, um com a avaliação real do Google no meio.
- **Kicker/eyebrow em toda seção** (aquela linha CAPS pequena acima de cada título). Máximo 1 a cada 3 seções — conte antes de entregar.
- **Numeração decorativa de seções** ("01 · Serviços") — não usar.
- **Hero-métrica** (número gigante + label + gradiente) como abertura — não usar.
- **Cantos exagerados**: raio máximo 12-16px em cards (pill só em botões/tags). Sombra OU borda no card, não os dois empilhados.
- **Pontinhos de status, separadores "·" em série e faixas de texto decorativo** ("SAÚDE. CUIDADO. VIDA.") — não usar.
- **Emoji como ícone** e ícones SVG desenhados à mão — se precisar de ícone, use um conjunto consistente e discreto, ou nenhum.

## Proibições de texto (o slop verbal)

- **Zero travessão (—) no corpo da página.** Trocar por ponto, vírgula ou dois-pontos. É o tell textual mais detectado em texto de IA.
- **Verbos de slop**: eleve, potencialize, desbloqueie, transforme sua jornada, experiência única, soluções personalizadas. Se a frase serve para qualquer negócio do Brasil, ela não serve para este cliente.
- **Números perfeitos inventados** (99%, +1000 clientes) — só números reais e verificáveis (a nota e a contagem de avaliações do Google).
- **CTAs com a mesma intenção e rótulos diferentes** ("Fale conosco", "Entre em contato", "Chame no WhatsApp" espalhados): uma intenção = um rótulo, repetido idêntico.

## Ritmo de layout (onde o template se entrega)

- **Sem 3+ seções seguidas no mesmo esquema** imagem-esquerda/texto-direita alternado. Depois de 2, mude a estrutura: seção de largura cheia, faixa escura, coluna única centrada estreita, prova social intercalada.
- **Hero enxuto**: no máximo 4 elementos de texto (kicker opcional, título ≤ 2 linhas, subtítulo ≤ 20 palavras, CTA). Título ≤ 96px mesmo em telas grandes; letter-spacing nunca menor que -0.04em.
- **Espaçamento com variação**: seções não têm todas o mesmo padding — respiro maior antes das viradas importantes (oferta, contato).
- **`text-wrap: balance`** em títulos e **65-75 caracteres** de largura máxima em parágrafos.

## Cor (fugir do reflexo, sem trair a marca)

A paleta vem do cliente (regra 3 da skill) — o anti-slop aqui é em COMO usar:

- **Não caia no creme-de-IA**: fundo bege/areia morno como default é o reflexo de treinamento de 2025-26. Se o cliente não tem essa cor, derive os neutros do MATIZ da marca dele (um cinza levemente tingido da cor da marca), não "quentes por padrão".
- **Cinza puro e preto puro não existem**: sempre tinja levemente na direção da cor da marca.
- **Nada de texto cinza sobre fundo colorido** (fica lavado) — use tom mais escuro do próprio matiz do fundo.
- Escolha um nível de compromisso e mantenha: ou neutros + 1 acento (≤10% da superfície), ou uma cor dominante assumida. Meio-termo tímido é o que parece gerado.

## Tipografia

- A dupla serifada+sans da skill continua valendo, mas **varie a dupla entre clientes do mesmo lote** — Playfair+Inter em cinco páginas seguidas é assinatura de máquina. Alternativas: Fraunces, Lora, Libre Caslon, Newsreader × Sora, DM Sans, Albert Sans, Instrument Sans.
- Destaque dentro do título = itálico ou peso da MESMA família, nunca troca de família no meio da frase.
- Serifada só se combina com o nicho (saúde, direito, estética premium combinam; oficina mecânica provavelmente não) — deixe o negócio decidir, não o hábito.

## Movimento

- Animação só com motivo (hierarquia, feedback). Easing exponencial (ease-out), nunca bounce/elastic. Sem animar imagens no hover (zoom em foto ao passar o mouse = tell).
- Reveals não podem esconder conteúdo: o padrão é visível, a animação só realça. Respeitar `prefers-reduced-motion`.

## Checagem final anti-slop (adicionar à verificação da página)

- [ ] Zero travessões no texto da página
- [ ] Kickers CAPS ≤ ceil(nº de seções / 3)
- [ ] Nenhuma sequência de 3 seções com o mesmo esquema de layout
- [ ] Nenhum item da lista de proibições visuais presente
- [ ] Um rótulo único por intenção de CTA
- [ ] Paleta/tipografia diferentes das outras páginas do mesmo lote
- [ ] Pergunta honesta: "se eu cobrisse o logo, esta página poderia ser de qualquer concorrente?" — se sim, refaça o que a torna genérica
