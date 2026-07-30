# Dr. Yasir Israr — Orthodontics Website

Single-file production website for Dr. Yasir Israr's specialist orthodontic practice in Peshawar. Theme: navy blue, black, and white.

## What you have

- **`index.html`** — the entire website in one file (~370 KB). All 7 clinical/portrait images are embedded as WebP (converted from the original JPEGs for a smaller, faster-loading file). No image folder needed. Drop this single file on any static host and it works.
- **`sitemap.xml`** — for Google Search Console
- **`robots.txt`** — search engine crawl instructions
- **`README.md`** — this file

That's it. No build step, no dependencies, no server.

## Deploy to Netlify (2 minutes)

**Simplest way:**
1. Go to https://app.netlify.com/drop
2. Sign in (free)
3. Drag `index.html` onto the drop zone
4. Rename the site under **Site settings → Change site name** to something like `yasir-israr-orthodontics`

**If you already have a Netlify site linked to GitHub:** edit `index.html` directly on GitHub (paste new content and commit), or unlink the repo and use drag-and-drop.

## Contact details already filled in

- **WhatsApp / Phone:** 0317 8457772
- **Email:** yasirisrar533@gmail.com
- **Address:** Clinic 245, 2nd Floor, Uhad Towers, University Road, Peshawar, KPK
- **Hours:** Monday–Saturday, 3:00 PM – 7:00 PM · Sunday closed

If any of this changes, open `index.html` in a text editor and use Find & Replace — the number, email, address, and hours each appear in 2–4 places (contact section, footer, booking form script, and the SEO schema block near the top).

## Change the admin password first!

1. Visit `yoursite.com/#admin`
2. Sign in with default password: **`yasir2026`**
3. Click **Change password** and set your own

## Site sections (in order)

- **Hero** — "Your perfect smile is a consultation away," with the Graphy-certification line and the biology/technology/art technique
- **Process** — 3 steps: Consult → Preview your smile → SmileWhite
- **Who we treat** — Adults (shape memory aligners) / Children 8–11 (interceptive & growth guidance) / Teens (braces & aligners) / Referrals
- **What we offer** — single-row navy section: clear aligners, precision braces, custom MARPE, jaw surgery orthodontics — each opens a detail popup
- **Shape memory aligners** — dedicated spotlight tab on the technology and stats
- **The practice** — about Dr. Yasir, credentials, technique
- **Signature quote** — conference photo with practice philosophy
- **FAQ** — 7 common patient questions, including the consultation pricing policy
- **Journal** — separate blog overlay with dropdown (Patients / Doctors & Colleagues)
- **Booking banner** — navy CTA with the consultation pricing note and a WhatsApp booking form (name, age, gender, problem) that opens WhatsApp pre-filled with a "Schedule your consultation" button
- **Contact** — address, hours, get-in-touch
- **Footer**

## Consultation pricing policy shown on the site

Consultations under 15 minutes are free. Longer or more detailed consultations are charged at the clinic's standard fee. This is stated in the booking banner and in the FAQ.

## Managing the journal (blog)

1. Go to `yoursite.com/#admin` and sign in
2. Write posts, attach images (up to 3 MB), pick "For patients" or "For doctors & colleagues"
3. Click Publish

**Important limitation:** journal posts are stored in your browser only. Visitors won't see them until you bake them into the file. To publish for real:
1. In the admin, click **Export JSON** — downloads all your posts
2. Open `index.html`, search for `SEED_POSTS`, and replace the array content with your JSON
3. Re-upload to Netlify

Or upgrade to Decap CMS later (30-min setup, free) for real live publishing.

## Getting found on Google

The site has SEO built in (meta tags, schema markup, sitemap). To actually rank:

1. **Google Business Profile** — google.com/business — sign up, verify by postcard (2 weeks). Biggest single thing you can do for local search.
2. **Google Search Console** — search.google.com/search-console — add your domain, submit `sitemap.xml`
3. **Custom domain** — get a `.com` or `.pk` domain (~$12/year), add it in Netlify, and update the URLs inside `sitemap.xml` and `robots.txt` to match
4. **Ask patients for Google reviews** — reviews drive local rankings more than anything else
5. **Publish blog posts** — every patient-facing article is a page that can rank

Note: `sitemap.xml` and `robots.txt` currently point at `https://dryasirisrar.com/` as a placeholder domain. Update both files with your real domain once you have one.

## Swapping images

The 7 images are embedded in the file as WebP. To swap one, ask Claude in a new session — provide the new image and Claude can convert and embed it directly.

## Making future changes

Any change (new copy, new services, colors, sections, pricing) — drop back into a Claude session with the current `index.html` attached and describe what you want. Claude can edit the file directly.
