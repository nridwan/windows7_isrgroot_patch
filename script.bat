@echo off
REM change call with whatever admin command you want to execute
call certutil.exe -f -addstore root isrgrootx1.pem
if  errorlevel 1 goto ERROR
echo SUCCESSFUL
goto EOF 

:ERROR
echo Right click, choose "Run as Admin" to properly execute this script
echo press any key to continue...
pause >nul
exit /b 1

:EOF 
echo press any key to continue...
pause >nul