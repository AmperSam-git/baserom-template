@echo off

set ROMFILE="..\MyBaseROM.smc"

cd .\common\
for /f "tokens=*" %%a in (list_asar.txt) do (
	.\asar.exe -v asar\%%a %ROMFILE%
)
pause