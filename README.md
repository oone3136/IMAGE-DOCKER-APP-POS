# Panduan Menjalankan Sistem Buku Kas & POS (Docker Standalone)

Paket ini dirancang agar pengguna / klien dapat langsung menjalankan seluruh ekosistem **Buku Kas & Point of Sales (POS)** menggunakan Docker tanpa memerlukan instalasi JDK, Maven, Node.js, ataupun kode sumber (source code).

---

## 1. Persyaratan Sistem & Unduhan Berkas
1. Pastikan di komputer / server Anda telah terpasang:
   - **Docker Desktop** (untuk Windows / macOS) atau **Docker Engine + Docker Compose** (untuk Linux).
   - Minimal RAM: 4 GB (Disarankan 8 GB).
2. Unduh berkas image container:
   - Unduh **`kas-pos-images.tar.gz`** dari tab [**GitHub Releases v1.0.0**](https://github.com/oone3136/IMAGE-DOCKER-APP-POS/releases).
   - Letakkan berkas `kas-pos-images.tar.gz` di dalam folder ini (sejajar dengan file `start.bat`).

---

## 2. Cara Menjalankan Sistem

### A. Pengguna Windows (1-Klik)
1. Cukup klik ganda (double-click) file:
   ```cmd
   start.bat
   ```
2. Skrip akan secara otomatis:
   - Memeriksa apakah Docker Desktop aktif.
   - Mengimpor file image `kas-pos-images.tar.gz` (jika ada).
   - Menjalankan seluruh container microservices di latar belakang.
   - Membuka halaman aplikasi kasir di browser secara otomatis.

### B. Pengguna Linux / macOS
1. Buka terminal di folder ini, berikan izin eksekusi:
   ```bash
   chmod +x start.sh stop.sh
   ```
2. Jalankan sistem:
   ```bash
   ./start.sh
   ```

---

## 3. URL Akses Layanan

| Layanan | URL Akses | Keterangan |
| :--- | :--- | :--- |
| **Aplikasi Web Kasir & Manajemen (UI)** | `http://localhost:3000` atau `http://localhost` | Aplikasi Kasir, Buku Kas, Toko Online |
| **Kong API Gateway** | `http://localhost:8000` | Gateway routing seluruh microservice |
| **POS Service (Swagger API)** | `http://localhost:8081/q/swagger-ui` | API Dokumentasi Retail & Produk |
| **Common Service (Swagger API)** | `http://localhost:8080/q/swagger-ui` | API Keuangan, ERP & Akuntansi |
| **Master Data Service (Swagger API)** | `http://localhost:8084/q/swagger-ui` | API Multi-company & Theming |
| **DCMS & Notification Service** | `http://localhost:8082/q/swagger-ui` | API Dokumen & Notifikasi |
| **Logging & Audit Service** | `http://localhost:8083/q/swagger-ui` | API Log & Audit Trail |

---

## 4. Cara Menghentikan Sistem
- **Windows**: Klik ganda `stop.bat`
- **Linux / macOS**: Jalankan `./stop.sh` atau `docker compose down`

---

## 5. Backup & Restore Database
- **Backup**: Klik ganda `backup-db.bat` (berkas tersimpan otomatis di folder `backups/`).
- **Restore**: Klik ganda `restore-db.bat` lalu pilih berkas `.sql` yang ingin dipulihkan.
