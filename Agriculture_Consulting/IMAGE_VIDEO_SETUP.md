# Image and Video Setup Guide

## Image Conversion (HEIC to JPG)

HEIC files are not supported in web browsers. To convert HEIC images to JPG:

### Option 1: Using ImageMagick (Recommended)

1. Install ImageMagick:
   ```powershell
   choco install imagemagick
   ```
   Or download from: https://imagemagick.org/script/download.php#windows

2. Run the conversion script:
   ```powershell
   cd Agriculture_Consulting
   .\convert_images.ps1
   ```

### Option 2: Using heif-convert (libheif)

1. Install libheif:
   - Download from: https://github.com/strukturag/libheif
   - Or use: `choco install libheif`

2. Run the conversion script:
   ```powershell
   cd Agriculture_Consulting
   .\convert_images.ps1
   ```

### Manual Conversion

If you prefer to convert manually, you can use online tools or image editing software:
- Online: https://cloudconvert.com/heic-to-jpg
- Windows: Use Photos app (may require additional codec)

## Video Compression

Large video files may exceed Git's file size limits. To compress videos:

### Using FFmpeg

1. Install FFmpeg:
   ```powershell
   choco install ffmpeg
   ```
   Or download from: https://ffmpeg.org/download.html

2. Run the compression script:
   ```powershell
   cd Agriculture_Consulting
   .\compress_videos.ps1
   ```

The script will:
- Compress videos larger than 100MB
- Create `*_compressed.mp4` versions
- Preserve original files
- Optimize for web playback

### Video Files Status

Current video files in `agri_media/`:
- `Achimota Documentary.mp4` (1.1GB) - **Needs compression**
- `brenya_shows_ghana_forest.mp4` (32MB) - May need compression
- `brenya_shwoing_bamboo.MOV` (22MB) - May need compression
- Other smaller videos (< 10MB) - Should be fine

### Git Large File Storage (Git LFS)

If videos are still too large after compression, consider using Git LFS:

1. Install Git LFS:
   ```powershell
   choco install git-lfs
   ```

2. Initialize Git LFS in repository:
   ```powershell
   git lfs install
   git lfs track "*.mp4"
   git lfs track "*.MOV"
   ```

3. Add and commit:
   ```powershell
   git add .gitattributes
   git add Agriculture_Consulting/agri_media/*.mp4
   git commit -m "Add videos with Git LFS"
   ```

## Current Status

- ✅ HTML files updated to use JPG images (browser-compatible)
- ✅ HEIC conversion script created
- ✅ Video compression script created
- ⏳ HEIC files need conversion (run `convert_images.ps1`)
- ⏳ Large videos need compression (run `compress_videos.ps1`)

## Notes

- Original HEIC and video files are preserved
- Converted/compressed files are created alongside originals
- Update HTML references if using compressed video versions
- JPG images are already committed and working on Vercel

