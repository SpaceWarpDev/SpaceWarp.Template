@echo off
dotnet nuget push ./dist/SpaceWarp.Template.nupkg --api-key %NugetApiKey% --source https://api.nuget.org/v3/index.json