@echo off

call "@baserom_filename.bat"

setlocal
for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set DateTime=%%a

set Year=%DateTime:~0,4%
set Month=%DateTime:~4,2%
set Day=%DateTime:~6,2%
set Hour=%DateTime:~8,2%
set Minute=%DateTime:~10,2%

set TIMESTAMP="%Year%%Month%%Day%_%Hour%%Minute%"

set LRP_FILE="sysLMRestore\%ROMFILE%.lrp"

move %LRP_FILE% "Backup\%TIMESTAMP%_%ROMFILE%.lrp"
copy "%ROMFILE%.smc" "Backup\%TIMESTAMP%_%ROMFILE%.smc"
copy "%ROMFILE%.smc" "Backup\latest_%ROMFILE%.smc"

call @export_levels.bat
call @export_map16.bat
call @export_palettes.bat

pause
goto :EOF