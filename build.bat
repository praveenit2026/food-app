@echo off
echo =========================================
echo Compiling and Deploying AntiGravity Food App
echo =========================================

REM Define Paths
set TOMCAT_HOME=d:\Software\apache-tomcat-10.1.55-windows-x64\apache-tomcat-10.1.55
set DEPLOY_DIR=%TOMCAT_HOME%\webapps\food_app
set SRC_DIR=d:\Software\Workspace\food_app
set CLASS_OUT=%SRC_DIR%\build\classes

REM Ensure output folders exist
if not exist "%CLASS_OUT%" mkdir "%CLASS_OUT%"
if not exist "%DEPLOY_DIR%" mkdir "%DEPLOY_DIR%"
if not exist "%DEPLOY_DIR%\WEB-INF\classes" mkdir "%DEPLOY_DIR%\WEB-INF\classes"

echo [1/4] Generating sources list...
dir /s /b "%SRC_DIR%\src\main\java\*.java" > "%SRC_DIR%\sources.txt"

echo [2/4] Compiling Java classes...
javac -d "%CLASS_OUT%" -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;%SRC_DIR%\src\main\webapp\WEB-INF\lib\mysql-connector-j-8.2.0.jar" @"%SRC_DIR%\sources.txt"

if %ERRORLEVEL% neq 0 (
    echo [ERROR] Compilation failed!
    exit /b %ERRORLEVEL%
)
echo [SUCCESS] Compilation complete.

echo [3/4] Copying web resources to deployment directory...
xcopy /s /e /y "%SRC_DIR%\src\main\webapp\*" "%DEPLOY_DIR%\"

echo [4/4] Copying compiled classes to WEB-INF/classes...
xcopy /s /e /y "%CLASS_OUT%\*" "%DEPLOY_DIR%\WEB-INF\classes\"

echo =========================================
echo Live Deployment Successful!
echo =========================================
