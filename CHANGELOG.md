# Changelog

## 0.20.0 — 2026-07-13

### Instalável como plugin no Codex (não só via script)

- Novo `.agents/plugins/marketplace.json` na raiz: catálogo de marketplace no formato que o Codex exige (sem ele o Codex recusa o repo com "marketplace root does not contain a supported manifest"). Aponta para `./prospector-de-sites`.
- Novo `prospector-de-sites/.codex-plugin/plugin.json`: manifesto do plugin para Codex (`"skills": "./skills/"`), ao lado do já existente `.claude-plugin/plugin.json` — mesma pasta serve as duas plataformas (padrão do carrossel-markplace-pro).
- Agora dá pra adicionar o repo pelo `/plugins` do Codex e as 7 skills entram sozinhas; o `codex/instalar-codex.sh` virou EXTRA opcional só para os atalhos de comando (`$prospectar` etc.).
- Skill `prospeccao-web` movida de `codex/skills/` para `prospector-de-sites/skills/` (fonte única, empacotada no plugin) e reescrita como método neutro "sem navegador automatizado", com nota para preferir `prospeccao-maps` quando houver navegador controlável.
- Novo `SYNC-COWORK-CODEX.md`: regra de manutenção dos dois alvos e checklist de versão (4 arquivos alinhados). Versão 0.20.0.

## 0.19.0 — 2026-07-13

### Codex: e-mail e Maps via @Chrome e @Computer Use

- `AGENTS-modelo.md` agora roteia por capacidade da sessão: com a extensão **Codex for Chrome** (`@Chrome`), prospecção segue a `prospeccao-maps` original no Google Maps real e o e-mail segue a seção "Envio" da `proposta-email` no webmail logado (Gmail/iCloud), com conferência do campo "De"; no Mac, **@Computer Use** vira alternativa para rascunhos no Apple Mail (sincronizados com o iCloud); sem nenhum dos dois, valem os fallbacks anteriores (`prospeccao-web` + `emails-prontos/`).
- Rascunho continua sendo o modo padrão em todos os níveis; envio direto exige config + confirmação na sessão. Proibição explícita de digitar senha/código do usuário.
- `prospeccao-web` orienta preferir a `prospeccao-maps` quando `@Chrome` existir.

## 0.18.0 — 2026-07-13

### Prospecção no Codex por pesquisa assistida

- Nova skill `prospeccao-web` (instalada pelo `codex/instalar-codex.sh`): variante da `prospeccao-maps` para o Codex, inspirada na metodologia do local-client-prospector-skill — descoberta por busca web + fontes públicas + verificação cruzada, em vez de automação do Google Maps. Mantém os filtros do plugin (nota ≥ 4.7, ≥ 40 avaliações, site ativo porém ruim, e-mail obrigatório), com regras de conformidade (sem scraping em massa, respeitar captcha/rate limits, zero dado inventado — campo não verificado desqualifica) e saída em CSV local + leads.md + dashboard.
- `AGENTS-modelo.md` e README atualizados para apontar a variante.

## 0.17.0 — 2026-07-13

### Suporte ao OpenAI Codex

- Novo diretório `codex/` com instalador (`instalar-codex.sh` + `.command` para Mac): copia as 6 skills (formato SKILL.md é compatível) para `~/.agents/skills` e converte os 9 comandos em skills invocáveis (`$prospectar`, `$publicar`, `$prospector-setup` etc.), substituindo `$ARGUMENTS` por instrução em linguagem natural.
- `codex/AGENTS-modelo.md`: contexto para a pasta de trabalho no Codex, com as adaptações obrigatórias — sem Claude in Chrome (prospecção com participação manual ou Playwright), sem conector do Gmail (e-mails prontos em `emails-prontos/` ou MCP de e-mail), deploy/dashboard/contratos funcionam integralmente.
- README e manual com instruções e limitações.

## 0.16.0 — 2026-07-12

### E-mail: suporte a iCloud Mail (inclusive domínio próprio via iCloud+)

- Novo campo `envio.provedor` no config (`gmail` | `icloud`) + `envio.endereco`, coletados no `/setup`.
- Provedor `icloud`: rascunhos, envio e leitura de respostas pelo icloud.com/mail via Claude in Chrome — o usuário faz o próprio login, nenhuma senha ou código entra no chat/config (não há conector do iCloud e a rede do sandbox não alcança IMAP/SMTP).
- `/proposta`, `/followup`, `/respostas` e `/contrato` ficaram agnósticos de provedor; a checklist anti-spam ganhou tratamento por provedor (o embrulho de link em redirect é específico do Gmail) e a regra de remetente agora cobre domínio próprio com SPF/DKIM (recomendação de DMARC incluída).
- Conferência obrigatória do campo "De" nos rascunhos do iCloud (alias profissional, não o @icloud.com pessoal).

## 0.15.0 — 2026-07-12

### Hospedagem: HostGator → Cloudflare Pages

- Nova skill `deploy-cloudflare` substitui a `deploy-hostgator`: deploy via `wrangler pages deploy` direto do sandbox (HTTPS puro, funciona sem instalar nada na máquina do usuário), com fallback em script local (`publicar-agora`, requer Node.js) e último recurso pelo navegador.
- HTTPS automático (`*.pages.dev` e domínios conectados) — some a etapa de AutoSSL/cPanel.
- Removidos o publicador oculto agendado (`publicador-oculto.vbs`, `instalar-publicador.*`) e todo o fluxo de FTP — que trafegava a senha do cPanel sem criptografia e a expunha na linha de comando.
- Credencial agora é um token de API **escopado** (permissão Cloudflare Pages: Edit apenas), lido do `prospector-config.json` via variável de ambiente — nunca aparece em comando, log ou chat.
- Nova estrutura `publicar/` na pasta conectada como espelho do site público (deploy atômico da pasta inteira).

### Redesign

- Novas regras anti-AI-slop (`skills/redesign-premium/references/anti-slop.md`), destiladas dos projetos impeccable e taste-skill e adaptadas a landing page estática de arquivo único: proibições visuais (texto em gradiente, cards idênticos, kickers em toda seção, borda lateral colorida…), de texto (travessões, verbos de slop, números inventados) e de ritmo de layout, com checagem final integrada ao checklist da skill.
- Paleta: neutros tingidos do matiz da marca do cliente (fim do bege "quente por padrão"); tipografia variando entre clientes do mesmo lote.

### Dashboard

- Painel de Configurações agora tem a seção **Conexão Cloudflare** (Account ID, token, projeto, domínio); o token nunca sai do arquivo (API devolve só `tokenDefinido`).
- Correção de perda de dados no `dashboard-server.py`: o POST de leads usava `INSERT OR REPLACE`, que apagava os campos ausentes do payload — agora é upsert que atualiza apenas os campos enviados.
- Instruções de setup com paridade Windows/Mac (`iniciar-dashboard.command` + `chmod +x`).

### Proposta

- Nova seção "Respeito ao destinatário (LGPD e reputação)": lastro do dado público, opt-out definitivo ("não tenho interesse" → `descartado`, nunca mais contatado) e volume humano de envio.
- Checklist de domínio atualizada para `pages.dev`/domínio próprio.

### Documentação

- READMEs com os 9 comandos e instruções de instalação apontando para este repositório.
- Versões alinhadas entre `plugin.json` e `marketplace.json` (0.15.0); numeração do `/setup` corrigida (7B → 7/8).
- `manual.html` reescrito nas seções de requisitos, configuração, publicação e FAQ para o fluxo Cloudflare.
- Adicionados `CHANGELOG.md` e `.gitignore`.
