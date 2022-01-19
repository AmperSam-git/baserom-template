@echo off

call "@baserom_filename.bat"

cd .\common\
for /f "tokens=*" %%a in (list_asar.txt) do (
	.\asar.exe -v asar\%%a "..\%ROMFILE%.smc"
)
pause