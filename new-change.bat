@echo off
rem Adds a changelog entry: changelog\<PR>.<type>.md (numbered if it already exists)
setlocal EnableDelayedExpansion
rem UTF-8 so special characters (degrees, accents) are saved correctly
chcp 65001 >nul
pushd "%~dp0"

set "TYPES=added changed deprecated removed fixed security HMI"

call :ask_pr
call :ask_type
call :ask_description
call :next_free_name
call :write_entry
pause
exit /b


:ask_pr
set "URL=-"
set /p "URL=PR link: "
set "PR=!URL:*/pull/=!"
if "!PR!"=="!URL!" echo Not a PR link, try again. & goto ask_pr
for /f "delims=/#" %%n in ("!PR!") do set "PR=%%n"
exit /b

:ask_type
set /a i=0
set "KEYS="
for %%t in (%TYPES%) do (
    set /a i+=1
    set "TYPE_!i!=%%t"
    set "KEYS=!KEYS!!i!"
    echo   !i! = %%t
)
choice /c !KEYS! /n /m "Type: "
set "TYPE=!TYPE_%errorlevel%!"
exit /b

:ask_description
set "DESC="
set /p "DESC=One sentence: "
if not defined DESC goto ask_description
exit /b

rem Never overwrite: <PR>.<type>.md, then .1.md, .2.md, ...
:next_free_name
set "NAME=!PR!.!TYPE!.md"
set /a n=0
:next_free_name_loop
if exist "changelog\!NAME!" (
    set /a n+=1
    set "NAME=!PR!.!TYPE!.!n!.md"
    goto next_free_name_loop
)
exit /b

:write_entry
> "changelog\!NAME!" echo(!DESC!
echo Created changelog\!NAME! - commit it.
exit /b