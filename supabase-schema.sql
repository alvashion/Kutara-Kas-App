-- KasKita online database starter schema (Supabase / PostgreSQL).
-- This schema is a foundation only: the current HTML prototype does NOT yet connect to it.
-- Run only in a new Supabase project after reviewing the schema and access policies.

create extension if not exists pgcrypto;

create table if not exists public.business_profiles (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  business_name text not null default 'Usaha Saya',
  phone text,
  address text,
  logo_url text,
  created_at timestamptz not null default now()
);

create table if not exists public.customers (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  phone text,
  address text,
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  sku text,
  cost numeric(14,2) not null default 0,
  price numeric(14,2) not null default 0,
  stock numeric(14,2) not null default 0,
  min_stock numeric(14,2) not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.transactions (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  customer_id uuid references public.customers(id) on delete set null,
  transaction_no text,
  transaction_type text not null check (transaction_type in ('income','expense')),
  description text not null,
  amount numeric(14,2) not null default 0 check (amount >= 0),
  payment_status text not null default 'paid' check (payment_status in ('paid','unpaid','partial')),
  due_date date,
  paid_amount numeric(14,2) not null default 0 check (paid_amount >= 0),
  transaction_date timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists public.agenda (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  description text,
  due_at timestamptz,
  is_done boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.business_profiles enable row level security;
alter table public.customers enable row level security;
alter table public.products enable row level security;
alter table public.transactions enable row level security;
alter table public.agenda enable row level security;

create policy "owner manages business profile" on public.business_profiles
for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);
create policy "owner manages customers" on public.customers
for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);
create policy "owner manages products" on public.products
for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);
create policy "owner manages transactions" on public.transactions
for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);
create policy "owner manages agenda" on public.agenda
for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);
