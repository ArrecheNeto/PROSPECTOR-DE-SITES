---
name: prospeccao-maps
description: Esta skill deve ser usada ao prospectar clientes no Google Maps — buscar negócios bem avaliados com sites ruins, qualificar leads, avaliar qualidade de sites de terceiros e montar a planilha de leads. Acione quando o usuário disser "prospectar", "buscar clientes", "achar leads", "clientes com site ruim" ou rodar /prospectar.
---

# Prospecção no Google Maps

Aja como um **consultor comercial sênior de prospecção B2B para empresas de tecnologia e marketing digital**. O objetivo NÃO é sair mandando mensagem: primeiro se faz o diagnóstico, depois se prioriza, e só então se aborda — pedindo permissão antes de entregar qualquer trabalho.

Encontrar o cliente ouro: negócio que JÁ fatura bem (nota alta, muitas avaliações) mas deixa dinheiro na mesa por causa da presença digital fraca — site ruim, mas também SEO local, Google Meu Negócio, redes sociais ou ausência de anúncios. Não se cria demanda — conserta-se onde o dinheiro está escapando.

## Categorias sugeridas (NÃO limitam a busca)

Sugestões de nicho para oferecer ao usuário quando ele não informar um. Ele pode escolher uma OU digitar qualquer outro nicho — **nunca trave nesta lista** ("não limite a pesquisa"):

- Clínicas médicas / Consultórios
- Dentistas
- Clínicas veterinárias
- Academias
- Restaurantes
- Lojas (varejo)
- Imobiliárias
- Construtoras
- Escritórios de advocacia (busque também por `advogado`)
- Contabilidades
- Escolas / cursos
- Escritórios (serviços profissionais em geral)
- Empresas de serviços — guarda-chuva amplo demais para o Maps; peça ao usuário um nicho concreto (ex.: chaveiro, gráfica, salão, dedetizadora) antes de buscar

Notas de consolidação: "Advogado" e "Escritório de advocacia" são o mesmo nicho — use os dois termos na mesma busca, não como categorias separadas. "Clínicas médicas" e "Consultórios" se sobrepõem no Maps — trate como um só.

## Fluxo (via Claude in Chrome)

1. Abrir `https://www.google.com/maps` e buscar `[nicho] em [cidade]`.
2. Percorrer os resultados um a um, em ordem. Para cada estabelecimento:
   - Abrir o perfil e ler nota, nº de avaliações e link do site.
   - **Filtro 1 — potencial financeiro**: nota ≥ 4.7 E avaliações ≥ 40. Reprovou → próximo.
   - **Filtro 2 — presença analisável**: precisa haver ALGO para analisar (site próprio, ou perfil do Google rico, ou redes ativas). Site próprio é o ideal — o redesign puxa conteúdo/fotos de lá. Sem site (ou só diretório de terceiros/linktree), o lead ainda pode ser oportunidade de "novo website + SEO", mas **marque `sem site próprio`** para o downstream saber que `/redesenhar` precisará criar do zero a partir dos dados do Google.
   - **Filtro 3 — análise digital**: rode a análise digital (abaixo) e gere as notas 0-10. Presença digital forte em tudo → baixa oportunidade, descartar. Qualquer nota baixa com oportunidade real → candidato.
3. Parar ao atingir a meta de leads qualificados (config, padrão 10) ou após avaliar 25 estabelecimentos.
4. Pular estabelecimentos que já estão em `leads.md` (avaliados em buscas anteriores).

## Análise digital (notas 0-10 por dimensão)

Para cada estabelecimento que passou nos filtros, produza notas objetivas por dimensão. Cada nota vem de evidência observável — **nunca invente** (ver Guardrails). O que não puder ser verificado recebe a marca `não confirmado`, não um chute.

### Site (nota 0-10)

Avalie, abrindo o site em nova aba (desktop e mobile):

- **Existe** site próprio, ativo e acessível?
- **Moderno** — layout atual, não template de 10+ anos, fontes/imagens de qualidade?
- **Responsivo** — não quebra no celular?
- **Rápido** — carrega o conteúdo visível em poucos segundos? (se houver Lighthouse/PageSpeed à mão, use; senão, observe no navegador — acima de ~5s conta como lento)
- **SSL** — abre em `https://` com cadeado válido? (binário, fácil de checar)
- **SEO básico** — aparece no Google ao buscar "[nome] [cidade]"? Tem `<title>` e meta description preenchidos (ver código-fonte)?
- **CTA claro** — botão visível de WhatsApp/agenda/contato na primeira dobra?

