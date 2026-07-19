#!/bin/bash

if [ -z "$1" ]; then
    echo "Erro: Informe o diretorio do cliente. Ex: ./deploy_vercel.sh ./clientes_gerados/drfulano"
    exit 1
fi

CLIENT_DIR="$1"

if [ ! -d "$CLIENT_DIR" ]; then
    echo "Erro: Diretorio '$CLIENT_DIR' nao existe."
    exit 1
fi

echo "[Vercel Deploy] Iniciando deploy em producao para $CLIENT_DIR"
npx vercel --prod --yes --cwd "$CLIENT_DIR"
if [ $? -ne 0 ]; then
    echo "[Vercel Deploy] ERRO: O deploy falhou."
    exit 1
fi

echo "[Vercel Deploy] Deploy concluido com sucesso!"
