# PowerShell script to compress large video files for web deployment
# Requires FFmpeg to be installed

$agriMediaPath = "agri_media"
$maxFileSizeMB = 100  # Maximum file size in MB (GitHub recommends < 100MB, but we'll try to keep under 50MB)
$targetBitrate = "2M"  # Target bitrate for compression

# Check if FFmpeg is available
$ffmpegAvailable = $false
try {
    $ffmpegVersion = & ffmpeg -version 2>&1
    if ($LASTEXITCODE -eq 0) {
        $ffmpegAvailable = $true
        Write-Host "FFmpeg found - ready to compress videos" -ForegroundColor Green
    }
} catch {
    Write-Host "FFmpeg not found in PATH" -ForegroundColor Yellow
}

if (-not $ffmpegAvailable) {
    Write-Host "ERROR: FFmpeg not found!" -ForegroundColor Red
    Write-Host "Please install FFmpeg:" -ForegroundColor Yellow
    Write-Host "  Windows (chocolatey): choco install ffmpeg" -ForegroundColor Cyan
    Write-Host "  Windows (scoop): scoop install ffmpeg" -ForegroundColor Cyan
    Write-Host "  Or download from: https://ffmpeg.org/download.html" -ForegroundColor Cyan
    exit 1
}

# Get all video files
$videoFiles = Get-ChildItem -Path $agriMediaPath -Include *.mp4,*.MP4,*.mov,*.MOV -File

Write-Host "Found $($videoFiles.Count) video files to process" -ForegroundColor Green
Write-Host ""

$compressedCount = 0
$skippedCount = 0
$totalOriginalSize = 0
$totalCompressedSize = 0

foreach ($videoFile in $videoFiles) {
    $fileSizeMB = [math]::Round($videoFile.Length / 1MB, 2)
    $totalOriginalSize += $fileSizeMB
    
    Write-Host "Processing: $($videoFile.Name) ($fileSizeMB MB)" -ForegroundColor Cyan
    
    # Skip if file is already small enough
    if ($fileSizeMB -lt $maxFileSizeMB) {
        Write-Host "  ✓ File is already under $maxFileSizeMB MB - skipping" -ForegroundColor Green
        $skippedCount++
        $totalCompressedSize += $fileSizeMB
        continue
    }
    
    # Create compressed filename
    $compressedPath = Join-Path $agriMediaPath ($videoFile.BaseName + "_compressed.mp4")
    
    # Skip if compressed version already exists
    if (Test-Path $compressedPath) {
        $compressedSizeMB = [math]::Round((Get-Item $compressedPath).Length / 1MB, 2)
        Write-Host "  → Compressed version exists ($compressedSizeMB MB) - skipping" -ForegroundColor Yellow
        $skippedCount++
        $totalCompressedSize += $compressedSizeMB
        continue
    }
    
    Write-Host "  Compressing to $compressedPath..." -ForegroundColor Yellow
    
    try {
        # Use FFmpeg to compress video
        # -c:v libx264: Use H.264 codec
        # -b:v $targetBitrate: Set video bitrate
        # -preset medium: Balance between speed and compression
        # -crf 23: Quality setting (lower = better quality, higher = smaller file)
        # -c:a aac: Use AAC audio codec
        # -b:a 128k: Set audio bitrate
        # -movflags +faststart: Enable web optimization
        
        $ffmpegArgs = @(
            "-i", "`"$($videoFile.FullName)`"",
            "-c:v", "libx264",
            "-preset", "medium",
            "-crf", "23",
            "-b:v", $targetBitrate,
            "-c:a", "aac",
            "-b:a", "128k",
            "-movflags", "+faststart",
            "-y",
            "`"$compressedPath`""
        )
        
        $process = Start-Process -FilePath "ffmpeg" -ArgumentList $ffmpegArgs -Wait -NoNewWindow -PassThru
        
        if ($process.ExitCode -eq 0 -and (Test-Path $compressedPath)) {
            $compressedSizeMB = [math]::Round((Get-Item $compressedPath).Length / 1MB, 2)
            $savings = [math]::Round($fileSizeMB - $compressedSizeMB, 2)
            $savingsPercent = [math]::Round(($savings / $fileSizeMB) * 100, 1)
            
            Write-Host "  ✓ Compressed: $compressedSizeMB MB (saved $savings MB, $savingsPercent%)" -ForegroundColor Green
            $compressedCount++
            $totalCompressedSize += $compressedSizeMB
        } else {
            Write-Host "  ✗ Compression failed" -ForegroundColor Red
            $totalCompressedSize += $fileSizeMB
        }
    } catch {
        Write-Host "  ✗ Error compressing $($videoFile.Name): $_" -ForegroundColor Red
        $totalCompressedSize += $fileSizeMB
    }
    
    Write-Host ""
}

Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "Compression Summary:" -ForegroundColor Green
Write-Host "  Files processed: $($videoFiles.Count)" -ForegroundColor Cyan
Write-Host "  Files compressed: $compressedCount" -ForegroundColor Green
Write-Host "  Files skipped: $skippedCount" -ForegroundColor Yellow
Write-Host "  Original total size: $([math]::Round($totalOriginalSize, 2)) MB" -ForegroundColor Cyan
Write-Host "  Compressed total size: $([math]::Round($totalCompressedSize, 2)) MB" -ForegroundColor Green
Write-Host "  Total savings: $([math]::Round($totalOriginalSize - $totalCompressedSize, 2)) MB" -ForegroundColor Green

if ($compressedCount -gt 0) {
    Write-Host ""
    Write-Host "Note: Original files are preserved. Review compressed files and update HTML if needed." -ForegroundColor Yellow
}

