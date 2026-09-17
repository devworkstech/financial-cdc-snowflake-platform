@echo off
setlocal
echo ===================================================
echo  Financial CDC & Modern Data Stack Platform
echo ===================================================
git init
git branch -M main
git add .
git commit -m "feat: Financial CDC & Modern Data Stack Platform - Debezium, Kafka, Snowflake, dbt Core, Great Expectations"
set /p GH_USER="Enter GitHub username (or press enter for soniablake): "
if "%GH_USER%"=="" set GH_USER=soniablake
git remote remove origin 2>nul
git remote add origin https://github.com/%GH_USER%/financial-cdc-snowflake-platform.git
git push -u origin main
pause
