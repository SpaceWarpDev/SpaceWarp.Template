@echo off
dotnet nuget push ./nuget/SpaceWarp.Template.nupkg --api-key %1 --source https://api.nuget.org/v3/index.json