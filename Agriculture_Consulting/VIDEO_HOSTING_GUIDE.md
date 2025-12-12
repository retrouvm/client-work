# Video Hosting Guide for Vercel

According to [Vercel's best practices](https://vercel.com/kb/guide/best-practices-for-hosting-videos-on-vercel-nextjs-mp4-gif), videos should not be served directly from the repository as they can cause excessive bandwidth consumption.

## Recommended Solutions

### Option 1: Vercel Blob (Recommended for Vercel)

Vercel Blob is a frontend-friendly solution for storing files in the cloud.

#### Setup Steps:

1. **Install Vercel Blob SDK:**
   ```bash
   npm install @vercel/blob
   ```

2. **Set up Vercel Blob in your project:**
   - Go to your Vercel project dashboard
   - Navigate to Storage → Create Database → Blob
   - This will give you access to Vercel Blob storage

3. **Upload videos using the API route:**
   - Use the provided `api/upload-video/route.js` endpoint
   - Or use the Vercel Blob dashboard to upload files directly

4. **Update video URLs in HTML:**
   - Replace local paths like `agri_media/ghana_forest.mp4`
   - With Vercel Blob URLs like `https://[your-blob-url].vercel-storage.com/ghana_forest.mp4`

### Option 2: Third-Party Video Hosting

For better performance and features, consider:

#### A. Vimeo
- Upload videos to Vimeo
- Use Vimeo's embed code or API
- Free tier available, paid plans for more features

#### B. Cloudinary
- Upload videos to Cloudinary
- Get optimized URLs with automatic compression
- Free tier: 25GB storage, 25GB bandwidth/month

#### C. AWS S3 + CloudFront
- Store videos in S3 bucket
- Use CloudFront CDN for fast delivery
- Pay-as-you-go pricing

#### D. Mux
- Professional video hosting platform
- Automatic encoding and optimization
- Free tier available

### Option 3: YouTube/Vimeo Embed (Current Implementation)

You're already using YouTube embeds for some videos, which is a good solution:
- No bandwidth costs
- Automatic optimization
- Built-in player controls
- Works well for longer-form content

## Current Video Files

The following videos are referenced in the site:
- `ghana_forest (2).mp4` - 747KB
- `ghana_forest (3).mp4` - 4.5MB
- `ghana_forest (4).mp4` - 2.6MB
- `ghana_forest (5).mp4` - 3.5MB
- `ghana_forest (6).mp4` - 3.9MB
- `ghana_forest (7).mp4` - 3.7MB
- `ghana_forest.mp4` - 4.0MB

## Quick Fix: Use Cloudinary (Easiest)

1. Sign up for free Cloudinary account: https://cloudinary.com
2. Upload your videos to Cloudinary
3. Get the public URLs
4. Replace video sources in HTML

Example:
```html
<!-- Before -->
<source src="agri_media/ghana_forest.mp4" type="video/mp4">

<!-- After -->
<source src="https://res.cloudinary.com/[your-cloud]/video/upload/ghana_forest.mp4" type="video/mp4">
```

## Why Videos Aren't Playing

Videos stored directly in the repository may not work on Vercel because:
1. Large files can exceed Vercel's file size limits
2. Bandwidth consumption can be excessive
3. Files may not be properly served through Git LFS
4. Vercel optimizes for static assets, not large media files

## Next Steps

1. Choose a hosting solution (Vercel Blob or Cloudinary recommended)
2. Upload your videos
3. Update the video source URLs in `index.html`
4. Test the videos on the deployed site

