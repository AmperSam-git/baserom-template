@echo off

call "@baserom_filename.bat"

cd .\common\
.\flips.exe --create --bps ..\sysLMRestore\smwOrig.smc "..\%ROMFILE%.smc" "..\%ROMFILE%.bps"
pause