# LBH Dakwah & Pendidikan — Situs Resmi

Situs statis (HTML/CSS/JS, tanpa build step) + dashboard admin, terhubung ke
Supabase untuk sistem tiket konsultasi, artikel kegiatan, dan data pengurus.

## Struktur Folder

```
.
├── index.html              # Situs publik
├── tim/kelola/index.html   # Dashboard admin (login diperlukan)
├── supabase/schema.sql     # Skema database Supabase
└── README.md
```

> Dashboard admin sengaja ditaruh di path yang tidak mudah ditebak
> (`/tim/kelola`) dan tidak ditautkan dari navigasi publik.

## 1. Setup Supabase (database & autentikasi)

1. Daftar/masuk ke [supabase.com](https://supabase.com), buat project baru (gratis).
2. Buka **SQL Editor**, jalankan seluruh isi `supabase/schema.sql`.
3. Buka **Authentication > Users > Add user**, buat akun admin (email + password) untuk login ke dashboard. Jangan buat form pendaftaran publik.
4. Buka **Settings > API**, salin:
   - `Project URL`
   - `anon public key`
5. Tempel kedua nilai itu ke **dua file**:
   - `index.html` — cari `const SUPABASE_URL` dan `const SUPABASE_ANON_KEY`
   - `tim/kelola/index.html` — cari baris yang sama
6. Setelah terhubung, isi ulang data artikel kegiatan dan pengurus lewat dashboard admin (`/tim/kelola`) — sebelum diisi, situs tetap menampilkan konten statis bawaan sebagai fallback.

## 2. Push ke GitHub

```bash
cd lbhdp-site
git init
git add .
git commit -m "Initial commit: situs LBH Dakwah & Pendidikan"
git branch -M main
git remote add origin https://github.com/USERNAME/NAMA-REPO.git
git push -u origin main
```

Ganti `USERNAME/NAMA-REPO` dengan repo GitHub kamu (buat dulu repo kosong di github.com, tanpa README/gitignore bawaan).

## 3. Deploy

### Opsi A — Vercel
1. Buka [vercel.com](https://vercel.com) → **Add New Project** → import repo GitHub ini.
2. Framework preset: pilih **Other** (situs statis, tidak perlu build command).
3. Build Command: kosongkan. Output Directory: `.` (root).
4. Deploy.

### Opsi B — Netlify
1. Buka [app.netlify.com](https://app.netlify.com) → **Add new site > Import an existing project** → pilih repo GitHub ini.
2. Build command: kosongkan. Publish directory: `.` (root) — sudah diatur lewat `netlify.toml` di repo ini.
3. Deploy.

Setelah live, hubungkan domain sendiri (misal `lbhdp.desainindongmas.my.id` atau domain khusus) lewat menu **Domains** di Vercel/Netlify.

## 3. Setelah Deploy — Checklist

- [ ] SUPABASE_URL & ANON_KEY sudah diisi di kedua file HTML
- [ ] Akun admin sudah dibuat di Supabase Auth
- [ ] Login ke `/tim/kelola` berhasil
- [ ] Data artikel & pengurus sudah diisi ulang lewat dashboard admin
- [ ] Nomor WhatsApp hotline & email di situs sudah sesuai yang asli
- [ ] Domain custom sudah disambungkan (opsional)

## Catatan Keamanan

- Jangan bagikan `service_role key` Supabase ke mana pun — yang dipakai di situs ini hanya `anon public key`, yang memang aman ditaruh di sisi klien karena dibatasi oleh Row Level Security (RLS) yang sudah diatur di `schema.sql`.
- Dashboard admin hanya bisa diakses setelah login (Supabase Auth). Tidak ada form pendaftaran publik — akun admin baru dibuat manual lewat Supabase Dashboard.
