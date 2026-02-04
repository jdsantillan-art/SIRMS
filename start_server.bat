@echo off
cd /d "%~dp0"
echo ========================================
echo   SIRMS Django Development Server
echo ========================================
echo.

REM Check if we're in the right directory
if exist "sirms\manage.py" (
    echo Found manage.py in sirms directory
    cd sirms
) else if exist "manage.py" (
    echo Found manage.py in current directory
    REM Already in sirms directory
) else (
    echo ERROR: Cannot find manage.py
    echo Please make sure this file is in the project root or sirms directory
    pause
    exit /b 1
)

echo.
echo Checking Python installation...
python --version
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    pause
    exit /b 1
)

echo.
echo Checking Django installation...
python -c "import django; print('Django version:', django.get_version())" 2>nul
if errorlevel 1 (
    echo ERROR: Django is not installed
    echo Please run: pip install django
    pause
    exit /b 1
)

echo.
echo Checking database...
python manage.py check --database default 2>nul
if errorlevel 1 (
    echo WARNING: Database check failed, but continuing...
    echo.
)

echo.
echo ========================================
echo   Starting Django Development Server
echo ========================================
echo.
echo Server will be available at: http://127.0.0.1:8000/
echo.
echo Press Ctrl+C to stop the server
echo.
echo ========================================
echo.

REM Run server and capture any errors
python manage.py runserver 127.0.0.1:8000
if errorlevel 1 (
    echo.
    echo ========================================
    echo   ERROR: Server failed to start
    echo ========================================
    echo.
    echo Common fixes:
    echo 1. Run migrations: python manage.py migrate
    echo 2. Install dependencies: pip install -r requirements.txt
    echo 3. Check for port conflicts: netstat -ano ^| findstr :8000
    echo.
)

echo.
echo.
echo Server stopped.
pause

