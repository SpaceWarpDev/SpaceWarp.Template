$module = Get-Module -ListAvailable Microsoft.PowerShell.Archive -ErrorAction SilentlyContinue | Sort-Object Version -Descending | Select-Object -First 1
if (-not $module -or [version]$module.Version -lt [version]'1.2.3.0') {
    Start-Process powershell -ArgumentList 'Install-Module Microsoft.PowerShell.Archive -MinimumVersion 1.2.3.0 -Repository PSGallery -Force; Import-Module Microsoft.PowerShell.Archive' -Verb RunAs
}