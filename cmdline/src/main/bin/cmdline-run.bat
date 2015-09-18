@echo off

echo.
echo ##
echo ## Copyright 2004-2005 Auster Solutions do Brasil
echo ##
echo ##  --- BillCheckout Tool v3.1.x ---
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
echo Starting Billcheckout CommandLine Client
echo.
echo NOTE: When using file masks under Windows MS-DOS Prompt, you need to use '\"<mask>\"' to work properly.
echo.
echo.

echo CommandLine Home is set to: %CMDLINE_HOME%
echo Java Version is:
%JAVA_HOME%/bin/java -version

"%ANT_HOME%"/bin/ant.bat -Dbasedir="%CMDLINE_HOME%" -Dcmdline.args="-o asbck,aspva %*" -f cmdline-run.xml
ECHO errorlevel: %errorlevel%
SET RCODE = %ERRORLEVEL%

echo.
echo [ Finished With result code = %RCODE%]
echo.

:end
exit /B %RCODE% 