@echo off
cls
:start

:: Working Directory
setlocal DisableDelayedExpansion
set WORKING_DIR=%~sdp0
set WORKING_DIR=%WORKING_DIR:!=^^!%
setlocal EnableDelayedExpansion

:: Directory definitions
set TOOLS_DIR=%WORKING_DIR%Tools\

:: Import Definitions
call %WORKING_DIR%Tools\@tool_defines.bat

:: Options
echo Commands to Initialize Baserom
echo.
echo   1. Download and Setup all Baserom tools
echo   0. Exit
echo.
set /p Action=Enter the number of your choice:
echo.

:: Download Baserom Tools
if "!Action!"=="1" (

    :: Check if AMK exists and download if not
    if not exist "!AMK_DIR!AddmusicK.exe" (
        echo AddmusicK not found, downloading...
        powershell Invoke-WebRequest !AMK_DL! -OutFile !AMK_ZIP! >NUL
        powershell Expand-Archive !AMK_ZIP! -DestinationPath !TOOLS_DIR! >NUL
        :: Delete junk files
        for %%a in (!AMK_JUNK!) do (del !AMK_DIR!%%a)
        for %%a in (!AMK_JUNK_DIR!) do (rmdir /S /Q !AMK_DIR!%%a)
        :: Delete Zip
        del !AMK_ZIP!
        echo Done.
    ) else (
        echo -- AddmusicK already setup.
    )

    :: Check if Asar exists and download if not
    if not exist "!ASAR_DIR!asar.exe" (
        echo Asar not found, downloading...
        powershell Invoke-WebRequest !ASAR_DL! -OutFile !ASAR_ZIP! >NUL
        powershell Expand-Archive !ASAR_ZIP! -DestinationPath !ASAR_DIR! >NUL
        :: Delete junk files
        for %%a in (!ASAR_JUNK!) do (del !ASAR_DIR!%%a)
        for %%a in (!ASAR_JUNK_DIR!) do (rmdir /S /Q !ASAR_DIR!%%a)
        :: Delete Zip
        del !ASAR_ZIP!
        echo Done.
    ) else (
        echo -- Asar already setup.
    )

    :: Check if Flips exists and download if not
    if not exist "!FLIPS_DIR!flips.exe" (
        echo Flips not found, downloading...
        powershell Invoke-WebRequest !FLIPS_DL! -OutFile !FLIPS_ZIP! >NUL
        powershell Expand-Archive !FLIPS_ZIP! -DestinationPath !FLIPS_DIR! >NUL
        :: Delete junk files
        for %%a in (!FLIPS_JUNK!) do (del !FLIPS_DIR!%%a)
        :: Delete Zip
        del !FLIPS_ZIP!
        echo Done.
    ) else (
        echo -- Flips already setup.
    )

    :: Check if GPS exists and download if not
    if not exist "!GPS_DIR!gps.exe" (
        echo GPS not found, downloading...
        powershell Invoke-WebRequest !GPS_DL! -OutFile !GPS_ZIP! >NUL
        powershell Expand-Archive !GPS_ZIP! -DestinationPath !GPS_DIR! >NUL
        :: Delete junk files
        for %%a in (!GPS_JUNK!) do (del !GPS_DIR!%%a)
        :: Delete Zip
        del !GPS_ZIP!
        echo Done.
    ) else (
        echo -- GPS already setup.
    )

    :: Check if Lunar Magic exists and download if not
    if not exist "!LM_DIR!Lunar Magic.exe" (
        echo Lunar Magic not found, downloading...
        powershell Invoke-WebRequest !LM_DL! -OutFile !LM_ZIP! >NUL
        powershell Expand-Archive !LM_ZIP! -DestinationPath !LM_DIR! >NUL
        :: Delete junk files
        for %%a in (!LM_JUNK!) do (del !LM_DIR!%%a)
        :: Delete Zip
        del !LM_ZIP!
        echo Done.
    ) else (
        echo -- Lunar Magic already setup.
    )

    :: Check if PIXI exists and download if not
    if not exist "!PIXI_DIR!pixi.exe" (
        echo PIXI not found, downloading...
        powershell Invoke-WebRequest !PIXI_DL! -OutFile !PIXI_ZIP! >NUL
        powershell Expand-Archive !PIXI_ZIP! -DestinationPath !PIXI_DIR! >NUL
        :: Delete junk files
        for %%a in (!PIXI_JUNK!) do (del !PIXI_DIR!%%a)
        :: Make empty list.txt
        copy /y NUL !PIXI_DIR!list.txt
        :: Delete Zip
        del !PIXI_ZIP!
        echo Done.
    ) else (
        echo -- PIXI already setup.
    )

    :: Check if UberASM exists and download if not
    if not exist "!UBER_DIR!UberASMTool.exe" (
        echo UberASMTool not found, downloading...
        powershell Invoke-WebRequest !UBER_DL! -OutFile !UBER_ZIP! >NUL
        powershell Expand-Archive !UBER_ZIP! -DestinationPath !UBER_DIR! >NUL
        :: Delete junk files
        for %%a in (!UBER_JUNK!) do (del !UBER_DIR!%%a)
        :: Fix list.txt
        copy /y %WORKING_DIR%Other\Lists\list_uberasm.txt !UBER_DIR!list.txt
        :: Delete Zip
        del !UBER_ZIP!
        echo Done.
    ) else (
        echo -- UberASMTool already setup.
    )
)


if "!Action!"=="0" (
    echo Have a nice day ^^_^^
    exit /b
)

if '!Action!'=='' echo Nothing is not valid option, please try again.

echo.
echo All done. Have a nice day ^^_^^
echo.
pause
exit /b