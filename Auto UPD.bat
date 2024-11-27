@echo off
set "GITHUB_URL=https://github.com/Bluethakeeper/ELM-DGS-autocodes/archive/refs/heads/main.zip"
set "OUTPUT_FILE=downloaded_file.zip"

:: Step 1: Delete all files in the current directory except the batch file itself
for %%f in (*.*) do (
    if not "%%f"=="%~nx0" del "%%f"
)

echo Starting the download this may take a minute...
powershell -Command ^
    $url = '%GITHUB_URL%'; ^
    $output = '%OUTPUT_FILE%'; ^
    $wc = New-Object System.Net.WebClient; ^
    $wc.DownloadFile($url, $output)

echo Unzipping the downloaded file...
powershell -Command ^
    Expand-Archive -Path "%OUTPUT_FILE%" -DestinationPath . -Force

del "%OUTPUT_FILE%"

:ask_question
set /p answer=Do you want to open the video tutorial? (Y/N): 

:: Check if the answer is valid (Y or N)
if /i "%answer%"=="Y" (
    start https://streamable.com/8mgvhd
) else if /i "%answer%"=="N" (
    echo okay.
) else (
    echo Invalid input. Please enter Y or N.
    pause
    goto ask_question
)

echo Download and extraction complete!
pause