# HEIC to JPG Conversion Guide

The HTML files have been updated to reference JPG versions of HEIC images. You need to convert the HEIC files to JPG format.

## Quick Conversion Methods

### Method 1: Python Script (Recommended)

1. Install required packages:
   ```powershell
   pip install pillow pillow-heif
   ```

2. Run the conversion script:
   ```powershell
   cd Agriculture_Consulting
   python convert_heic_to_jpg.py
   ```

This will convert all HEIC files in `agri_media/` to JPG format.

### Method 2: ImageMagick

1. Install ImageMagick:
   ```powershell
   choco install imagemagick
   ```
   Or download from: https://imagemagick.org/script/download.php#windows

2. Run the PowerShell script:
   ```powershell
   cd Agriculture_Consulting
   .\convert_images.ps1
   ```

### Method 3: Online Conversion

1. Use an online converter like:
   - https://cloudconvert.com/heic-to-jpg
   - https://convertio.co/heic-jpg/

2. Upload HEIC files and download JPG versions
3. Replace files in `agri_media/` folder

### Method 4: Windows Photos App

1. Open HEIC files in Windows Photos app
2. Right-click → Save as → Choose JPG format
3. Save to `agri_media/` folder with same filename

## Files That Need Conversion

The following HEIC files need to be converted to JPG:
- `tall_trees.HEIC` → `tall_trees.jpg`
- `tall_trees (2).HEIC` → `tall_trees (2).jpg`
- `garden_plants.HEIC` → `garden_plants.jpg`
- `carrots.HEIC` → `carrots.jpg`
- `corn.HEIC` → `corn.jpg`
- `farmers_market_stand.HEIC` → `farmers_market_stand.jpg`
- `farmers_market_stand (2).HEIC` → `farmers_market_stand (2).jpg`
- `brenyas_garden_sign.heic` → `brenyas_garden_sign.jpg`
- `brenya_with_banana_tree.heic` → `brenya_with_banana_tree.jpg`
- `plant.heic` → `plant.jpg`
- `plant (2).heic` → `plant (2).jpg`
- `plant (3).HEIC` → `plant (3).jpg`
- `plant (4).HEIC` → `plant (4).jpg`
- `plant (5).heic` → `plant (5).jpg`
- `plant (6).HEIC` → `plant (6).jpg`
- `plant (7).heic` → `plant (7).jpg`

## After Conversion

Once files are converted:
1. Verify JPG files exist in `agri_media/` folder
2. Test the website locally to ensure images load
3. Commit the JPG files to git:
   ```powershell
   git add Agriculture_Consulting/agri_media/*.jpg
   git commit -m "Add converted JPG images from HEIC files"
   git push origin master
   ```

## Current Status

- ✅ HTML files updated to reference JPG versions
- ✅ Google Drive embed added for Achimota Documentary
- ⏳ HEIC files need to be converted to JPG

