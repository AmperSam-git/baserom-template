@echo off
cls

:: Working Directory
setlocal DisableDelayedExpansion
set WORKING_DIR=%~dp0
set WORKING_DIR=%WORKING_DIR:!=^^!%
setlocal EnableDelayedExpansion

:: get root directory since this script runs from the LM folder
set "ROOT_DIR=!WORKING_DIR:\tools\lunar_magic=!"

:: Other Defines
set "tools_dir=!ROOT_DIR!tools\"
set "project_dir=!ROOT_DIR!workspace\"
set "backup_dir=!ROOT_DIR!backups\"

:: Backup Defines
set "levels_dir=!backup_dir!levels\"
set "map16_dir=!backup_dir!map16\"
set "palette_dir=!backup_dir!palettes\"
set "rom_dir=!backup_dir!rom\"

:: Time stuff
setlocal
for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set DateTime=%%a

set Year=%DateTime:~0,4%
set Month=%DateTime:~4,2%
set Day=%DateTime:~6,2%
set Hour=%DateTime:~8,2%
set Minute=%DateTime:~10,2%

set "time_stamp=%Year%%Month%%Day%_%Hour%-%Minute%"

:: Tools Defines

:: addmusick
set "amk_path=!tools_dir!addmusick"
set "amk_list=!amk_path!\Addmusic_list.txt"
set "amk_exe=AddmusicK.exe"
:: pixi
set "pixi_path=!tools_dir!pixi"
set "pixi_list=!pixi_path!\list.txt"
set "pixi_exe=!pixi_path!\pixi.exe"
:: gps
set "gps_path=!tools_dir!gps"
set "gps_list=!gps_path!\list.txt"
set "gps_exe=gps.exe"
:: uberasm
set "uber_path=!tools_dir!uberasmtool"
set "uber_list=!uber_path!\list.txt"
set "uber_exe=UberASMTool.exe"
:: asar
set "asar_path=!tools_dir!asar"
set "asar_list=!asar_path!\list.txt"
set "asar_exe=asar.exe"
:: lunar magic
set "lm_path=!tools_dir!lunar_magic"
set "lm_exe=Lunar Magic.exe"


:ParseArgs
if "%~1"=="" goto :EOF

if /i "%~1"=="--file" (
    set file=%~2
    goto :RunEditor
)
if /i "%~1"=="--path" (
    set path=%~2
    goto :OpenDir
)
if /i "%~1"=="--app" (
    set path=%~2
    set app=%~3
    set param=%~4
    goto :OpenApp
)
if /i "%~1"=="--run-tool" (
    set path=%~2
    set exe=%~3
    set param=%~4
    set "rom_file=%project_dir%\%~5"
    goto :RunTool
)
if /i "%~1"=="--backup" (
    set "rom_file=%project_dir%\%~2.smc"
    set "rom_name=%~2"
    goto :Backup
)
if /i "%~1"=="--asar" (
    set "rom_file=%project_dir%\%~2"
    goto :RunAsar
)
goto :ParseArgs

:RunEditor
start "" /b "%file%"
goto :Exit

:Backup
:: Export MWL level files
if not exist %levels_dir%\%time_stamp% (
    mkdir %levels_dir%\%time_stamp%
)
start "Lunar Magic" /i /wait "%lm_exe%" -ExportMultLevels %rom_file% %levels_dir%\%time_stamp%\level
start "Lunar Magic" /i /wait "%lm_exe%" -ExportMultLevels %rom_file% %levels_dir%\level
:: Export Map16
if not exist %map16_dir% (
    mkdir %map16_dir%
)
start "Lunar Magic" /i /wait "%lm_exe%" -ExportAllMap16 %rom_file% %backup_dir%\latest_AllMap16.map16
start "Lunar Magic" /i /wait "%lm_exe%" -ExportAllMap16 %rom_file% %map16_dir%\%time_stamp%_AllMap16.map16
:: Export Palettes
if not exist %palette_dir% (
    mkdir %palette_dir%
)
start "Lunar Magic" /i /wait "%lm_exe%" -ExportSharedPalette %rom_file% %backup_dir%\latest_Shared.pal
start "Lunar Magic" /i /wait "%lm_exe%" -ExportSharedPalette %rom_file% %palette_dir%\%time_stamp%_Shared.pal
:: Create time-stamped backup of your ROM
if not exist %rom_dir% (
    mkdir %rom_dir%
)
copy %rom_file% %rom_dir%\%time_stamp%_!rom_name!.smc
copy %rom_file% %backup_dir%\latest_!rom_name!.smc
goto :Exit

:OpenDir
start "" /b "%path%"
goto :Exit

:RunTool
start "%exe%" /b /d %path% /i /wait %exe% %param% %rom_file%
echo Reload your ROM in Lunar Magic to see changes and before making more.
pause
exit

:RunAsar
echo Applying patches with Asar...
pushd %asar_path%
for /f "tokens=*" %%a in ('findstr /v "^;" "%asar_list%"') do (
    %asar_exe% -v "%%a" %rom_file%
)
popd
echo Done
pause
exit

:OpenApp
start "" /i /wait "%path%\%app%" %param%
goto :Exit

:Exit
exit
