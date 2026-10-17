@echo off
title Restore Database Lokal (kas_postgres)
echo ======================================================================
echo             RESTORE DATABASE POSTGRESQL LOKAL
echo ======================================================================
cd /d "%~dp0"

echo Daftar file backup di folder backups:
dir /b backups\*.sql 2>nul
echo.

set /p SQLFILE="Ketik nama file backup (contoh: backup_kas_db_xxx.sql): "

if not exist "backups\%SQLFILE%" (
    echo [ERROR] File backups\%SQLFILE% tidak ditemukan!
    pause
    exit /b 1
)

echo Melakukan restore database ke container kas_postgres...
docker exec -i kas_postgres psql -U postgres kas_db < "backups\%SQLFILE%"

if %errorlevel% neq 0 (
    echo [ERROR] Gagal melakukan restore!
    pause
    exit /b 1
)

echo.
echo [SUKSES] Database berhasil dipulihkan dari backups\%SQLFILE%!
pause
