@echo off
cls

:: Working Directory
setlocal DisableDelayedExpansion
set WORKING_DIR=%~dp0
set WORKING_DIR=%WORKING_DIR:!=^^!%
setlocal EnableDelayedExpansion

:: Get root directory since this script runs from the LM folder
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

::
:: TOOLS DEFINES
::

:: AddMusicK
set "amk_path=!tools_dir!addmusick\"
set "amk_list=!amk_path!Addmusic_list.txt"
set "amk_exe=AddmusicK.exe"
:: PIXI
set "pixi_path=!tools_dir!pixi\"
set "pixi_list=!pixi_path!list.txt"
set "pixi_exe=pixi.exe"
:: GPS
set "gps_path=!tools_dir!gps\"
set "gps_list=!gps_path!list.txt"
set "gps_exe=gps.exe"
:: UberASM Tool
set "uber_path=!tools_dir!uberasmtool\"
set "uber_list=!uber_path!list.txt"
set "uber_exe=UberASMTool.exe"
:: Asar
set "asar_path=!tools_dir!asar\"
set "asar_list=!asar_path!list.txt"
set "asar_exe=asar.exe"
:: Lunar Magic
set "lm_path=!tools_dir!lunar_magic\"
set "lm_exe=!lm_path!Lunar Magic.exe"
set "lm_name=Lunar Magic"

::
:: MENU
::
:ParseArgs
if "%~1"=="" goto :EOF

:: Edit File
if /i "%~1"=="--file" (
    set file=%~2
    goto :RunEditor
)
:: Open Path
if /i "%~1"=="--path" (
    set path=%~2
    goto :OpenDir
)
:: Open App
if /i "%~1"=="--app" (
    set app_path=%~2
    set app_exe=%~3
    set app_param=%~4
    goto :OpenApp
)
:: Run Tool
if /i "%~1"=="--run-tool" (
    set tool_name=%~2
    set tool_path=%~3
    set tool_exe=%~4
    set tool_param=%~5
    set rom_file=%project_dir%%~6
    goto :RunTool
)
:: Run Backup
if /i "%~1"=="--back-up" (
    set rom_name=%~2
    set rom_file=%project_dir%%~2.smc
    goto :LMBackup
)
:: Run Assembler
if /i "%~1"=="--asar" (
    set rom_file=%project_dir%%~2
    goto :RunAsar
)
:: Back to start
goto :ParseArgs


::
:: OPEN DEFAULT TEXT EDITOR
::
:RunEditor
start "" /b "%file%"
goto :Exit

::
:: BACKUP VIA LUNAR MAGIC
::
:LMBackup
:: Export MWL level files
echo Exporting Levels...
:: check if level backup folder exists
if not exist "%levels_dir%\%time_stamp%" (
    mkdir "%levels_dir%\%time_stamp%"
)
start "%lm_name%" /b /i /wait "%lm_exe%" -ExportMultLevels "%rom_file%" "%levels_dir%\%time_stamp%\level"
start "%lm_name%" /b /i /wait "%lm_exe%" -ExportMultLevels "%rom_file%" "%levels_dir%\level"
:: Error handling
if %errorlevel% equ 0 (
    echo Levels backed up successfully
) else (
    echo Failed to export Levels.
)
:: Export Map16
echo Exporting All of Map16...
:: check if map16 backup folder exists
if not exist "%map16_dir%" (
    mkdir "%map16_dir%"
)
start "%lm_name%" /b /i /wait "%lm_exe%" -ExportAllMap16 "%rom_file%" "%backup_dir%\latest_AllMap16.map16"
start "%lm_name%" /b /i /wait "%lm_exe%" -ExportAllMap16 "%rom_file%" "%map16_dir%\%time_stamp%_AllMap16.map16"
:: Error handling
if %errorlevel% equ 0 (
    echo All Map16 backed up successfully
) else (
    echo Failed to export Map16.
)
:: Export Palettes
echo Backing up Shared palette...
if not exist "%palette_dir%" (
    mkdir "%palette_dir%"
)
start "%lm_name%" /b /i /wait "%lm_exe%" -ExportSharedPalette "%rom_file%" "%backup_dir%\latest_Shared.pal"
start "%lm_name%" /b /i /wait "%lm_exe%" -ExportSharedPalette "%rom_file%" "%palette_dir%\%time_stamp%_Shared.pal"
:: Error handling
if %errorlevel% equ 0 (
    echo Shared Palette Backed Up Successfully
) else (
    echo Failed to back-up Shared palette.
)
:: Create time-stamped backup of your ROM
echo Making time-stamped backup of project ROM...
:: check if ROM backup folder exists
if not exist "%rom_dir%" (
    mkdir "%rom_dir%"
)
copy "%rom_file%" "%rom_dir%\%time_stamp%_!rom_name!.smc"
copy "%rom_file%" "%backup_dir%\latest_!rom_name!.smc"
:: Error handling
if %errorlevel% equ 0 (
    echo ROM backed up successfully
) else (
    echo Failed to backup ROM.
)
:: Exit
goto :Exit

:: Open Directory
:OpenDir
start "" /b "%path%"
goto :Exit

::
:: RUN TOOL
::
:RunTool
:: go to tool directory
pushd %tool_path%
:: run the tool exe directly
echo Inserting resources with %tool_name%...
%tool_exe% "%tool_param%" "%rom_file%"
:: error handlings
if %errorlevel% equ 0 (
    echo %tool_name% ran successfully
    echo Reload your ROM in Lunar Magic to see changes.
) else (
    echo Failed to run %tool_name%
)
popd
goto :Exit

::
:: RUN ASAR
::
:RunAsar
set "tool_name=Asar"
echo Applying patches with %tool_name%...
pushd %asar_path%
:: Parse the list file
for /f "tokens=*" %%a in ('findstr /v "^;" "%asar_list%"') do (
    %asar_exe% -v "%%a" "%rom_file%"
)
:: error handling
if %errorlevel% equ 0 (
    echo %tool_name% ran successfully
) else (
    echo Failed to run %tool_name%
)
popd
goto :Exit

:: Open App
:OpenApp
start "" /b /i /wait "%app_path%\%app_exe%" %app_param%
goto :Exit

:Exit
pause
exit
