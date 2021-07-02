@echo off

set ROMFILE="..\MyBaseROM.smc"

cd .\common\
.\gps.exe -l "list_gps.txt" %ROMFILE%
pause