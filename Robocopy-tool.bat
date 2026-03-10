@echo off
setlocal enabledelayedexpansion

:: 1. Ask for the source file path (User can drag and drop or type with/without quotes)
set /p "raw_source=Drag and drop the FILE here and press Enter: "

:: 2. Ask for the destination folder path
set /p "raw_dest=Drag and drop the DESTINATION FOLDER here and press Enter: "

:: 3. Clean the quotes (Strip all " from the input)
set "source=!raw_source:"=!"
set "dest=!raw_dest:"=!"

:: 4. Extract filename and directory (Required for Robocopy logic)
for %%F in ("!source!") do (
    set "fileName=%%~nxF"
    set "sourceDir=%%~dpF"
)

echo.
echo ------------------------------------------
echo Processing: !fileName!
echo Destination: !dest!
echo ------------------------------------------

:: 5. Execute Robocopy with Progress bar
:: /njh /njs hides the bulky headers/summaries to keep it clean
robocopy "!sourceDir! " "!dest! " "!fileName!" /v /eta /z /njh /njs

echo.
if %errorlevel% leq 4 (
    echo [SUCCESS] File copied.
) else (
    echo [ERROR] Copy failed. Code: %errorlevel%
)

pause
