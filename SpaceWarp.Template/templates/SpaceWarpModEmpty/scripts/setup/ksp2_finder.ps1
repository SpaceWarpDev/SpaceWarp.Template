# Get Steam install location from registry
$steamInstallPath = Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Valve\Steam" | Select-Object -ExpandProperty InstallPath

# Check if the Steam installation path exists
if (-not(Test-Path $steamInstallPath))
{
    Write-Error "Steam installation path not found"
    exit 1
}
Write-Output "Steam installation path found: $steamInstallPath"

# Construct the path to the vdf file that contains the game library information
$vdfPath = Join-Path $steamInstallPath 'steamapps\libraryfolders.vdf'

# Read the vdf file and convert it to a hashtable
$vdfContent = Get-Content $vdfPath -Raw
$paths = [Regex]::Matches($vdfContent, '"path"\s+"([^"]+)"') | ForEach-Object { $_.Groups[1].Value -replace '\\\\', '\' }

# Construct the full KSP 2 game path for each library folder and check if it exists
$gameFolder = 'steamapps\common\Kerbal Space Program 2'
foreach ($path in $paths) {
    $gamePath = Join-Path $path $gameFolder
    if (Test-Path $gamePath -PathType Container) {
        [System.Environment]::SetEnvironmentVariable('KSP2DIR', $gamePath, 'User')
        Write-Output "KSP2DIR environment variable set to $gamePath."
        exit 0
    }
}

exit 1