@echo off

echo This script will create a new SpaceWarp mod project.
echo.
echo Choose the template you want to use:
echo 1. General mod (with example code)
echo 2. Empty mod
echo 3. Library mod
echo.
choice /c 123 /n /m "Choice [1-3]: "

if %errorlevel% == 0 goto error
if %errorlevel% == 255 goto error

set choice=%errorlevel%

echo.
echo Fill in the following information:
echo (Parameters marked with (*) are required, the rest are optional.)
echo.

:project_name
set /p "ProjectName=(*)Project name (e.g. MyMod): "
if "%ProjectName%" == "" (
    echo Project name is required.
    goto project_name
)
:mod_name
set /p "ModName=(*)Mod name (e.g. My Mod): "
if "%ModName%" == "" (
    echo Mod name is required.
    goto mod_name
)
:author
set /p "Author=(*)Authors (e.g. John Doe;Jane Doe): "
if "%Author%" == "" (
    echo Authors are required.
    goto author
)
set "Description="
set /p "Description=Description (default is empty): "
set "Source="
set /p "Source=Source repository URL (default is empty): "
set "Version=1.0.0"
set /p "Version=Version (default is 1.0.0): "
set "CheckVersion="
set /p "CheckVersion=Version check URL (default is empty): "

if %choice% == 1 goto general
if %choice% == 2 goto empty
if %choice% == 3 goto library

:error
echo Invalid choice.
goto end

:general
echo Creating general mod project...
dotnet new spacewarpmod-general -n "%ProjectName%" -M "%ModName%" -A "%Author%" -D "%Description%" -S "%Source%" -V "%Version%" -C "%CheckVersion%"
goto setup

:empty
echo Creating empty mod project...
dotnet new spacewarpmod-empty -n "%ProjectName%" -M "%ModName%" -A "%Author%" -D "%Description%" -S "%Source%" -V "%Version%" -C "%CheckVersion%"
goto setup

:library
set /p "LicenseUrl=License URL (default is empty): "
echo Creating library mod project...
dotnet new spacewarpmod-library -n "%ProjectName%" -M "%ModName%" -A "%Author%" -D "%Description%" -S "%Source%" -V "%Version%" -C "%CheckVersion%" -L "%LicenseUrl%"
goto setup

:setup
cd "%ProjectName%"
echo.
echo Running setup script...
call "scripts\setup.bat"

:end