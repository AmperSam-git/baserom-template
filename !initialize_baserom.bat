@echo off
cls

set "rom_check=%CD%\workspace\*.smc"

:: Check if clean rom exists as it is required by Callisto
if exist "%rom_check%" (
    :: run the main PowerShell script with an Execution Policy bypass
    powershell.exe -ExecutionPolicy Bypass .\init\baserom_init.ps1
) else (
    :: Give warning message about a missing rom
    echo -- Cannot Proceed --
    echo.
    echo You have not provided a Super Mario World ROM for use with the baserom tools.
    echo Please put a copy of your headered ROM in the ^"workspace^" folder or consult
    echo the Readme for details.
    echo.
)
pause