-- ============================================================
-- LBH Dakwah & Pendidikan — Skema Database Supabase
-- Jalankan seluruh isi file ini sekali di: Supabase Dashboard
-- > SQL Editor > New Query > paste semua > Run
-- ============================================================

-- 1) TIKET KONSULTASI -----------------------------------------
create table tickets (
  id bigint generated always as identity primary key,
  ticket_number text unique not null,
  nama text not null,
  whatsapp text not null,
  topik text,
  kategori text,
  isi text,
  step int default 1,
  status text default 'Dalam Proses',
  advokat text,
  created_at timestamptz default now()
);

alter table tickets enable row level security;

create policy "Publik bisa membuat tiket baru"
on tickets for insert to anon with check (true);

create policy "Publik bisa mencari tiket by nomor"
on tickets for select to anon using (true);

create policy "Admin bisa membaca semua tiket"
on tickets for select to authenticated using (true);

create policy "Admin bisa update tiket"
on tickets for update to authenticated using (true) with check (true);


-- 2) ARTIKEL / GALERI KEGIATAN ----------------------------------
create table articles (
  id bigint generated always as identity primary key,
  title text not null,
  category text not null,          -- 'Advokasi & Litigasi' | 'Edukasi & Workshop' |
                                    -- 'Pendampingan Yayasan' | 'Kunjungan Pesantren'
  event_date date,
  excerpt text,
  location text,
  color text default 'linear-gradient(135deg,#1c2434,#05070a)',
  published boolean default true,
  created_at timestamptz default now()
);

alter table articles enable row level security;

create policy "Publik bisa membaca artikel terbit"
on articles for select to anon using (published = true);

create policy "Admin bisa kelola artikel"
on articles for all to authenticated using (true) with check (true);


-- 3) DEWAN PEMBINA & DIREKSI -------------------------------------
create table board_members (
  id bigint generated always as identity primary key,
  group_type text not null,        -- 'pembina' | 'direktur' | 'divisi'
  name text not null,
  role_title text,
  bio text,
  qualifications text,             -- pisahkan dengan koma, contoh: "S.H., Advokat Peradi, C.T.A."
  initial text,
  sort_order int default 0,
  created_at timestamptz default now()
);

alter table board_members enable row level security;

create policy "Publik bisa membaca pengurus"
on board_members for select to anon using (true);

create policy "Admin bisa kelola pengurus"
on board_members for all to authenticated using (true) with check (true);


-- ============================================================
-- SETELAH MENJALANKAN SKEMA INI:
-- 1. Buka Authentication > Users > Add user, buat akun admin
--    (email + password) secara manual. Jangan buat form sign-up
--    publik di halaman manapun.
-- 2. Buka Settings > API, salin "Project URL" dan "anon public key",
--    tempel ke index.html dan tim/kelola/index.html pada baris:
--      const SUPABASE_URL = '...'
--      const SUPABASE_ANON_KEY = '...'
-- 3. (Opsional) Isi ulang data artikel & pengurus lewat dashboard
--    admin di /tim/kelola, karena situs publik akan memakai data
--    dari database ini begitu tersambung — sebelum itu, konten
--    statis bawaan tetap tampil sebagai fallback.
-- ============================================================
