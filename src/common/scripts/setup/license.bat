@echo off

:start
echo Do you want to choose a license for your mod?
choice /c YN /n /m "Choice [Y/N]: "

if %errorlevel% == 0 goto start_error
if errorlevel 3 goto start_error

if %errorlevel% == 1 goto choose_license
if %errorlevel% == 2 goto end

:choose_license
echo.
echo Choose a license (if you need help choosing, see https://choosealicense.com/):
echo 1. Apache License 2.0
echo 2. GNU GPL v3.0
echo 3. GNU LGPL v3.0
echo 4. ISC License
echo 5. MIT License
echo 6. Mozilla Public License 2.0
echo 7. Unlicense
echo 8. None of the above (exit)
echo.
choice /c 12345678 /n /m "Choice [1-8]: "

if %errorlevel% == 0 goto error
if errorlevel 9 goto error

if %errorlevel% == 1 (
    set folder="apache-2.0"
    set notice=1
)
if %errorlevel% == 2 (
    set folder="gplv3"
    set notice=1
)
if %errorlevel% == 3 (
    set folder="lgplv3"
    set notice=1
)
if %errorlevel% == 4 (
    set folder="isc"
    set notice=0
)
if %errorlevel% == 5 (
    set folder="mit"
    set notice=0
)
if %errorlevel% == 6 (
    set folder="mpl-2.0"
    set notice=1
)
if %errorlevel% == 7 (
    set folder="unlicense"
    set notice=0
)
if %errorlevel% == 8 goto end

xcopy /y "scripts\setup\licenses\%folder%\*" .
if %notice% == 1 (
    call powershell.exe -ExecutionPolicy RemoteSigned -File "scripts\setup\prepend_notice.ps1"
    echo NOTICE: You should include the license notice in all of your mod's source code files, see you main plugin class file for an example.
    del NOTICE
)
goto end

:start_error
echo Invalid choice.
goto start

:error
echo Invalid choice.
goto choose_license

:end