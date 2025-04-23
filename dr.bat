::::::::::::::::::::::::::::::::::::::::::::::::::
:: DEPENDENCY RESOLVER
::::::::::::::::::::::::::::::::::::::::::::::::::
:: It's a simple script to download plugins from mvnrepository.com
:: USAGE: dr.bat [options]
:: [options]:
::     -gid    Specifies groupID of the package/plugin.
::     -aid    Specifies artifactID of the package/plugin.
::     -v      Specifies version of the package/plugin.
::
:: [Example]: dr.bat -gid org.projectlombok -aid lombok -v 1.18.38
:: [Dependency]: This script assumes that you have curl (which is provided on windows10 and 11)
::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
SETLOCAL enableDelayedExpansion

set OUTPUT_DIR=libs

set GROUP_ID=
set ARTIFACT_ID=
set VERSION=

if not exist %OUTPUT_DIR% (mkdir %OUTPUT_DIR% 2> nul)

:: dr.bat -gid org.projectlombok -aid lombok -v 1.18.38
:: Simulate While Loop
:parse_args
if "%1"=="" goto after_parse
set "key=%~1"
shift
set "val=%~1"

if "%key%"=="-gid" set "GROUP_ID=%val%"
if "%key%"=="-aid" set "ARTIFACT_ID=%val%"
if "%key%"=="-v" set "VERSION=%val%"

shift
goto parse_args

:after_parse
if "%GROUP_ID%"=="" (echo ERROR: GroupID is missing! & set err=1)
if "%ARTIFACT_ID%"=="" (echo ERROR: ArtifactID is missing! & set err=1)
if "%VERSION%"=="" (echo ERROR: Version is missing! & set err=1)
if defined (err exit /b) 1 else (echo %GROUP_ID%, %ARTIFACT_ID%, %VERSION%)

:: Build the URL to fetch
:: https://repo1.maven.org/maven2/org/projectlombok/lombok/1.18.38/lombok-1.18.38.jar
set "URL=https://repo1.maven.org/maven2/%GROUP_ID:.=/%/%ARTIFACT_ID%/%VERSION%/%ARTIFACT_ID%-%VERSION%.jar"
echo URL: %URL%

:: Execute CURL
curl %URL% -o %ARTIFACT_ID%-%VERSION%.jar

ENDLOCAL
