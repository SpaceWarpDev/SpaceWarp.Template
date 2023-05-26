@echo off

:start
echo KSP2DIR environment variable not set!
echo It should contain the path to the KSP 2 installation that you want to use for development.
echo.
echo Do you want to set it now?
echo 1. Yes, try to find KSP 2 in my Steam libraries
echo 2. Yes, I will set it manually
echo 3. No, I will set it later
echo.
choice /c 123 /n /m "Choice [1-3]: "

if %errorlevel% == 0 goto start_error
if errorlevel 4 goto start_error

if %errorlevel% == 1 goto find
if %errorlevel% == 2 goto manual
if %errorlevel% == 3 goto later

:find
call powershell.exe -ExecutionPolicy RemoteSigned -File "scripts\setup\ksp2_finder.ps1"
if %errorlevel% == 0 (
    echo.
    goto end
)

echo KSP 2 not found, do you want to enter the path manually?
choice /c YN /n /m "Choice [Y/N]: "

if %errorlevel% == 0 goto find_error
if errorlevel 3 goto find_error

if %errorlevel% == 1 goto manual
if %errorlevel% == 2 goto later

:manual
echo.
set /p "KSP2DIR=KSP 2 installation path: "
if "%KSP2DIR%" == "" goto invalid_path
if not exist "%KSP2DIR%" goto invalid_path
setx KSP2DIR "%KSP2DIR%"
echo KSP2DIR environment variable set to "%KSP2DIR%".
echo.
goto end

:invalid_path
echo Invalid path, do you want to try again?
choice /c YN /n /m "Choice [Y/N]: "

if %errorlevel% == 0 goto invalid_path_error
if errorlevel 3 goto invalid_path_error

if %errorlevel% == 1 goto manual
if %errorlevel% == 2 goto later
echo.

:start_error
echo Invalid choice.
echo.
goto start

:find_error
echo Invalid choice.
echo.
goto find

:invalid_path_error
echo Invalid choice.
echo.
goto invalid_path

:later
echo.
echo KSP2DIR environment variable not set. If you want to use the Deploy and DeployAndRun configurations, you will need to set it manually, or fill in the correct path in the KSP2DIR property inside your .csproj file.

:end