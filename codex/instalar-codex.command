#!/bin/bash
# Duplo clique no Mac — roda o instalador do Prospector para o Codex
cd "$(dirname "$0")"
bash ./instalar-codex.sh
read -p "Enter para fechar..."
