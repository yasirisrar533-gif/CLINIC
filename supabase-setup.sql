-- ============================================================
-- Supabase Setup for Dr. Yasir Israr Clinic Blog
-- Run this ONCE in Supabase Dashboard > SQL Editor > New Query
-- ============================================================

-- 1. Create posts table
CREATE TABLE IF NOT EXISTS posts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  subtitle TEXT DEFAULT '',
  slug TEXT UNIQUE NOT NULL,
  body TEXT NOT NULL DEFAULT '',
  excerpt TEXT DEFAULT '',
  category TEXT NOT NULL DEFAULT 'patient'
    CHECK (category IN ('patient', 'doctor')),
  status TEXT NOT NULL DEFAULT 'draft'
    CHECK (status IN ('draft', 'published')),
  featured_image TEXT DEFAULT '',
  seo_title TEXT DEFAULT '',
  seo_description TEXT DEFAULT '',
  published_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Enable Row Level Security
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- 3. Public can read published posts (no auth required)
CREATE POLICY "Anyone can read published posts"
  ON posts FOR SELECT
  USING (status = 'published');

-- 4. Authenticated admin can read ALL posts (including drafts)
CREATE POLICY "Admin can read all posts"
  ON posts FOR SELECT
  USING (auth.role() = 'authenticated');

-- 5. Authenticated admin can create posts
CREATE POLICY "Admin can insert posts"
  ON posts FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

-- 6. Authenticated admin can update posts
CREATE POLICY "Admin can update posts"
  ON posts FOR UPDATE
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

-- 7. Authenticated admin can delete posts
CREATE POLICY "Admin can delete posts"
  ON posts FOR DELETE
  USING (auth.role() = 'authenticated');

-- 8. Auto-update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER posts_updated_at
  BEFORE UPDATE ON posts
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();

-- 9. Create storage bucket for blog images (public read)
INSERT INTO storage.buckets (id, name, public)
VALUES ('blog-images', 'blog-images', true)
ON CONFLICT (id) DO NOTHING;

-- 10. Anyone can view uploaded blog images
CREATE POLICY "Public can view blog images"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'blog-images');

-- 11. Authenticated admin can upload images
CREATE POLICY "Admin can upload blog images"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'blog-images' AND auth.role() = 'authenticated');

-- 12. Authenticated admin can update images
CREATE POLICY "Admin can update blog images"
  ON storage.objects FOR UPDATE
  USING (bucket_id = 'blog-images' AND auth.role() = 'authenticated');

-- 13. Authenticated admin can delete images
CREATE POLICY "Admin can delete blog images"
  ON storage.objects FOR DELETE
  USING (bucket_id = 'blog-images' AND auth.role() = 'authenticated');

-- ============================================================
-- OPTIONAL: Seed with the two original articles
-- ============================================================
INSERT INTO posts (title, slug, body, excerpt, category, status, published_at) VALUES
(
  'What to expect at your first orthodontic consultation',
  'what-to-expect-first-consultation',
  '<p>Your first visit at the clinic is a comprehensive consultation, not just a quick look — and it''s completely free.</p><p>We start with a conversation about your concerns — what you''d like to change, how long you''ve been thinking about it, and any past dental treatment that matters to your case. There''s no rush.</p><p>Records include intraoral photographs, an intraoral scan (no more messy impression trays for most patients), and where clinically indicated an OPG and CBCT.</p><p>You''ll leave the first visit with a diagnosis, a clear treatment plan, an idea of duration, and a written estimate. If you''re happy to proceed, we can usually begin planning digitally the same week. If you''d rather take some time to think about it — that''s completely fine too.</p>',
  'Your first visit at the clinic is a comprehensive consultation, not just a quick look — and it''s completely free.',
  'patient',
  'published',
  '2025-06-15T00:00:00Z'
),
(
  'Case notes: MARPE in a 24-year-old male with narrow maxilla',
  'marpe-case-24-year-old-narrow-maxilla',
  '<p>Adult skeletal expansion remains one of the most rewarding — and most technique-sensitive — procedures we offer. A recent case is worth a short write-up.</p><p><strong>Presentation:</strong> 24-year-old male, ANB +2°, bilateral posterior crossbite, transverse maxillary deficiency of ~7mm at the first molars, moderate anterior crowding. Nasal breathing already compromised.</p><p>We designed a custom MARPE from CBCT with four palatal miniscrews (2×11mm anterior, 2×13mm posterior) and a jackscrew centred on the midpalatal suture. Activation protocol: 0.25mm × 2/day for the first week, tapered to 0.25mm/day for weeks 2–3.</p><p>Midpalatal suture opening was confirmed clinically at day 4 and radiographically at day 12. Total expansion at the jackscrew: 8.5mm. Post-expansion CBCT showed clean, parallel skeletal opening with minimal dental tipping.</p><h3>Clinical pearl</h3><p>Posterior miniscrew position matters more than anterior. Placing them too anteriorly is the single most common cause of asymmetric opening in the cases I have reviewed.</p>',
  'Adult skeletal expansion remains one of the most rewarding — and most technique-sensitive — procedures we offer.',
  'doctor',
  'published',
  '2025-07-02T00:00:00Z'
);
