#!/usr/bin/env python3
"""
Convert HEIC files to JPG format
Requires: pip install pillow pillow-heif
"""

import os
from pathlib import Path

try:
    from PIL import Image
    from pillow_heif import register_heif_opener
    register_heif_opener()
    PIL_AVAILABLE = True
except ImportError:
    PIL_AVAILABLE = False
    print("ERROR: pillow and pillow-heif not installed!")
    print("Install with: pip install pillow pillow-heif")
    exit(1)

def convert_heic_to_jpg(heic_path, jpg_path=None, quality=85):
    """Convert HEIC file to JPG"""
    try:
        img = Image.open(heic_path)
        
        # Convert RGBA to RGB if necessary
        if img.mode == 'RGBA':
            rgb_img = Image.new('RGB', img.size, (255, 255, 255))
            rgb_img.paste(img, mask=img.split()[3])
            img = rgb_img
        elif img.mode != 'RGB':
            img = img.convert('RGB')
        
        if jpg_path is None:
            jpg_path = heic_path.with_suffix('.jpg')
        
        img.save(jpg_path, 'JPEG', quality=quality, optimize=True)
        return True
    except Exception as e:
        print(f"Error converting {heic_path}: {e}")
        return False

def main():
    agri_media_path = Path("agri_media")
    
    if not agri_media_path.exists():
        print(f"Error: {agri_media_path} directory not found!")
        exit(1)
    
    # Find all HEIC files
    heic_files = list(agri_media_path.glob("*.HEIC")) + list(agri_media_path.glob("*.heic"))
    
    if not heic_files:
        print("No HEIC files found!")
        return
    
    print(f"Found {len(heic_files)} HEIC files to convert\n")
    
    converted = 0
    skipped = 0
    failed = 0
    
    for heic_file in heic_files:
        jpg_file = heic_file.with_suffix('.jpg')
        
        # Skip if JPG already exists
        if jpg_file.exists():
            print(f"⏭️  Skipping {heic_file.name} - JPG already exists")
            skipped += 1
            continue
        
        print(f"🔄 Converting {heic_file.name}...", end=" ")
        
        if convert_heic_to_jpg(heic_file, jpg_file):
            original_size = heic_file.stat().st_size / (1024 * 1024)
            new_size = jpg_file.stat().st_size / (1024 * 1024)
            print(f"✓ Done ({original_size:.2f}MB → {new_size:.2f}MB)")
            converted += 1
        else:
            print("✗ Failed")
            failed += 1
    
    print(f"\n{'='*60}")
    print(f"Conversion Summary:")
    print(f"  Converted: {converted} files")
    print(f"  Skipped: {skipped} files (JPG already exists)")
    print(f"  Failed: {failed} files")
    print(f"{'='*60}")

if __name__ == "__main__":
    main()

