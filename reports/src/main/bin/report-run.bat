@echo off

echo.
echo ##
echo ## Copyright 2004-2006 Auster Solutions do Brasil
echo ##
echo ##  --- BillCheckout Tool v3.1.x ---
echo ##  --- Reporting    Tool v3.0.x ---
echo ##
echo.


if "%ANT_HOME%"=="" goto noAntHome
if not exist "%ANT_HOME%\lib\ant.jar" goto noAntHome

if "%JAVA_HOME%"=="" goto noJavaHome
if not exist "%JAVA_HOME%\bin\java.exe" goto noJavaHome

goto setEnvironment


:noAntHome
echo ANT_HOME is set incorrectly or Ant could not be located. Please set ANT_HOME.
SET RCODE=-1
goto end

:noJavaHome
echo JAVA_HOME is set incorrectly or java could not be located. Please set JAVA_HOME.
SET RCODE=-2
goto end


:setEnvironment
set CMDLINE_HOME=%cd%\..

echo. 
echo Starting Billcheckout ReportManager
echo.
echo.

%ANT_HOME%/bin/ant.bat -Dbasedir=%CMDLINE_HOME% -Dcmdline.args="%*" -f report-run.xml
SET RCODE = %ERRORLEVEL%

echo.
echo [ Finished ]
echo.

:end
exit /B %RCODE% 