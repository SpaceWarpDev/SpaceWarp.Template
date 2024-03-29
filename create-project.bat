@echo off

echo Checking if SpaceWarp.Template is installed...
for /f "tokens=*" %%i in ('dotnet new --list ^| findstr /i "SpaceWarp"') do set template=%%i

if not defined template (
    echo SpaceWarp.Template is not installed.
    choice /c yn /m "Do you want to install it?"
    echo.
    if errorlevel 2 goto end
    echo Installing SpaceWarp.Template...
    dotnet new install SpaceWarp.Template
    goto update
) else (
    echo SpaceWarp.Template is installed.
)

echo Checking for updates...
for /f "tokens=*" %%i in ('dotnet new update --check-only ^| findstr /i "SpaceWarp.Template"') do set update=%%i

if defined update (
    echo Updates are available for SpaceWarp.Template.
    choice /c yn /m "Do you want to update it?"
    echo.
    if errorlevel 2 goto skipupdate
    echo Updating SpaceWarp.Template...
    dotnet new install SpaceWarp.Template
    goto update
) else (
    echo No updates are available for SpaceWarp.Template.
    goto skipupdate
)

:update

cls

(
    echo @echo off
    echo echo Updating the create-project.bat script...
    echo timeout /t 1 /nobreak ^>nul
    echo curl -s -L -o create-project-temp.bat https://raw.githubusercontent.com/SpaceWarpDev/SpaceWarp.Template/main/create-project.bat
    echo if %%errorlevel%% neq 0 ^(
    echo     echo Failed to download the script.
    echo     pause
    echo ^) else ^(
    echo     echo The script has been updated to the latest version.
    echo     echo Restarting the script...
    echo     move /y create-project-temp.bat create-project.bat ^> NUL
    echo     cls
    echo     start "" create-project.bat ^> NUL
    echo     del /f /q update-create-project.bat ^> NUL
    echo ^)
) > update-create-project.bat

echo Starting the update script...
start "" update-create-project.bat
exit /b

:skipupdate

cls

echo This script will create a new SpaceWarp mod project.
echo.
echo Choose the template you want to use:
echo 1. General mod (with example code)
echo 2. General mod with UI
echo 3. Empty mod
echo 4. Library mod
echo.
choice /c 1234 /n /m "Choice [1-4]: "

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
if %choice% == 2 goto ui
if %choice% == 3 goto empty
if %choice% == 4 goto library

:error
echo Invalid choice.
goto end

:general
echo Creating general mod project...
dotnet new spacewarpmod-general -n "%ProjectName%" -M "%ModName%" -A "%Author%" -D "%Description%" -S "%Source%" -V "%Version%" -C "%CheckVersion%"
goto setup

:ui
echo Creating UI mod project...
dotnet new spacewarpmod-ui -n "%ProjectName%" -M "%ModName%" -A "%Author%" -D "%Description%" -S "%Source%" -V "%Version%" -C "%CheckVersion%"
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