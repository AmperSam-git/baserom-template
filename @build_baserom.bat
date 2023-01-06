@echo off
cls
:start

:: Working Directory
setlocal DisableDelayedExpansion
set WORKING_DIR=%~sdp0
set WORKING_DIR=%WORKING_DIR:!=^^!%
setlocal EnableDelayedExpansion

:: ROM Definitions
set ROM_NAME_FILE=%WORKING_DIR%Other\rom-name.txt
:: Check if rom-name.txt exists
if not exist !ROM_NAME_FILE! (
    :: Ask for ROM name
    set /p ROM_NAME_INPUT=Enter the filename of your ROM, e.g. "MyHack": 
    echo !ROM_NAME_INPUT!>!ROM_NAME_FILE!
    :: Set ROM name
    set /p ROM_NAME=<!ROM_NAME_FILE!
) else (
    :: Set ROM name
    set /p ROM_NAME=<!ROM_NAME_FILE!
)

:: Directory definitions
set TOOLS_DIR=%WORKING_DIR%Tools\

:: Variables
set ROMFILE=%WORKING_DIR%%ROM_NAME%.smc
set PATCHNAME=%WORKING_DIR%%ROM_NAME%.bps

:: Patch list files in Tools\Asar
set PATCH_LIST=patchlist.txt

:: Options
echo Build Actions
echo.
echo   1. Apply Asar Patches
echo   2. Insert Custom Blocks
echo   3. Insert Custom Sprites
echo   4. Insert Custom Music
echo   5. Insert Custom UberASM
echo   6. Create BPS Patch
echo   0. Exit
echo.
set /p Action=Enter the number of your choice:

:: Apply asar patches
if "!Action!"=="1" (
    echo Applying patches...
    pushd %TOOLS_DIR%Asar
    for /f "tokens=*" %%a in (%PATCH_LIST%) do (asar.exe -v %%a !ROMFILE!)
    echo Done.
)
:: Insert custom blocks with GPS
if "!Action!"=="2" (
    echo Inserting custom blocks...
    pushd %TOOLS_DIR%GPS
    gps.exe !ROMFILE!
    echo Done.
)
:: Insert Custom Sprites with PIXI
set PIXI_LIST=%TOOLS_DIR%PIXI\list.txt
if "!Action!"=="3" (
    echo Inserting custom sprites...
    pushd %TOOLS_DIR%PIXI
    pixi.exe -l "%PIXI_LIST%" !ROMFILE!
    echo Done.
)
:: Insert custom music with AddmusicK
if "!Action!"=="4" (
    echo Inserting custom Music...
    pushd %TOOLS_DIR%AddmusicK_1.0.8\
    AddmusicK.exe !ROMFILE!
    echo Done.
)
:: Insert custom uberASM
set UBER_LIST=%TOOLS_DIR%UberASMTool\list.txt
if "!Action!"=="5" (
    echo Inserting UberASM...
    pushd %TOOLS_DIR%UberASMTool
    UberASMTool.exe "%UBER_LIST%" !ROMFILE!
    echo Done.
)
:: Create bps Patch with Flips
if "!Action!"=="6" (
    echo Creating BPS patch...
    set SMWROM=
    if not exist "%WORKING_DIR%sysLMRestore\smwOrig.smc" (
        echo Could not find an unmodified SMW file. Enter the path to an original, unmodified SMW smc:
        set /p SMWROM=
    ) else (
        set SMWROM="%WORKING_DIR%sysLMRestore\smwOrig.smc"
    )
    pushd %TOOLS_DIR%Flips
    flips.exe --create --bps !SMWROM! !ROMFILE! !PATCHNAME!
)

popd

if "!Action!"=="0" (
    echo Have a nice day ^^_^^
    exit /b
)
if '!Action!'=='' echo Nothing is not valid option, please try again.

pause
exit /b