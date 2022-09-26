@echo off
pushd %~dp0
set script_dir=%CD%
popd
REM change call with whatever admin command you want to execute
call certutil.exe -f -addstore Root %script_dir%\isrgrootx1.crt
if errorlevel 0 goto EOF

:ERROR
echo Right click, choose "Run as Admin" to properly execute this script
echo press any key to continue...
pause >nul
exit /b 1

:EOF 
echo SUCCESSFUL
echo press any key to continue...
pause >nul