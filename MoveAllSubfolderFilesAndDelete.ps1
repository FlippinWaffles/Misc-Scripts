# Get the current directory where the script is executed
$parentFolderPath = Get-Location

# Confirm action with the user
$confirmation = Read-Host "Are you sure you want to move all files from subfolders to the parent folder and delete the subfolders? (Y/N)"
if ($confirmation -ne 'Y') {
    Write-Host "Operation cancelled."
    exit
}

# Get all subfolders in the current directory
$subfolders = Get-ChildItem -Path $parentFolderPath -Directory

foreach ($subfolder in $subfolders) {
    # Move all files from the subfolder to the parent folder
    Get-ChildItem -Path $subfolder.FullName -File | ForEach-Object {
        $destinationPath = Join-Path -Path $parentFolderPath -ChildPath $_.Name
        Move-Item -Path $_.FullName -Destination $destinationPath -Force
    }
    
    # Remove the subfolder
    Remove-Item -Path $subfolder.FullName -Recurse -Force
}

Write-Host "Operation completed."
