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

:: Build ClassPath
for /f %%i in ('dir /b %LIBS_DIR%\*.jar') do (
    set "CP=!CP!;libs\%%i"
)

echo classPath: !CP!
:: PRECOMPILATION preparation

:: Clean previous source list
::del sources.txt 2>nul

(for /R src\ %%f in (*.java) do @echo %%f) > inputs.txt

(for /R samples\ %%f in (*.java) do @echo %%f) > inputs_sample.txt

:: COMPILATION CloudSimPlus
echo COMPILE: CloudSimPlus Started!
javac -Xlint:none -cp "%CP%;%OUTPUT_PATH%" -d %OUTPUT_PATH% --processor-path "%PREPROC_PATH%" @inputs.txt

if %ERRORLEVEL% neq 0 (
   echo Compilation: CloudSimPlus Failed!
)
echo COMPILE: CloudSimPlus Completed!

:: COMPILATION CloudSimPlus-Examples
echo COMPILE: CloudSimPlus-Examples Started!
javac -cp "%CP%;%OUTPUT_PATH%" -d %SAMPLE_OUT% @inputs_sample.txt

if %ERRORLEVEL% neq 0 (
   echo Compilation: CloudSimPlus-Examples Failed!
)
echo COMPILE: CloudSimPlus-Examples Completed!


:: Run BasicFirstExample.java (Provide FQCN of BasicFirstExample.java)
echo "RUN_SIMULATION: org.cloudsimplus.example.BasicFirstExample
java -cp "%CP%;%OUTPUT_PATH%;%SAMPLE_OUT%" org.cloudsimplus.examples.BasicFirstExample
ENDLOCAL
