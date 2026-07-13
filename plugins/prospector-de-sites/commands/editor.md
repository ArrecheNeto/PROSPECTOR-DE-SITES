---
description: Gera o editor visual de uma página redesenhada (editar textos e imagens no navegador e exportar)
argument-hint: "[nome do cliente]"
---

Gere a versão editável de uma página redesenhada.

## Passos

1. Identifique o cliente por `$ARGUMENTS` ou, se vazio, liste as pastas em `sites/` e pergunte qual página editar.
2. Leia `sites/[slug]/[slug].html`.
3. Crie (ou regenere) `sites/[slug]/[slug]-editor.html`: uma cópia da página com a camada de edição injetada antes de `</body>`. O script completo da camada de edição está em `references/editor-visual.md` da skill `redesign-premium` — use-o exatamente como está.
4. Apresente o arquivo `[slug]-editor.html` ao usuário e explique em 3 linhas como usar:
   - Abra o arquivo no navegador; clique em qualquer texto para editar direto na página.
   - Clique em qualquer imagem para trocá-la por um arquivo do computador (fica embutida na página).
   - Botão "Exportar página" baixa o HTML final limpo (sem o editor) — substitua a página original por ele.
5. Se o usuário disser que terminou a edição e enviar/salvar o arquivo exportado, substitua `sites/[slug]/[slug].html` pelo conteúdo exportado antes de publicar.
