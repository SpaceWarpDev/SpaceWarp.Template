# Get the content of the NOTICE file
$notice = Get-Content .\NOTICE

# Get all files with the .cs extension in the current folder and all subfolders
$files = Get-ChildItem -Path . -Filter "*.cs" -File -Recurse

# Prepend the content of the NOTICE file to each .cs file
foreach ($file in $files) {
    Write-Output "Prepending NOTICE to $file"
    # Read the content of the current file
    $currentContent = Get-Content $file.FullName

    # Prepend NOTICE file content to the current file
    $updatedContent = $notice + $currentContent

    # Write the updated content back to the file
    $updatedContent | Set-Content $file.FullName
}