@echo off

echo Do you want a Git repository to be initialized in the project folder?
choice /c YN /n /m "Choice [Y/N]: "

if %errorlevel% == 0 goto error
if errorlevel 3 goto error

if %errorlevel% == 1 goto git
if %errorlevel% == 2 goto end

:git

git init --initial-branch=main

:end