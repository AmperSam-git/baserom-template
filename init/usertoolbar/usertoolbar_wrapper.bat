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
    set "romfile=%project_dir%\%~5"
    goto :RunTool
)
if /i "%~1"=="--asar" (
    set "romfile=%project_dir%\%~2"
    goto :RunAsar
)
goto :ParseArgs

:RunEditor
start "" /b "%file%"
goto :Exit

:OpenDir
start "" /b "%path%"
goto :Exit

:RunTool
start "%exe%" /b /d %path% /i /wait %exe% %param% %romfile%
echo Reload your ROM in Lunar Magic to see changes and before making more.
pause
exit

:RunAsar
echo Applying patches with Asar...
pushd %asar_path%
for /f "tokens=*" %%a in ('findstr /v "^;" "%asar_list%"') do (
    %asar_exe% -v "%%a" %romfile%
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
