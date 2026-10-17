#!/bin/bash
set -e

echo "======================================================================"
echo "         BUKU KAS & POS - CLIENT PRODUCTION CONTAINER SYSTEM"
echo "======================================================================"
echo ""

# 1. Periksa Docker
if ! command -v docker &> /dev/null; then
    echo "[ERROR] Docker belum terpasang di sistem ini!"
    exit 1
fi

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "$DIR"

# 2. Muat image jika file kas-pos-images.tar.gz ada
if [ -f "kas-pos-images.tar.gz" ]; then
    echo "[1/3] Memuat image Docker dari kas-pos-images.tar.gz..."
    docker load -i kas-pos-images.tar.gz
elif [ -f "kas-pos-images.tar" ]; then
    echo "[1/3] Memuat image Docker dari kas-pos-images.tar..."
    docker load -i kas-pos-images.tar
else
    echo "[1/3] Menggunakan image Docker yang telah terpasang di sistem..."
fi

# 3. Jalankan container
echo "[2/3] Menjalankan seluruh container microservices..."
docker compose up -d --remove-orphans

echo ""
echo "======================================================================"
echo "                APLIKASI BERHASIL DIJALANKAN!"
echo "======================================================================"
echo " Akses Aplikasi Kasir & Manajemen:"
echo " -- Front-end POS UI:        http://localhost:3000 (atau http://localhost)"
echo " -- Kong API Gateway:        http://localhost:8000"
echo " -- Standalone POS Service:  http://localhost:8081/q/swagger-ui"
echo " -- Common Kas & ERP:        http://localhost:8080/q/swagger-ui"
echo " -- Master Data & Themes:    http://localhost:8084/q/swagger-ui"
echo "======================================================================"
echo ""
echo "Tips: Untuk menghentikan sistem, jalankan: ./stop.sh"
