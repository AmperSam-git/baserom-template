@echo off

call "@baserom_filename.bat"

cd .\AddmusicK_1.0.8\
.\AddmusicK.exe "..\%ROMFILE%.smc"
pause