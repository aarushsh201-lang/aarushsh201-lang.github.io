-- Aarush portfolio anonymous analytics — run in Supabase SQL Editor.
-- Before running: replace YOUR_OWNER_USER_UUID_HERE with the UUID of your owner Auth user.
-- Find this UUID in Supabase Dashboard → Authentication → Users.
-- This schema never stores visitor email addresses or IP addresses.
-- It stores random browser-tab session IDs, page paths, referring hostnames and timestamps.

create table if not exists public.site_sessions (
  visitor_id text primary key,
  first_seen timestamptz not null default now()
);

create table if not exists public.site_pageviews (
  id bigint generated always as identity primary key,
  visitor_id text not null,
  page_path text not null,
  referrer_host text not null default '',
  created_at timestamptz not null default now()
);

alter table public.site_sessions enable row level security;
alter table public.site_pageviews enable row level security;

-- Start with least privilege; then grant only the browser operations we need.
revoke all on table public.site_sessions from anon, authenticated;
revoke all on table public.site_pageviews from anon, authenticated;
grant insert, select on table public.site_sessions to anon, authenticated;
grant insert, select on table public.site_pageviews to anon, authenticated;
grant usage, select on sequence public.site_pageviews_id_seq to anon, authenticated;

drop policy if exists "Public may add a browser session" on public.site_sessions;
create policy "Public may add a browser session"
on public.site_sessions
for insert
to anon, authenticated
with check (length(visitor_id) between 12 and 100);

drop policy if exists "Only owner may read browser sessions" on public.site_sessions;
create policy "Only owner may read browser sessions"
on public.site_sessions
for select
to authenticated
using (auth.uid() = 'YOUR_OWNER_USER_UUID_HERE'::uuid);

drop policy if exists "Public may add anonymous pageviews" on public.site_pageviews;
create policy "Public may add anonymous pageviews"
on public.site_pageviews
for insert
to anon, authenticated
with check (
  length(visitor_id) between 12 and 100
  and length(page_path) between 1 and 300
  and length(referrer_host) <= 180
);

drop policy if exists "Only owner may read anonymous pageviews" on public.site_pageviews;
create policy "Only owner may read anonymous pageviews"
on public.site_pageviews
for select
to authenticated
using (auth.uid() = 'YOUR_OWNER_USER_UUID_HERE'::uuid);
