# Vercel Deployment Guide

This repository contains two separate websites that should be deployed as **two separate Vercel projects**.

## Quick Setup Steps

### 1. Connect Repository to Vercel

1. Go to [vercel.com](https://vercel.com) and sign in with your GitHub account
2. Click **"Add New Project"**
3. Import your repository: `retrouvm/client-work` (or your repo name)

### 2. Deploy AI Consulting Site

1. **First Project Setup:**
   - Project Name: `ai-consulting` (or your preferred name)
   - **Root Directory:** Set to `AI_Consulting`
   - Framework Preset: **Other** (or leave as default)
   - Build Command: Leave empty (static site)
   - Output Directory: Leave empty (or set to `.`)
   - Click **Deploy**

2. After deployment, you'll get a URL like: `https://ai-consulting-xxx.vercel.app`

### 3. Deploy Agriculture Consulting Site

1. **Second Project Setup:**
   - Go back to your Vercel dashboard
   - Click **"Add New Project"** again
   - Import the **same repository** (`retrouvm/client-work`)
   - Project Name: `agriculture-consulting` (or your preferred name)
   - **Root Directory:** Set to `Agriculture_Consulting`
   - Framework Preset: **Other**
   - Build Command: Leave empty
   - Output Directory: Leave empty (or set to `.`)
   - Click **Deploy**

2. After deployment, you'll get a URL like: `https://agriculture-consulting-xxx.vercel.app`

## Custom Domains

### Adding Custom Domains

1. In each Vercel project, go to **Settings → Domains**
2. Add your custom domain (e.g., `aiconsulting.com` and `agricultureconsulting.com`)
3. Follow Vercel's DNS instructions to point your domain
4. SSL certificates are automatically provisioned by Vercel

### Domain Configuration

- **AI Consulting:** Add domain in the `ai-consulting` project
- **Agriculture Consulting:** Add domain in the `agriculture-consulting` project

## Automatic Deployments

Once connected:
- **Production:** Every push to `master`/`main` branch automatically deploys
- **Preview:** Every pull request gets its own preview URL
- **Branch:** Every branch push creates a preview deployment

## Configuration Files

Each site has a `vercel.json` file that:
- Ensures proper routing for all pages
- Adds security headers (XSS protection, frame options, etc.)
- Configures the site as a static site (no build needed)

## Troubleshooting

### If pages show 404 errors:
- Make sure the **Root Directory** is set correctly in Vercel project settings
- Verify that `index.html` exists in the root directory of each site

### If styles don't load:
- Check that `style.css` is in the same directory as `index.html`
- Verify relative paths in HTML files are correct

### If forms don't work:
- The contact forms need a backend service (Formspree, Netlify Forms, or a serverless function)
- See the main README.md for form integration options

## Next Steps

1. ✅ Deploy both projects to Vercel
2. ✅ Test all pages on both sites
3. ✅ Add custom domains (optional)
4. ✅ Set up form handling (Formspree, etc.)
5. ✅ Add analytics (Google Analytics, Plausible, etc.)

## Support

- Vercel Docs: https://vercel.com/docs
- Vercel Dashboard: https://vercel.com/dashboard

