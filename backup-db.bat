@echo off
title Backup Database Lokal (kas_postgres)
echo ======================================================================
echo             BACKUP DATABASE POSTGRESQL LOKAL
echo ======================================================================
cd /d "%~dp0"

set CUR_DATE=%date:~10,4%%date:~4,2%%date:~7,2%
set CUR_TIME=%time:~0,2%%time:~3,2%%time:~6,2%
set CUR_TIME=%CUR_TIME: =0%
set BACKUP_FILE=backup_kas_db_%CUR_DATE%_%CUR_TIME%.sql

if not exist "backups" mkdir "backups"

echo Mengambil dump database dari container kas_postgres...
docker exec -t kas_postgres pg_dump -U postgres --clean --if-exists kas_db > "backups\%BACKUP_FILE%"

if %errorlevel% neq 0 (
    echo [ERROR] Gagal melakukan backup! Pastikan container kas_postgres sedang berjalan.
    pause
    exit /b 1
)

echo.
echo [SUKSES] Backup database berhasil disimpan di: backups\%BACKUP_FILE%
pause
