## Agriculture Consulting Site – Developer & Editor Guide

### Overview
Static, mobile‑friendly site with four pages and a single `style.css`. Sections include a hero, services cards, testimonials, FAQ, and a contact form with a honeypot.

### Files
- `index.html`: Home with hero, CTAs, services preview, testimonials, and basic SEO meta tags.
- `about/about.html`: Bio (“Who Am I”), FAQ (accordion via `<details>`), and Credentials list.
- `services/services.html`: Three service cards with bullet features and a CTA to contact.
- `contact/contact.html`: Contact form (name, email, phone, message) plus hidden honeypot input.
- `style.css`: Global styles for layout, hero, buttons, cards, testimonials, sections, and responsive grid.

### HTML structure and key classes
- Header/nav: consistent across pages; update links if directory structure changes.
- Hero: `section.hero` with `.hero__content` and `.hero__actions` for CTA buttons.
- Buttons: `.btn`, `.btn--primary`, `.btn--ghost`.
- Sections: `.section` and optional `.section--alt` for light background.
- Cards: `.cards` (grid container) with `.card` and optional `.card__link`.
- Testimonials: `.testimonials` grid of `<blockquote class="testimonial">` and `<cite>`.

### Customization guide
- Text/content: Edit headings and paragraphs directly in each HTML. Keep semantic heading order (H1 → H2/H3) for accessibility/SEO.
- SEO: Update `<title>` and `<meta name="description">` in `index.html`; you can copy similar meta tags to inner pages if desired.
- Images: Add an `assets/` folder and use `<img src="assets/…" alt="…">`. Optimize image size for performance.
- Colors/brand: Adjust header/footer colors and button colors in `style.css` (`#388e3c` is the primary green).
- Layout: Modify grid columns via the media query at the bottom of `style.css`.
- Footer: Present on all pages; update copyright text.

### Styling notes (style.css)
- Body/layout: center column with `max-width: 800px` in `main` and subtle shadow.
- Footer: fixed at bottom; if your pages become longer, you can remove `position: fixed;` to avoid overlap on mobile.
- Responsive: cards switch from 1‑column to 3‑column at `min-width: 700px`.

### Contact form wiring options
Current form posts to `#` (no backend). Choose one:
- Formspree/Getform: change `<form action="https://formspree.io/f/yourid" method="POST">`.
- Netlify Forms (if hosted on Netlify): add `name="contact" netlify` to the `<form>` tag.
- Serverless email: build an endpoint (AWS Lambda/SES, Vercel, or Netlify Function) and set `action` to that URL.
- CRM embed: replace the form with HubSpot/Zoho embed code.

Honeypot: Keep the hidden input block—bots that fill it will be filtered client‑side.

### Deployment tips
- Easiest: Netlify/Vercel drag‑and‑drop the folder.
- GitHub Pages: push to a repo and enable Pages.
- S3 + CloudFront or EC2 + Nginx for AWS hosting (see root README for steps).

### Quick checklist before handoff
- Update titles/descriptions and contact info.
- Replace placeholder testimonials and service copy.
- Add a favicon and an Open Graph image for better social sharing.

