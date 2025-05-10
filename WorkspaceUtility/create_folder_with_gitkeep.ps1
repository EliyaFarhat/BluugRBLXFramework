# Prompt user for relative path
$relativePath = Read-Host "Enter the relative path (from project root) where the folder should go (e.g., Src/Modules)"

# Prompt user for folder name
$folderName = Read-Host "Enter the name of the new folder"

# Function to find project root by locating .git
function Get-ProjectRoot {
    $dir = Get-Location
    while ($dir -ne $null -and !(Test-Path (Join-Path $dir ".git"))) {
        $dir = $dir.Parent
    }
    return $dir
}

$projectRoot = Get-ProjectRoot

if (-not $projectRoot) {
    Write-Error "Could not find .git directory in any parent folders. Are you inside a Git repo?"
    exit 1
}

# Resolve full target path
$targetPath = Join-Path $projectRoot $relativePath
$finalPath = Join-Path $targetPath $folderName

# Create folder and .gitkeep
New-Item -ItemType Directory -Force -Path $finalPath | Out-Null
New-Item -ItemType File -Force -Path (Join-Path $finalPath ".gitkeep") | Out-Null

Write-Host "✅ Created folder at '$finalPath' with .gitkeep"