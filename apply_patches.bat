@echo off

set ROMFILE="..\[BaseRom File Name].smc"

cd .\common\
for /f "tokens=*" %%a in (list_asar.txt) do (
	.\asar.exe -v asar\%%a %ROMFILE%
)
pause