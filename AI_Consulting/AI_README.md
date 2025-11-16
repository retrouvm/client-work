## AI Consulting Site – Developer & Editor Guide

### Overview
Static, mobile‑friendly site with four pages and one `style.css`. Includes a dark hero, use‑case cards, testimonials, and a contact form with a honeypot.

### Files
- `index.html`: Dark hero with CTAs, high‑impact use cases, testimonials, inline contact section with honeypot, and basic SEO meta tags.
- `about/about.html`: “Who We Are,” FAQ (regulated industries, engagement model), and Credentials.
- `services/services.html`: Service cards (Strategy & Roadmap, RAG Assistants, Forecasting/Automation) and CTA to contact.
- `contact/contact.html`: Contact form (name, email, message) with honeypot.
- `style.css`: Styles for hero variants, buttons, cards, testimonials, sections, and responsive grid.

### HTML structure and key classes
- Header/nav: links to Home, About, Services, Contact.
- Hero: `section.hero.hero--dark` with `.hero__content` and `.hero__actions` for CTAs.
- Buttons: `.btn`, `.btn--primary` (blue), `.btn--ghost` (outlined).
- Sections: `.section`, optional `.section--alt` for light background.
- Cards: `.cards` grid with `.card` items (use cases/services).
- Testimonials: `.testimonials` with `<blockquote class="testimonial">` and `<cite>`.

### Customization guide
- Text/content: Replace headlines, paragraphs, use cases, and testimonials. Keep heading order (H1 → H2/H3) for SEO/accessibility.
- SEO: Update `<title>` and `<meta name="description">` in `index.html`. Optionally add OG image.
- Images: Add `assets/` folder and reference images via `<img src="assets/..." alt="...">`. Compress images.
- Theme colors: Update `.hero--dark` gradient and button colors (`#2962ff`) in `style.css`.
- Layout: Adjust grid columns via the media query at `min-width: 700px`.

### Contact form wiring options
The form is static by default. Pick one:
- Formspree/Getform: set `action` to their endpoint and `method="POST"`.
- Netlify Forms: add `name="contact" netlify` to the `<form>` if hosted on Netlify.
- Serverless endpoint: create an API (Vercel/Netlify/AWS Lambda + SES) and set the form `action`.
- CRM embed: replace the markup with your CRM’s form embed.

Honeypot: Keep the off‑screen input block to discourage bot spam.

### Deployment tips
- Netlify or Vercel: simplest—drag the folder or connect the repo.
- GitHub Pages: enable Pages and serve the folder.
- AWS S3 + CloudFront or EC2 + Nginx for more control (see root README).

### Quick checklist before handoff
- Update titles/descriptions, contact details, and CTA links.
- Swap placeholder testimonials and refine use cases to match your offering.
- Add favicon and social share image.

