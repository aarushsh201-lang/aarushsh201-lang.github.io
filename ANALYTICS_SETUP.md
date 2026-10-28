# Private analytics setup for Aarush's portfolio

The owner-only visitor counter is added to the website code, but it is intentionally inactive until you configure a backend. GitHub Pages serves static files and cannot securely store private visit totals by itself.

## What it records
- Total page views (page loads, including reloads)
- Approximate browser-tab sessions, using a random ID kept in sessionStorage for that tab
- Recent page paths, referring hostnames, and timestamps
- It does NOT collect visitor email addresses, names, IP addresses, browser fingerprints, or full URLs/query strings.
- It does NOT identify a real person behind a visit. Counts can include bots and repeat visits.

## 1. Create a Supabase project
1. Open https://supabase.com/dashboard and create a project you control.
2. Under Authentication → Users, create one owner account using your email and a strong password. Verify it if prompted.
3. Copy the user's UUID from Authentication → Users.
4. Open the SQL Editor. Open analytics-setup.sql in this repository, replace every YOUR_OWNER_USER_UUID_HERE with that UUID, then run the SQL.
5. In Project Settings → API Keys, copy the Project URL and the Publishable key. Older projects may label the public key as anon.

## 2. Configure the website
1. Open analytics-config.js in this GitHub repository and click the pencil (Edit) icon.
2. Paste the Project URL into supabaseUrl, the Publishable key into supabasePublishableKey, and the owner user's UUID into ownerUserId.
3. Save/commit the change. The GitHub Pages workflow redeploys automatically.
4. Never paste a Supabase secret or service_role key into this public repository. These keys bypass Row Level Security.

## 3. Open private stats
1. Open https://aarushsh201-lang.github.io/
2. The Owner stats button appears at the top right once the config is active.
3. Click it and sign in using the owner account created in Supabase.
4. Only the configured owner UUID can read the counts and recent visit summaries. Signed-out visitors cannot read stored visit rows.

If the dashboard does not work, check the URL, publishable key, owner UUID, and that you ran the SQL setup.

## Privacy and limits
This is basic, privacy-conscious aggregate analytics, not verified identity tracking. Visitor emails are not captured. Do not secretly record emails typed into arbitrary fields. If you ever want visitors to leave contact details, use a clearly labelled, optional form with an explicit submit action and a privacy notice.

The counter is for a hobby portfolio, not bot-proof analytics. Public insert access may be abused by automated requests, so treat counts as approximate. For richer, robust aggregate reporting, consider Google Analytics or Cloudflare Web Analytics, whose dashboards are viewed separately after logging in.
