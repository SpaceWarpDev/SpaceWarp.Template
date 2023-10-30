@echo off

:: Get the name of the current directory and extract the last folder name
for %%I in (%CD%) do set CURR_DIR_NAME=%%~nxI

:: Check if the current directory name is "scripts" and change to the parent directory if true
if /i "%CURR_DIR_NAME%"=="scripts" (
    cd ..
)

:: Inform the user about the PowerShell module check and installation, then wait for a key press to continue
echo The Microsoft.PowerShell.Archive module will be checked for updates due to a bug that affects zipping of mod releases, breaking their CKAN installation.
echo The script will open in a new windows and request administrative privileges if there is a required package update. Please allow it to proceed until it closes itself.
echo Press any key to continue...
pause >nul

:: Execute the PowerShell script to check and install the necessary module version
powershell -ExecutionPolicy Bypass -File "scripts\setup\check_archive_version.ps1"

:: Check if the KSP2DIR variable is set, and if it is, skip to the licensing step
if not "%KSP2DIR%" == "" (
    goto license_start
)

:: Call another batch file to set environment variables
call "scripts\setup\set_env_var.bat"

:license_start

:: Call another batch file for licensing
call "scripts\setup\license.bat"

:: Initialize git for the project
call "scripts\setup\git_init.bat"

:: Remove the setup scripts directory after the setup is completed
rmdir /s /q "scripts\setup"

:: Display a message indicating the setup process is finished
echo.
echo Setup is finished.

:: Delete this batch file after it finishes executing
(goto) 2>nul & del "%~f0"