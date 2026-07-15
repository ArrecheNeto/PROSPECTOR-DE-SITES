---
description: Busca no Google Maps negócios bem avaliados com sites ruins e gera a lista de leads
argument-hint: "[nicho] [cidade] — opcional, usa os padrões do config"
---

Prospecte leads qualificados seguindo a skill `prospeccao-maps`.

## Preparação

1. Leia `prospector-config.json` na pasta conectada. Se não existir, oriente a rodar `/setup` primeiro.
2. Determine nicho e cidade: use os argumentos `$ARGUMENTS` se informados; senão, ofereça as **categorias sugeridas** da skill `prospeccao-maps` (clínicas, dentistas, academias, restaurantes, lojas, imobiliárias, advocacia, contabilidades, veterinárias, escolas, construtoras, etc.) OU os nichos padrão do config, e confirme a cidade. As categorias são sugestões — o usuário SEMPRE pode digitar qualquer outro nicho e trocar a cidade na hora. Nunca trave na lista nem nos padrões.
3. Leia `leads.md` na pasta conectada (se existir) para saber quais profissionais já foram avaliados — estes devem ser EXCLUÍDOS da nova busca.

## Execução

Use as ferramentas do Claude in Chrome (carregue via ToolSearch se necessário) para abrir o Google Maps e executar o fluxo completo descrito na skill `prospeccao-maps`:

- Buscar "[nicho] em [cidade]"
- Avaliar até 25 estabelecimentos ou até atingir o número de leads qualificados do config (padrão 10), o que vier primeiro
- Critério ouro: nota alta (≥ 4.7) + muitas avaliações (≥ 40) + presença digital com oportunidade real (site fraco, SEO local fraco, GMN incompleto, redes paradas — ver análise digital da skill). Eliminatórios: reprovou no potencial financeiro → pula; presença digital sólida em tudo (baixa oportunidade) → pula; SEM nenhum canal de contato (sem e-mail, sem WhatsApp, sem Instagram) → pula. E-mail NÃO é mais obrigatório — o canal de abordagem é escolhido na ordem e-mail → WhatsApp → Instagram. Sempre registrar descartados com o motivo e seguir buscando até bater a meta
- Para cada candidato, rodar a análise digital da skill (notas 0-10 por dimensão: Site, Google, Instagram e Anúncios best-effort), classificar em 🔴/🟡/🟢, listar serviços recomendados e gerar a mensagem de 1º contato (diagnóstico + pedido de permissão)
- Coletar: nome, nota, nº de avaliações, telefone, **WhatsApp em formato 55DDDnúmero** (link wa.me no site ou celular do perfil do Maps — ver skill), e-mail, Instagram, canal de contato escolhido, URL do site, notas por dimensão, classificação, serviços e o motivo objetivo das notas baixas

## Saída — Google Sheets + dashboard + cópia local

1. **Google Sheets**: salve os leads numa PLANILHA DO GOOGLE via conector do Google Drive — `create_file` com `contentMimeType: text/csv` e o CSV como `textContent` (a conversão automática cria uma planilha nativa do Sheets). Título: `Leads Prospector — [nicho] [cidade]`. Colunas: #, Nome, Segmento, Cidade, Site, Instagram, Canal, Nota site, Nota Google, Nota IG, Problemas, Serviços recomendados, Prioridade (🔴/🟡/🟢), Situação (Qualificado/Descartado + motivo), Status, Mensagem pronta, URL nova. Inclua TODOS os avaliados (qualificados E descartados), ordenados pela priorização da skill (🔴 antes de 🟡 antes de 🟢). Colunas não confirmadas ficam com "não confirmado", nunca inventadas. Se o `create_file` falhar, mantenha o `leads.md` local e avise o usuário. Retorne o link da planilha ao usuário.
2. **Cópia local**: mantenha `leads.md` na pasta conectada como cópia de trabalho (o conector do Drive não edita células — os status `novo → redesenhado → publicado → proposta enviada` são atualizados no leads.md local, e a planilha do Google é regenerada com os dados acumulados ao fim de cada comando que muda status). Em rodadas novas, some os leads novos aos antigos numa planilha só, nunca duplique cliente já avaliado.
3. **Dashboard**: crie/atualize `dashboard.html` na raiz da pasta conectada seguindo a skill `dashboard-leads` (template + merge do JSON embutido) — leads novos entram com `status: novo`, descartados com `status: descartado`.

A entrega final DEVE incluir a confirmação explícita "Dashboard atualizado: [N] leads" (criando o dashboard pela skill `dashboard-leads` se a pasta não tiver um — obrigatório, nunca pule). Mostre a tabela ao usuário com o link da planilha e do `dashboard.html`, e sugira o próximo passo: `/redesenhar` para os 5+ melhores leads.
