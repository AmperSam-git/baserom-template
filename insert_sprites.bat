@echo off

set ROMFILE="..\[BaseRom File Name].smc"
set LISTFILE="common\list_pixi.txt"

cd .\common\
.\pixi.exe -l %LISTFILE% %ROMFILE%
pause