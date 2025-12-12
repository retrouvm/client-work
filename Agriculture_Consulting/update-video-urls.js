// Script to help update video URLs after uploading to Cloudinary or Vercel Blob
// Run this after uploading videos to get the new URLs

// Example: Update video URLs in index.html
// Replace the video source URLs with your hosted URLs

const videoMappings = {
  // Example Cloudinary URLs (replace with your actual URLs)
  'agri_media/ghana_forest (2).mp4': 'https://res.cloudinary.com/YOUR_CLOUD/video/upload/ghana_forest_2.mp4',
  'agri_media/ghana_forest (3).mp4': 'https://res.cloudinary.com/YOUR_CLOUD/video/upload/ghana_forest_3.mp4',
  'agri_media/ghana_forest (4).mp4': 'https://res.cloudinary.com/YOUR_CLOUD/video/upload/ghana_forest_4.mp4',
  'agri_media/ghana_forest (5).mp4': 'https://res.cloudinary.com/YOUR_CLOUD/video/upload/ghana_forest_5.mp4',
  'agri_media/ghana_forest (6).mp4': 'https://res.cloudinary.com/YOUR_CLOUD/video/upload/ghana_forest_6.mp4',
  'agri_media/ghana_forest (7).mp4': 'https://res.cloudinary.com/YOUR_CLOUD/video/upload/ghana_forest_7.mp4',
  'agri_media/ghana_forest.mp4': 'https://res.cloudinary.com/YOUR_CLOUD/video/upload/ghana_forest.mp4',
  
  // Or Vercel Blob URLs:
  // 'agri_media/ghana_forest.mp4': 'https://[your-blob-url].vercel-storage.com/ghana_forest.mp4',
};

// Instructions:
// 1. Upload your videos to Cloudinary or Vercel Blob
// 2. Update the URLs in the videoMappings object above
// 3. Manually replace the src attributes in index.html, or use a find/replace tool

console.log('Video URL mappings ready. Update index.html with these URLs:');
Object.entries(videoMappings).forEach(([old, newUrl]) => {
  console.log(`Replace: ${old}`);
  console.log(`With: ${newUrl}`);
  console.log('---');
});

