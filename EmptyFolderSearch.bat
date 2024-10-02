@echo off
setlocal

:: If a folder is passed as an argument, use it. Otherwise, use the current directory.
if "%~1"=="" (
    set "search_folder=%cd%"
) else (
    set "search_folder=%~1"
)

:: Create or overwrite the output file in the current directory
echo. > "%cd%\empty.txt"

:: Loop through all directories and check if they are empty
for /r "%search_folder%" %%d in (.) do (
    2>nul (
        dir /b /a "%%d" | findstr "^" >nul
    ) || echo %%d >> "%cd%\empty.txt"
)

echo Done! Empty folders are listed in empty.txt in the current directory.
endlocal
pause
