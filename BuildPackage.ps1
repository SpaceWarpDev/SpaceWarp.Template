$SrcFolderPath = "src"
$BuildFolderPath = "build"
$DistFolderPath = "dist"

$ReplacementsFile = "replacements.ini"

function Read-IniFile ($filePath) {
    $ini = @{}
    Get-Content $filePath | ForEach-Object {
        # Remove comments from the line
        $line = $_ -split '[#;]', 2 | Select-Object -First 1

        # Process if the line contains an '=' character
        if ($line -match "([^=]+)=(.*)") {
            $name, $value = $matches[1].Trim(), $matches[2].Trim()
            $ini[$name] = $value
        }
    }
    return $ini
}


$Replacements = @{}

if (Test-Path $ReplacementsFile) {
    $Replacements = Read-IniFile $ReplacementsFile
} else {
    Write-Error "Replacements file not found. Please ensure that '$ReplacementsFile' exists."
    exit
}

if (Test-Path $BuildFolderPath) {
    Write-Host "Removing build folder from previous build"
    Remove-Item -Path $BuildFolderPath -Recurse -Force
}

Write-Host "Creating temporary folder"
New-Item -ItemType Directory -Force -Path $BuildFolderPath | Out-Null

Write-Host "Copying templates to temporary folder"
Copy-Item -Path "$SrcFolderPath/templates/" -Destination $BuildFolderPath -Recurse -Exclude "bin", "obj"

Write-Host "Copying common files to temporary folder"
Get-ChildItem -Path "$BuildFolderPath/templates" -Directory | ForEach-Object {
    Copy-Item -Path "$SrcFolderPath/common/*" -Destination $_.FullName -Recurse -Force
}

$skipExtensions = @(".jpg", ".jpeg", ".png", ".gif", ".bmp")

Get-ChildItem -Path "$BuildFolderPath/templates" -Directory | ForEach-Object {
    $currentTemplateName = $_.Name
    $Replacements["SpaceWarpTemplateName"] = $currentTemplateName

    Get-ChildItem -Path $_.FullName -Recurse -File -Force | ForEach-Object {
        if ($skipExtensions -contains $_.Extension) {
            Write-Host "Skipped binary file ""$($_.Name)"""
        } else {
            $fileContent = Get-Content $_.FullName -Raw

            foreach ($replacement in $Replacements.Keys) {
                $fileContent = $fileContent -replace $replacement, $Replacements[$replacement]
            }

            Set-Content -Path $_.FullName -Value $fileContent
        }
    }
}

Write-Host "Packing NuGet package"
if ($IsWindows) {
    $nugetCommand = "nuget"
} else {
    $nugetCommand = "mono /usr/local/bin/nuget.exe"
}
$nugetOutput = Invoke-Expression "& $nugetCommand pack `"./Package.nuspec`" -NoDefaultExcludes -OutputDirectory `"$DistFolderPath`" -Properties `"NoWarn=NU5110,NU5111;buildDir=$BuildFolderPath`" 2>&1"
$nugetOutput | ForEach-Object {
    if ($_ -match "SpaceWarp\.Template\.[0-9\.]+\.nupkg") {
        $nugetFileName = $matches[0]
        $destinationPath = "$DistFolderPath/SpaceWarp.Template.nupkg"
        Copy-Item -Path "$DistFolderPath/$nugetFileName" -Destination $destinationPath -Force
        Write-Host "Copied NuGet package to $destinationPath"
    }
}

Write-Host "NuGet package build complete."