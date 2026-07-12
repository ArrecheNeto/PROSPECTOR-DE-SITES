@echo off
rem Prospector de Sites - publica a pasta publicar/ no Cloudflare Pages
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0publicar-agora.ps1"