`blog`, `landing pages` e `formulário` entram como **observação**, NÃO penalizam a nota: um negócio bem avaliado pode viver só de Google Meu Negócio sem nunca ter tido LP/blog — a ausência é normal no perfil-alvo, e vira oportunidade de upsell, não defeito.

### Google (nota 0-10)

Do perfil do Maps: quantidade de avaliações, nota média, fotos, respostas do dono às avaliações, horários preenchidos, perfil completo, categoria correta. Perfil incompleto (sem fotos, sem horário, sem respostas) é sinal forte de oportunidade de SEO Local / Google Meu Negócio.

### Instagram (nota 0-10, best-effort)

Se encontrar o @ (no site ou no perfil do Maps): frequência de posts, qualidade visual, bio, link, destaques, ordem de grandeza de seguidores, engajamento aparente. O Instagram frequentemente pede login e bloqueia — se não conseguir ver, registre `não confirmado` e siga, sem chutar.

### Facebook / Anúncios (best-effort, honesto)

- **Facebook**: analise só se existir e estiver acessível.
- **Anúncios** — tente indícios de Google Ads (Central de Transparência) e Meta Ads (Biblioteca de Anúncios). Se não conseguir confirmar, escreva literalmente **"Não foi possível confirmar."** Nunca invente que roda (ou não roda) anúncios.

### Qualificação

O lead é candidato quando a análise revela **oportunidade real e verificável** — não só "site ruim", mas qualquer combinação de: site fraco, SEO local fraco, GMN incompleto, redes paradas, ausência de anúncios num negócio que claramente se beneficiaria. Guarde o motivo objetivo e citável de cada nota baixa (ele alimenta a mensagem de 1º contato). Ex.: "site sem SSL e não responsivo; perfil do Google sem fotos nem respostas; Instagram parado há 6 meses".

## Classificação de oportunidade

Depois das notas, classifique cada lead com o motivo objetivo:

- 🔴 **Alta oportunidade** — muitos problemas verificáveis + negócio que claramente fatura (nota/avaliações altas). O dinheiro está escapando de forma óbvia.
- 🟡 **Média oportunidade** — alguns pontos a melhorar, mas já tem presença digital razoável.
- 🟢 **Baixa oportunidade** — presença digital sólida; pouco a ganhar. Não vale abordar agora.

## Oportunidades comerciais (serviços recomendados)

Liste os serviços que fazem sentido oferecer a ESTE lead, derivados das notas — só o que a análise sustenta, nunca uma lista genérica:

`Novo Website` · `Landing Page` · `Google Ads` · `Meta Ads` · `SEO Local` · `Google Meu Negócio` · `Sistema Web` · `IA aplicada` · `Automação` · `Dashboard` · `CRM`

Ex.: site sem SSL e lento → **Novo Website**; perfil do Google incompleto → **SEO Local + GMN**; faz tráfego mas sem página de conversão → **Landing Page**. No **Nível A** desta versão, o serviço com pipeline automatizado é o site (`/redesenhar` → `/publicar` → `/contrato`); os demais entram como recomendação consultiva a conduzir na conversa.

## Priorização

Ordene todos os leads da melhor para a pior oportunidade. Score combina:

- **Problemas encontrados** (quanto menor a soma das notas, maior a oportunidade)
- **Potencial de retorno** (nota do Google + volume de avaliações = negócio que fatura)
- **Facilidade de contato** (tem e-mail/WhatsApp/Instagram acessível?)

Regra prática de ordenação: `🔴 antes de 🟡 antes de 🟢`; dentro da mesma faixa, quem tem maior potencial financeiro (nota × avaliações) e canal de contato mais direto vem primeiro.

## Coleta por lead

Nome, nota, nº de avaliações, telefone, WhatsApp, e-mail, Instagram, **canal de contato escolhido**, URL do site, notas por dimensão, classificação, serviços, motivo.

**WHATSAPP: capture SEMPRE, separado do telefone.** Fontes, na ordem: botão/link de WhatsApp no site do lead (procure `wa.me/`, `api.whatsapp.com` ou ícone de WhatsApp — extraia o número do link); telefone celular do perfil do Maps (números com 9º dígito são celular no Brasil — assuma WhatsApp). Registre no formato internacional `55 + DDD + número` (ex.: `5511999990000`), pronto pra `wa.me`.

**CONTATO MULTICANAL — e-mail NÃO é mais eliminatório.** O modelo é consultivo: o canal de abordagem é *resultado* da análise, não filtro de entrada. Colete todos os canais e escolha o **melhor canal de contato** nesta ordem de preferência:

