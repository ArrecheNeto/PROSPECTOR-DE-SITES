@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Erro: Informe o diretorio do cliente. Ex: deploy_vercel.bat ./clientes_gerados/drfulano
    exit /b 1
)

set CLIENT_DIR=%~1

if not exist "!CLIENT_DIR!" (
    echo Erro: Diretorio "!CLIENT_DIR!" nao existe.
    exit /b 1
)

echo [Vercel Deploy] Iniciando deploy em producao para !CLIENT_DIR!
npx vercel --prod --yes --cwd "!CLIENT_DIR!"
if %errorlevel% neq 0 (
    echo [Vercel Deploy] ERRO: O deploy falhou com codigo %errorlevel%
    exit /b %errorlevel%
)

echo [Vercel Deploy] Deploy concluido com sucesso!
