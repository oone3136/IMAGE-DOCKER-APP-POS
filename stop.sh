#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "$DIR"
echo "Menghentikan seluruh container microservices..."
docker compose down
echo "Seluruh layanan sistem telah dihentikan."
