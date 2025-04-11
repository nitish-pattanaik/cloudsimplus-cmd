@echo off
SETLOCAL enableDelayedExpansion

:: FQCN and all command args are provided to this script
:: e.g. run.bat org/cloudsimplus/examples/FirstTry.java
:: e.g. run.bat org\cloudsimplus\examples\FirstTry.java

:: SET Variables
:: Assumes: (you have JAVA_HOME configured!)
set COMPILER=javac
set EXEC=java
set LIBS_DIR=libs
set CSP_CLASSES=out
set SRC_PATH=samples
set OUTPUT_PATH=out_samples

set CP=
:: Build ClassPath from dependencies
for %%i in (%LIBS_DIR%\*.jar) do set "CP=!CP!;%%i"
:: print --classpath
echo %CP%

:: INPUT_FILE & FQCN
if "%1"=="" echo ERROR: First argument is required && exit /b 1
set INPUT_FILE=%1
set FQCN=%INPUT_FILE:\=.%
set FQCN=%FQCN:/=.%
set FQCN=%FQCN:.java=%
echo FQCN: %FQCN%

:: shift args (pop 1st argument)
shift

:: Compile The Example & Generate .class file
%COMPILER% -cp "%CP%;%CSP_CLASSES%"  -d %OUTPUT_PATH% -sourcepath %SRC_PATH% %SRC_PATH%\%INPUT_FILE%
if %ERRORLEVEL% neq 0 (
   echo ERROR: Compilation Failed! && exit /b %ERRORLEVEL%
) else (
  echo COMPILE: Successfully Compiled.
)

:: Run the corresponding .class file through FQCN
%EXEC% -cp "%CP%;%CSP_CLASSES%;%OUTPUT_PATH%" %FQCN%
if %ERRORLEVEL% neq 0 (
   echo ERROR: Failed to run %FQCN% && exit /b %ERRORLEVEL%
) else (
  echo RUN: Successfully Executed.
)

ENDLOCAL
