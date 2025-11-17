# Server Room Background Image Setup

## Quick Setup

1. **Save your server room photo** to:
   ```
   AI_Consulting/assets/server-room-bg.jpg
   ```
   
   (You can also use `.png` format - just update the CSS file)

2. **Supported formats:**
   - `.jpg` / `.jpeg` (recommended for photos)
   - `.png` (if you need transparency)
   - `.webp` (for better compression)

3. **If using a different filename**, update `style.css` line ~20:
   ```css
   background-image: url('assets/your-filename.jpg');
   ```

## Image Recommendations

- **Optimal size:** 1920x1080 or larger
- **File size:** Keep under 500KB for fast loading (compress if needed)
- **Aspect ratio:** 16:9 works best

The CSS is already configured to use the image as a fixed background with a dark overlay for text readability.

