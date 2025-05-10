# Ask for the base directory path where the new folder should be created
$baseDir = Read-Host "Enter the directory where you want to create the new folder"

# Check if the directory exists
if (-Not (Test-Path $baseDir)) {
    Write-Host "The specified directory does not exist."
    exit
}

# Ask for the new folder name
$newFolderName = Read-Host "Enter the name of the new folder"

# Construct the full path for the new folder
$fullPath = Join-Path -Path $baseDir -ChildPath $newFolderName

# Create the folder and add the .gitkeep file
New-Item -ItemType Directory -Force -Path $fullPath
New-Item -ItemType File -Force -Path (Join-Path -Path $fullPath -ChildPath ".gitkeep")

Write-Host "Created folder $newFolderName with .gitkeep in $baseDir"