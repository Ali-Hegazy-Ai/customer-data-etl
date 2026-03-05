@echo off
REM Customer Data ETL - Windows Setup Script
REM This script sets up the project on Windows

echo.
echo ==========================================
echo Customer Data ETL - Windows Setup
echo ==========================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found. Please install Python 3.10+ from https://www.python.org/downloads/
    echo [ERROR] Make sure to check "Add Python to PATH" during installation.
    pause
    exit /b 1
)

echo [✓] Python is installed
python --version

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo [WARNING] Docker not found. Docker Desktop is recommended but not required for initial testing.
    echo [INFO] Download from: https://docs.docker.com/get-docker/
    echo.
) else (
    echo [✓] Docker is installed
    docker --version
)

REM Check if Git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Git not found. Please install Git from https://git-scm.com/download/win
    pause
    exit /b 1
)

echo [✓] Git is installed
git --version
echo.

REM Create .env from template
if not exist ".env" (
    if exist ".env.template" (
        echo [*] Creating .env from template...
        copy .env.template .env
        echo [✓] Created .env
        echo [!] Please edit .env with your database credentials if needed.
    ) else (
        echo [ERROR] .env.template not found
        pause
        exit /b 1
    )
) else (
    echo [✓] .env already exists
)

echo.

REM Option: Create virtual environment (optional for Windows)
echo.
echo Do you want to create a local Python virtual environment? (optional)
echo This is only needed if you want to run Python code directly on Windows.
echo If using Docker, you don't need this.
echo.
set /p venv_choice="Create virtual environment? (y/n): "

if /i "%venv_choice%"=="y" (
    echo [*] Creating virtual environment...
    python -m venv venv
    
    echo [*] Activating virtual environment...
    call venv\Scripts\activate.bat
    
    echo [*] Upgrading pip...
    python -m pip install --upgrade pip setuptools wheel
    
    echo [*] Installing dependencies...
    pip install -e ".[dev]"
    
    echo [✓] Virtual environment created and dependencies installed
    echo.
    echo To activate the environment later, run:
    echo   venv\Scripts\activate.bat
    echo.
) else (
    echo [INFO] Skipping virtual environment setup
    echo [INFO] You can set it up later with: python -m venv venv
)

echo.
echo ==========================================
echo Setup Complete!
echo ==========================================
echo.
echo Next steps:
echo.
echo 1. Using Docker (Recommended):
echo    docker compose build
echo    docker compose run --rm etl bash
echo.
echo 2. Using local Python (if venv created):
echo    venv\Scripts\activate.bat
echo    python -m etl_cli check-env
echo    python -m etl_cli generate-mock-data --rows 50 --seed 42
echo    pytest
echo.
echo 3. Read the documentation:
echo    - README.md - Project overview (English & Arabic)
echo    - ONBOARDING.md - Beginner-friendly guide
echo    - SETUP_GUIDE.md - Detailed setup instructions
echo    - CONTRIBUTING.md - Code standards
echo.
echo 4. For more help:
echo    python -m etl_cli --help
echo.
pause
