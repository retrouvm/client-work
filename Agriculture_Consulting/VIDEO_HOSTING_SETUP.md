# Video Hosting Setup for Vercel

According to [Vercel's best practices](https://vercel.com/kb/guide/best-practices-for-hosting-videos-on-vercel-nextjs-mp4-gif), videos should be hosted on Vercel Blob or third-party services to prevent excessive bandwidth consumption.

## Why Videos Aren't Playing

Videos stored directly in the repository may not work on Vercel because:
1. Large files can exceed Vercel's file size limits
2. Bandwidth consumption can be excessive
3. Files may not be properly served through Git LFS
4. Vercel optimizes for static assets, not large media files

## Recommended Solutions

### Option 1: Vercel Blob (Best for Vercel Projects)

1. **Go to your Vercel Dashboard:**
   - Navigate to your project
   - Go to **Storage** tab
   - Click **Create Database** → Select **Blob**

2. **Upload Videos:**
   - Use the Vercel Blob dashboard to upload your video files
   - Or use the Vercel CLI: `vercel blob put agri_media/ghana_forest.mp4`

3. **Get Public URLs:**
   - Each uploaded file gets a public URL
   - Format: `https://[your-blob-url].vercel-storage.com/filename.mp4`

4. **Update HTML:**
   - Replace `agri_media/ghana_forest.mp4` with the Blob URL

### Option 2: Cloudinary (Easiest for Static Sites)

1. **Sign up:** https://cloudinary.com (free tier: 25GB storage, 25GB bandwidth/month)

2. **Upload videos:**
   - Go to Media Library
   - Upload your video files
   - Get the public URLs

3. **Update video sources in HTML:**
   ```html
   <!-- Replace this -->
   <source src="agri_media/ghana_forest.mp4" type="video/mp4">
   
   <!-- With this -->
   <source src="https://res.cloudinary.com/[your-cloud]/video/upload/ghana_forest.mp4" type="video/mp4">
   ```

### Option 3: YouTube/Vimeo Embed (Already Working)

You're already using YouTube embeds successfully. For the Ghana forest videos, you could:
- Upload them to YouTube as unlisted videos
- Use YouTube embed code instead of direct video tags
- No bandwidth costs, automatic optimization

## Current Video Files Needing Hosting

- `ghana_forest (2).mp4` - 747KB
- `ghana_forest (3).mp4` - 4.5MB
- `ghana_forest (4).mp4` - 2.6MB
- `ghana_forest (5).mp4` - 3.5MB
- `ghana_forest (6).mp4` - 3.9MB
- `ghana_forest (7).mp4` - 3.7MB
- `ghana_forest.mp4` - 4.0MB

## Quick Setup: Cloudinary (Recommended)

1. Create free account at https://cloudinary.com
2. Upload all 7 videos to Cloudinary
3. Copy the public URLs
4. Update the video sources in `index.html`

The HTML is already set up with video tags - just need to replace the `src` URLs!

