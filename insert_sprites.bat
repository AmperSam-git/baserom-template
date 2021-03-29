@echo off

set ROMFILE="..\[BaseRom File Name].smc"
set LISTFILE="coomon\list_pixi.txt"

cd .\common\
.\pixi.exe -l %LISTFILE% %ROMFILE%
pause