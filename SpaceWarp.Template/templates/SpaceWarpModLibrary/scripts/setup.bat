@echo off

if not "%KSP2DIR%" == "" (
    goto license_start
)

call "scripts\setup\set_env_var.bat"

:license_start

call "scripts\setup\license.bat"

call "scripts\setup\git_init.bat"

rmdir /s /q "scripts\setup"

echo.
echo Setup is finished.
(goto) 2>nul & del "%~f0"