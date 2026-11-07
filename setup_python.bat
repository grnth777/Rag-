@echo off
cd /d "%~dp0"
python -m venv .venv
if errorlevel 1 goto fail
".venv\Scripts\python.exe" -m pip install --upgrade pip
if errorlevel 1 goto fail
".venv\Scripts\python.exe" -m pip install -r requirements.txt
if errorlevel 1 goto fail
echo.
echo Python setup complete. Start the app with start_local.bat.
pause
exit /b 0
:fail
echo.
echo Setup failed. Check that Python 3.11 is installed and available as 'python'.
pause
exit /b 1
