@echo off

set ROMFILE="..\[BaseRom File Name].smc"

cd .\common\
.\gps.exe -l "list_gps.txt" %ROMFILE%
pause