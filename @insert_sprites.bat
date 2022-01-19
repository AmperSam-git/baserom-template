@echo off

call "@baserom_filename.bat"

set LISTFILE="common\list_pixi.txt"

cd .\common\
.\pixi.exe -l %LISTFILE% "..\%ROMFILE%.smc"
pause