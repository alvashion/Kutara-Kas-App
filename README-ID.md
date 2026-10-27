# KasKita Profesional — Versi C (Starter Website + Android)

## Isi paket
- `www/index.html`: aplikasi HTML saat ini, disiapkan dengan manifest dan service worker.
- `www/manifest.webmanifest`: metadata untuk pemasangan sebagai PWA.
- `www/service-worker.js`: cache dasar agar kerangka aplikasi dapat dibuka ulang saat offline.
- `www/icon.svg`: ikon awal.
- `package.json`, `capacitor.config.json`: fondasi untuk membuat pembungkus aplikasi Android dengan Capacitor.
- `supabase-schema.sql`: skema awal database online dan kebijakan akses per pemilik.

## Status penting
Paket ini adalah **starter yang perlu dikonfigurasi**, bukan aplikasi online yang sudah terbit.
Versi HTML yang ada masih menyimpan data di `localStorage` pada perangkat/browser. Database Supabase belum dihubungkan ke antarmuka. Jadi data belum tersinkron otomatis antar perangkat. Jangan memasukkan data usaha sensitif sebelum integrasi dan pengujian keamanan selesai.

## Menjalankan lokal
Butuh Node.js terpasang:
1. Ekstrak ZIP.
2. Buka terminal di folder proyek.
3. Jalankan `npm install`.
4. Jalankan `npm start`.
5. Buka alamat lokal yang ditampilkan terminal.

## Membuat Android project
Butuh Node.js dan Android Studio:
1. Jalankan `npm install`.
2. Jalankan `npx cap add android` (hanya sekali).
3. Jalankan `npx cap sync android`.
4. Jalankan `npx cap open android`.
5. Di Android Studio, uji aplikasi di emulator/perangkat, lalu gunakan menu Build untuk menghasilkan APK.
6. Setiap perubahan isi `www`, jalankan `npx cap sync android` lagi.

Catatan: APK yang dihasilkan dari starter ini masih menggunakan penyimpanan lokal. Login dan sinkronisasi cloud baru berfungsi setelah integrasi backend dibuat dan diuji.

## Menerbitkan website/PWA
1. Unggah folder proyek ke repositori Git, atau gunakan hosting statis yang mendukung file `www`.
2. Untuk hosting statis, jadikan `www` sebagai folder publik/output.
3. Gunakan HTTPS agar PWA/service worker dapat berjalan.
4. Buka situs melalui Chrome Android, pilih menu browser lalu `Install app` / `Tambahkan ke layar utama` bila tersedia.

## Menyiapkan Supabase
1. Buat proyek baru di Supabase.
2. Tinjau lalu jalankan `supabase-schema.sql` melalui SQL Editor.
3. Aktifkan metode login yang diperlukan.
4. Hubungkan antarmuka aplikasi ke Supabase Auth dan tabel yang relevan.
5. Jangan pernah memasukkan `service_role` key ke frontend. Gunakan hanya anon/publishable key dengan Row Level Security aktif.
6. Uji bahwa akun berbeda tidak dapat membaca atau mengubah data satu sama lain.

## Fitur yang masih harus dikerjakan untuk versi online penuh
- Integrasi Supabase Auth, CRUD data online, dan migrasi data lokal.
- Sinkronisasi real-time/antar perangkat.
- Alur utang-piutang dan pembayaran sebagian yang lengkap.
- Upload logo nota dan penyimpanan file.
- Pengingat terjadwal (agenda saat ini tidak otomatis mengirim pesan).
- Pengujian backup, keamanan, dan Android build.
