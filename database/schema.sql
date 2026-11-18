-- ResumeCraft: run this entire script in Supabase SQL Editor.
create extension if not exists pgcrypto;
create table if not exists public.resumes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title varchar(150) not null,
  full_name varchar(80) not null,
  email varchar(254) not null,
  phone varchar(40), date_of_birth date, location varchar(160), headline varchar(160), linkedin text, portfolio text, profile_photo text, summary text, projects text, certifications text,
  education jsonb not null default '[]'::jsonb,
  experience jsonb not null default '[]'::jsonb,
  skills jsonb not null default '[]'::jsonb,
  additional text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists resumes_user_updated_idx on public.resumes(user_id, updated_at desc);
alter table public.resumes enable row level security;
drop policy if exists "Users can view own resumes" on public.resumes;
drop policy if exists "Users can insert own resumes" on public.resumes;
drop policy if exists "Users can update own resumes" on public.resumes;
drop policy if exists "Users can delete own resumes" on public.resumes;
create policy "Users can view own resumes" on public.resumes for select to authenticated using (auth.uid() = user_id);
create policy "Users can insert own resumes" on public.resumes for insert to authenticated with check (auth.uid() = user_id);
create policy "Users can update own resumes" on public.resumes for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users can delete own resumes" on public.resumes for delete to authenticated using (auth.uid() = user_id);
create or replace function public.set_updated_at() returns trigger language plpgsql as $$ begin new.updated_at = now(); return new; end; $$;
drop trigger if exists set_resumes_updated_at on public.resumes;
create trigger set_resumes_updated_at before update on public.resumes for each row execute procedure public.set_updated_at();
-- No sample user/resume is inserted: every resume must belong to an authenticated account.

-- Safe upgrade for an existing ResumeCraft database (re-running is safe).
alter table public.resumes add column if not exists date_of_birth date;
alter table public.resumes add column if not exists linkedin text;
alter table public.resumes add column if not exists portfolio text;
alter table public.resumes add column if not exists profile_photo text;
alter table public.resumes add column if not exists projects text;
alter table public.resumes add column if not exists certifications text;
