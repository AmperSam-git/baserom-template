@echo off

setlocal
for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set DateTime=%%a

set Year=%DateTime:~0,4%
set Month=%DateTime:~4,2%
set Day=%DateTime:~6,2%
set Hour=%DateTime:~8,2%
set Minute=%DateTime:~10,2%

set TIMESTAMP="%Year%%Month%%Day%"

set ROMFILE="[BaseRom File Name].smc"

mkdir "Levels\%TIMESTAMP%"

".\common\lm321.exe" -ExportMultLevels "%ROMFILE%" "Levels\%TIMESTAMP%\level" 

pause