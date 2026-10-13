@echo off
setlocal
chcp 65001 >nul

:askpr
set "URL="
set "PR="
set /p URL=Paste the PR link (e.g. https://github.com/org/repo/pull/123): 
if not defined URL goto badpr
set "REST=%URL:*/pull/=%"
if "%REST%"=="%URL%" goto badpr
for /f "delims=/#? " %%n in ("%REST%") do set "PR=%%n"
if not defined PR goto badpr
for /f "delims=0123456789" %%x in ("%PR%") do goto badpr
goto gotpr

:badpr
echo.
echo That is not a PR link. Open your PR on GitHub, copy the address
echo from the browser bar and paste it here. No PR yet? Create it first.
echo.
goto askpr

:gotpr
echo PR #%PR%
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
> "%~dp0changelog\%PR%.%TYPE%.md" echo %DESC%
echo.
echo Created changelog\%PR%.%TYPE%.md
echo Commit this file together with your changes.
pause