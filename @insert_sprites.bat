@echo off

set ROMFILE="..\MyBaseROM.smc"
set LISTFILE="common\list_pixi.txt"

cd .\common\
.\pixi.exe -l %LISTFILE% %ROMFILE%
pause