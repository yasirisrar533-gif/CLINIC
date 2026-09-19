# Dr. Yasir Israr — Orthodontics Website

Single-file production website for Dr. Yasir Israr's specialist orthodontic practice in Peshawar, with a live Supabase-powered blog CMS. Theme: navy blue, black, and white.

## What you have

- **`index.html`** — the entire website in one file. All 7 clinical/portrait images are embedded as WebP. No build step, no dependencies.
- **`supabase-setup.sql`** — run once in your Supabase dashboard to create the posts table, RLS policies, and image storage bucket
- **`_redirects`** — Netlify SPA fallback for clean article URLs (`/article/slug`)
- **`sitemap.xml`** — for Google Search Console
- **`robots.txt`** — search engine crawl instructions
- **`CNAME`** — custom domain pointer (`dryasirisrar.com`)

## Architecture

The website is a single static HTML file that connects to **Supabase** for:

- **Authentication** — email/password login for the admin panel
- **PostgreSQL database** — stores all blog posts with title, body (rich text), slug, category, status, featured image URL, SEO fields, and timestamps
- **Storage** — `blog-images` bucket for uploaded images (auto-compressed to WebP on the client)
- **Row Level Security (RLS)** — public visitors can only read published posts; only authenticated users can create/edit/delete

Only the Supabase **anon key** is in the frontend (safe by design — RLS enforces all access control). No service-role keys are exposed.

## Setup (one-time)

### 1. Create a Supabase project

1. Go to [supabase.com](https://supabase.com) and create a free project
2. Note your **Project URL** and **Anon Key** from Settings → API

### 2. Run the database setup

1. In your Supabase dashboard, go to **SQL Editor → New Query**
2. Paste the contents of `supabase-setup.sql` and click **Run**
3. This creates the `posts` table, RLS policies, storage bucket, and optionally seeds two sample articles

### 3. Create an admin user

1. In Supabase dashboard, go to **Authentication → Users → Add user**
2. Create a user with your email and a strong password
3. This is the account you'll use to log in at `/#admin`

### 4. Configure the website

Open `index.html` and find these two lines near the top of the main `<script>` block:

```javascript
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

Replace them with your actual Supabase project URL and anon key.

### 5. Deploy to Netlify

1. Push the repo to GitHub (or drag-and-drop to [app.netlify.com/drop](https://app.netlify.com/drop))
2. The `_redirects` file ensures `/article/slug` URLs work correctly
3. Set your custom domain if desired

## How to publish a new article

1. Visit `yoursite.com/#admin`
2. Sign in with your Supabase admin email and password
3. Fill in: title, subtitle, category, content (rich text editor with headings, bold, italic, lists, links, inline images)
4. Optionally upload a featured image (auto-compressed to WebP)
5. Optionally configure SEO title and description
6. Click **Publish** — the article is immediately live on the public site
7. No code changes, no redeployment needed

## Contact details

- **WhatsApp / Phone:** 0317 8457772
- **Email:** yasirisrar533@gmail.com
- **Address:** Clinic 245, 2nd Floor, Uhad Towers, University Road, Peshawar, KPK
- **Hours:** Monday–Saturday, 3:00 PM – 7:00 PM · Sunday closed

If any of this changes, open `index.html` and use Find & Replace — the number, email, address, and hours each appear in 2–4 places.

## Site sections

- **Hero** — tagline with technique philosophy
- **Process** — 3 steps: Consult → Preview → SmileWhite
- **Who we treat** — Adults / Children / Teens / Referrals
- **What we offer** — clear aligners, precision braces, custom MARPE, jaw surgery orthodontics
- **Shape memory aligners** — technology spotlight
- **The practice** — about Dr. Yasir, credentials
- **FAQ** — 7 common patient questions
- **Journal** — Supabase-powered blog with featured article, cards, category filtering, search, and individual article pages
- **Booking** — WhatsApp scheduling form
- **Contact + Footer**

## SEO

Each published article gets:
- Clean URL: `/article/article-slug`
- Dynamic `<title>` and `<meta description>`
- Open Graph tags (title, description, image, type, URL)
- Article structured data (Schema.org JSON-LD)
- Publication date metadata

**Limitation:** Social media crawlers (Facebook, Twitter, LinkedIn) do not execute JavaScript, so Open Graph tags are set dynamically and may not be picked up by link previews. For full social sharing support, you would need server-side rendering or Supabase Edge Functions to inject meta tags before the page loads.

## Swapping images

The 7 clinical/portrait images are embedded in the file as WebP. To swap one, ask Claude in a new session — provide the new image and Claude can convert and embed it directly.