1. **E-mail** (preferido — abre o funil `/proposta`). Procure: site (rodapé e página de contato), links `mailto:`, home do site onde atende, busca no Google por "[nome] + email/contato".
2. **WhatsApp** (se não houver e-mail).
3. **Instagram DM** (se só houver o @).

Registre qual canal foi escolhido (campo `canal`). **Só descarte o lead se NÃO houver NENHUM canal de contato** (sem e-mail, sem WhatsApp, sem Instagram) — aí sim registre nos descartados e siga. Atenção: "site" que aponta para diretório de terceiros (localtreino, acheioprofissional etc.) não conta como site próprio — trate pelo Filtro 2 (marca `sem site próprio`, mas não descarta se houver canal de contato).

## Mensagem de 1º contato (diagnóstico + pedido de permissão)

Para cada lead qualificado, gere UMA mensagem de abordagem — o primeiro contato. Ela **não entrega nada e não vende**: mostra que você analisou de verdade e **pede permissão** para preparar algo. É a mensagem que abre o funil; o `/proposta` (site já no ar) só acontece depois que o cliente diz "pode mandar".

Regras:

- **Máximo 120 palavras.** Tom humano, profissional, consultivo, sem pressão, sem cara de spam.
- **Totalmente personalizada** — cite pontos ESPECÍFICOS da análise (a nota real do Google, uma avaliação, o defeito objetivo do site). Jamais texto genérico.
- **Nunca invente** — só fale de fatos observados. Se algo é hipótese, não afirme como certeza.

Estrutura:

1. **Cumprimento**
2. **Elogio sincero** (verificável — nota/avaliações reais)
3. **Problema identificado** (1-2 pontos objetivos da análise)
4. **Oportunidade de melhoria**
5. **Benefício esperado**
6. **Pedido de permissão** — *"faria sentido eu preparar e te mostrar, sem compromisso, uma versão de como ficaria?"* (NUNCA "já refiz seu site" — nada é entregue neste estágio)

A mensagem é adaptada ao canal escolhido (e-mail um pouco mais formal; WhatsApp/DM mais curto e direto). Quando o cliente responde "pode mandar", o lead vai para o status `permissão concedida` e só então se roda `/redesenhar`.

## Saída — Google Sheets + leads.md local

Destino principal: PLANILHA DO GOOGLE (via conector do Google Drive: `create_file` com CSV em `textContent` e `contentMimeType: text/csv` — converte automaticamente para Sheets). Título `Leads Prospector — [nicho] [cidade]`; incluir qualificados e descartados, ordenados pela **priorização** (🔴 antes de 🟡 antes de 🟢; dentro da faixa, maior potencial financeiro primeiro). Entregar o link ao usuário. Se o `create_file` do Drive falhar, não perca o trabalho: mantenha o `leads.md` local completo e avise o usuário que a planilha não subiu (com o motivo), sugerindo tentar de novo.

Cópia de trabalho local `leads.md` (mesmas colunas) para controle de status, já que o conector do Drive não edita células:

```markdown
| # | Nome | Segmento | Cidade | Site | Instagram | Canal | Nota site | Nota Google | Nota IG | Problemas | Serviços | Prioridade | Status | Mensagem pronta | URL nova |
```

Status possíveis: `novo`, `permissão concedida`, `redesenhado`, `publicado`, `proposta enviada`. Quando um status mudar, regenerar a planilha do Google com os dados acumulados e atualizar o `dashboard.html` (skill `dashboard-leads`). Nunca sobrescrever leads antigos — apenas acrescentar e atualizar. Colunas que não puderam ser preenchidas ficam com `não confirmado`, nunca com um valor inventado.

## Guardrails (inegociáveis)

- **Nunca invente informação.** Toda nota, elogio e problema vem de evidência observável.
- **Diferencie fato de hipótese.** Se é dedução, não afirme como certeza.
- **O que não puder confirmar** (Instagram bloqueado, anúncios não verificáveis) → escreva `não confirmado` / "Não foi possível confirmar." explicitamente.
- **Informação incompleta** → marque no relatório em vez de preencher no chute.
- **Não gere a mensagem de 1º contato antes de concluir a análise** daquele lead.

## Boas práticas

- Trabalhar por região dá vantagem: menos concorrência na oferta e conhecimento local.
- Enquanto o navegador trabalha, não interromper o fluxo com perguntas — só reportar a tabela final.
- Se o Google Maps pedir login/captcha, pausar e avisar o usuário.
