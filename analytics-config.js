/* Public browser config for private owner analytics.
   This file is public. The publishable key and owner user UUID are not passwords.
   NEVER place a Supabase secret/service_role key here. */
window.AARUSH_ANALYTICS_CONFIG = {
  supabaseUrl: "",              // Example: https://your-project-ref.supabase.co
  supabasePublishableKey: "",   // Use the public Publishable key (legacy anon key also works with RLS)
  ownerUserId: ""               // Your Supabase Auth user's UUID; used to restrict the owner dashboard
};
