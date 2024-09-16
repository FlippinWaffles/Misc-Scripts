# Check if output.txt exists, and delete it if it does
if (Test-Path "output.txt") {
    Remove-Item "output.txt"
}

# Process folders and subfolders
Get-ChildItem -Directory | ForEach-Object {
    # Get main folder name
    $mainFolder = $_.Name

    # Get subfolders and display them on the same line with a dash
    Get-ChildItem $_.FullName -Directory | ForEach-Object {
        "$mainFolder - $($_.Name)" | Out-File "output.txt" -Append
    }

    # If there are no subfolders, just output the main folder with a note
    if (-not (Get-ChildItem $_.FullName -Directory)) {
        "$mainFolder - (No subfolders)" | Out-File "output.txt" -Append
    }
}