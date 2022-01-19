@echo off

call "@baserom_filename.bat"

cd .\common\
.\gps.exe -l "list_gps.txt" "..\%ROMFILE%.smc"
pause