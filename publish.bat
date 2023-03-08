@echo off
dotnet nuget push ./nuget/SpaceWarp.Template.nupkg --api-key %NUGET_API_KEY% --source https://api.nuget.org/v3/index.json