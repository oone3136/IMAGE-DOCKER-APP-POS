@echo off
title Hentikan Aplikasi Kasir & POS
cd /d "%~dp0"
echo Menghentikan seluruh container microservices...
docker compose down
echo.
echo Seluruh layanan sistem telah dihentikan.
pause
