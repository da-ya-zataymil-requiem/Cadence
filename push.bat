@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

set "msg=%*"
if "%msg%"=="" set "msg=Update"

echo Staging changes...
git add -A

git diff --cached --quiet
if %errorlevel%==0 (
    echo Nothing to commit.
    goto :push
)

echo Committing: %msg%
git commit -m "%msg%"

:push
for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD') do set "branch=%%b"
echo Pushing branch "%branch%" to origin...
git push origin %branch%

echo.
echo Done.
pause
