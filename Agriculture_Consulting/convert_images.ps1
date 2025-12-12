# PowerShell script to convert HEIC images to JPG
# Requires ImageMagick or heif-convert (libheif)

$agriMediaPath = "agri_media"
$heicFiles = Get-ChildItem -Path $agriMediaPath -Filter "*.HEIC" -File
$heicFiles += Get-ChildItem -Path $agriMediaPath -Filter "*.heic" -File

Write-Host "Found $($heicFiles.Count) HEIC files to convert" -ForegroundColor Green

# Check if ImageMagick is available
$magickAvailable = $false
try {
    $magickVersion = & magick -version 2>&1
    if ($LASTEXITCODE -eq 0) {
        $magickAvailable = $true
        Write-Host "ImageMagick found - using magick command" -ForegroundColor Green
    }
} catch {
    Write-Host "ImageMagick not found in PATH" -ForegroundColor Yellow
}

# Check if heif-convert is available
$heifAvailable = $false
try {
    $heifVersion = & heif-convert --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        $heifAvailable = $true
        Write-Host "heif-convert found - using heif-convert command" -ForegroundColor Green
    }
} catch {
    Write-Host "heif-convert not found in PATH" -ForegroundColor Yellow
}

if (-not $magickAvailable -and -not $heifAvailable) {
    Write-Host "ERROR: Neither ImageMagick nor heif-convert found!" -ForegroundColor Red
    Write-Host "Please install one of the following:" -ForegroundColor Yellow
    Write-Host "  1. ImageMagick: https://imagemagick.org/script/download.php" -ForegroundColor Yellow
    Write-Host "  2. libheif (includes heif-convert): https://github.com/strukturag/libheif" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "For Windows, you can install ImageMagick via:" -ForegroundColor Yellow
    Write-Host "  choco install imagemagick" -ForegroundColor Cyan
    Write-Host "  OR" -ForegroundColor Yellow
    Write-Host "  Download from: https://imagemagick.org/script/download.php#windows" -ForegroundColor Cyan
    exit 1
}

$convertedCount = 0
$skippedCount = 0

foreach ($heicFile in $heicFiles) {
    $jpgPath = Join-Path $agriMediaPath ($heicFile.BaseName + ".jpg")
    
    # Skip if JPG already exists
    if (Test-Path $jpgPath) {
        Write-Host "Skipping $($heicFile.Name) - JPG already exists" -ForegroundColor Yellow
        $skippedCount++
        continue
    }
    
    Write-Host "Converting $($heicFile.Name) to JPG..." -ForegroundColor Cyan
    
    try {
        if ($magickAvailable) {
            & magick $heicFile.FullName -quality 85 $jpgPath
        } elseif ($heifAvailable) {
            & heif-convert $heicFile.FullName $jpgPath
        }
        
        if (Test-Path $jpgPath) {
            Write-Host "  ✓ Successfully converted to $jpgPath" -ForegroundColor Green
            $convertedCount++
        } else {
            Write-Host "  ✗ Conversion failed - output file not found" -ForegroundColor Red
        }
    } catch {
        Write-Host "  ✗ Error converting $($heicFile.Name): $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Conversion complete!" -ForegroundColor Green
Write-Host "  Converted: $convertedCount files" -ForegroundColor Green
Write-Host "  Skipped: $skippedCount files (JPG already exists)" -ForegroundColor Yellow
Write-Host "  Total processed: $($heicFiles.Count) files" -ForegroundColor Cyan

