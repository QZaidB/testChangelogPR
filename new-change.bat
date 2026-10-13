@echo off
chcp 65001 >nul

:ask
set "URL=-"
set /p URL=Paste the PR link: 
set "PR=%URL:*/pull/=%"
if "%PR%"=="%URL%" echo Not a PR link, try again. & goto ask
for /f "delims=/#" %%n in ("%PR%") do set "PR=%%n"

echo 1=added 2=changed 3=deprecated 4=removed 5=fixed 6=security
choice /c 123456 /n /m "Type: "
for /f "tokens=%errorlevel%" %%t in ("added changed deprecated removed fixed security") do set TYPE=%%t

set /p DESC=One sentence: 
> "%~dp0changelog\%PR%.%TYPE%.md" echo %DESC%
echo Created changelog\%PR%.%TYPE%.md - commit it.
pause