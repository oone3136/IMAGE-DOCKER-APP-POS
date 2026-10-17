@echo off
setlocal enabledelayedexpansion
title Buku Kas ^& POS - Client Runtime Launcher
color 0A

echo ======================================================================
echo          BUKU KAS ^& POS - CLIENT PRODUCTION CONTAINER SYSTEM
echo ======================================================================
echo.

REM 1. Periksa apakah Docker engine aktif
echo [1/4] Memeriksa Docker Desktop / Docker Engine...
call docker info >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo [ERROR] Docker tidak terdeteksi atau belum berjalan!
    echo         Silakan buka aplikasi Docker Desktop terlebih dahulu.
    echo.
    pause
    exit /b 1
)
echo [OK] Docker aktif dan siap.
echo.

REM 2. Muat Container Images dari file .tar.gz jika tersedia
cd /d "%~dp0"
if exist kas-pos-images.tar.gz (
    echo [2/4] Ditemukan arsip image "kas-pos-images.tar.gz".
    echo       Sedang memuat image ke Docker (docker load)...
    call docker load -i kas-pos-images.tar.gz
    if %errorlevel% neq 0 (
        color 0C
        echo [ERROR] Gagal memuat docker images dari kas-pos-images.tar.gz!
        pause
        exit /b 1
    )
    echo [OK] Image berhasil dimuat ke dalam Docker local cache.
) else (
    echo [2/4] File kas-pos-images.tar.gz belum ditemukan di folder ini.
    echo       Menggunakan image Docker lokal jika sudah pernah dimuat.
    echo       (Jika baru pertama kali, unduh kas-pos-images.tar.gz dari:)
    echo       https://github.com/oone3136/IMAGE-DOCKER-APP-POS/releases
)
echo.

REM 3. Jalankan Seluruh Container Microservices via Docker Compose
echo [3/4] Menjalankan seluruh container microservices (Background)...
call docker compose up -d --remove-orphans
if %errorlevel% neq 0 (
    color 0C
    echo [ERROR] Gagal menyalakan container! Periksa log di atas.
    pause
    exit /b 1
)
echo [OK] Seluruh container microservices berhasil dijalankan!
echo.

REM 4. Tampilkan informasi dashboard & URL akses
echo ======================================================================
echo                 APLIKASI BERHASIL DIJALANKAN!
echo ======================================================================
echo  Akses Aplikasi Kasir ^& Manajemen:
echo  -- Front-end POS UI:        http://localhost:3000  (atau http://localhost)
echo  -- Kong API Gateway:        http://localhost:8000
echo  -- Standalone POS Service:  http://localhost:8081/q/swagger-ui
echo  -- Common Kas ^& ERP:       http://localhost:8080/q/swagger-ui
echo  -- Master Data ^& Themes:   http://localhost:8084/q/swagger-ui
echo ======================================================================
echo.
echo [4/4] Membuka browser ke aplikasi POS...
start http://localhost:3000

echo.
echo Tips: Untuk menghentikan sistem, jalankan file stop.bat
echo Tekan tombol apa saja untuk menutup jendela ini...
pause >nul
