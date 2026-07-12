@echo off
setlocal

set TOMCAT_LIB=D:\Software\apache-tomcat-10.1.55-windows-x64\apache-tomcat-10.1.55\lib
set SRC=D:\Software\Workspace\food_app\src\main\java
set OUT=D:\Software\Workspace\food_app\build\classes
set PG_JAR=D:\Software\Workspace\food_app\src\main\webapp\WEB-INF\lib\postgresql-42.7.3.jar
set SOURCES=D:\Software\Workspace\food_app\sources_build.txt

rem collect all java files
dir /s /b "%SRC%\*.java" > "%SOURCES%"

rem compile
javac -d "%OUT%" -cp "%TOMCAT_LIB%\servlet-api.jar;%TOMCAT_LIB%\jsp-api.jar;%PG_JAR%" @"%SOURCES%"

if %ERRORLEVEL% == 0 (
    echo ============================
    echo   BUILD SUCCESS
    echo ============================
) else (
    echo ============================
    echo   BUILD FAILED
    echo ============================
    exit /b 1
)
