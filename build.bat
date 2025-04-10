@echo off

SETLOCAL enableDelayedExpansion

set COMPILER=javac
set EXEC=java

set SRC_PATH=src\main\java\
SET LIBS_DIR=libs\

set OUTPUT_PATH=out
set SAMPLE_OUT=out_samples

set PREPROC_PATH=libs\lombok-1.18.38.jar

set CP=

:: Create output directories if not exists already
if not exist %OUTPUT_PATH% (mkdir %OUTPUT_PATH% 2>nul)
if not exist %SAMPLE_OUT% (mkdir %SAMPLE_OUT% 2>nul)

:: Build ClassPath
for /f %%i in ('dir /b %LIBS_DIR%\*.jar') do (
    set "CP=!CP!;libs\%%i"
)

echo classPath: !CP!

:: Prepare Inputs for the Compiler
(for /R src\ %%f in (*.java) do @echo %%f) > inputs.txt

(for /R samples\ %%f in (*.java) do @echo %%f) > inputs_sample.txt

:: COMPILATION CloudSimPlus
:: you can add other options like -verbose or.. anything else.. explore javac --help --help-extra
echo COMPILE: CloudSimPlus Started!
%COMPILER% -Xlint:none -cp "%CP%;%OUTPUT_PATH%" -d %OUTPUT_PATH% --processor-path "%PREPROC_PATH%" @inputs.txt

if %ERRORLEVEL% neq 0 (
   echo Compilation: CloudSimPlus Failed!
   exit /b %ERRORLEVEL%
)
echo COMPILE: CloudSimPlus Completed!

:: COMPILATION CloudSimPlus-Examples
echo COMPILE: CloudSimPlus-Examples Started!
%COMPILER% -cp "%CP%;%OUTPUT_PATH%" -d %SAMPLE_OUT% @inputs_sample.txt

if %ERRORLEVEL% neq 0 (
   echo Compilation: CloudSimPlus-Examples Failed!
   exit /b %ERRORLEVEL%
)
echo COMPILE: CloudSimPlus-Examples Completed!


:: Run BasicFirstExample.java (Provide FQCN of BasicFirstExample.java)
echo "RUN_SIMULATION: org.cloudsimplus.example.BasicFirstExample
%EXEC% -cp "%CP%;%OUTPUT_PATH%;%SAMPLE_OUT%" org.cloudsimplus.examples.BasicFirstExample

ENDLOCAL
