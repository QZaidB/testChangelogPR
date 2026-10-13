@echo off
setlocal
set /p PR=PR number (leave empty if you don't have one yet):
echo.
echo What kind of change is this?
echo   1 = added       new feature or block
echo   2 = changed     existing behaviour works differently
echo   3 = deprecated  still works, will be removed later
echo   4 = removed     feature or block removed
echo   5 = fixed       bug fix
echo   6 = security    security-related fix
choice /c 123456 /n /m "Choose 1-6: "
set TYPES=added changed deprecated removed fixed security
for /f "tokens=%errorlevel%" %%t in ("%TYPES%") do set TYPE=%%t
echo.
set /p DESC=Describe the change in one sentence:
if "%PR%"=="" (set NAME=+%RANDOM%) else (set NAME=%PR%)
> "%~dp0changelog.d\%NAME%.%TYPE%.md" echo %DESC%
echo.
echo Created changelog.d\%NAME%.%TYPE%.md
echo Commit this file together with your changes.
pause
