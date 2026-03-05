# Customer Data ETL - Windows Setup Script (PowerShell)
# This script sets up the project on Windows using PowerShell

Write-Host ""
Write-Host "=========================================="
Write-Host "Customer Data ETL - Windows Setup" -ForegroundColor Cyan
Write-Host "=========================================="
Write-Host ""

# Check execution policy
$executionPolicy = Get-ExecutionPolicy
if ($executionPolicy -eq "Restricted") {
    Write-Host "[!] PowerShell execution policy is Restricted" -ForegroundColor Yellow
    Write-Host "   To run this script, execute:" -ForegroundColor Yellow
    Write-Host "   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to continue or Ctrl+C to exit"
}

# Check if Python is installed
Write-Host "[*] Checking Python installation..."
try {
    $pythonVersion = python --version 2>&1
    Write-Host "[✓] Python is installed: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Python not found!" -ForegroundColor Red
    Write-Host "Please install Python 3.10+ from https://www.python.org/downloads/" -ForegroundColor Yellow
    Write-Host "Make sure to check 'Add Python to PATH' during installation." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if Docker is installed
Write-Host "[*] Checking Docker installation..."
try {
    $dockerVersion = docker --version 2>&1
    Write-Host "[✓] Docker is installed: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "[WARNING] Docker not found (optional)" -ForegroundColor Yellow
    Write-Host "Docker Desktop is recommended: https://docs.docker.com/get-docker/" -ForegroundColor Yellow
}

# Check if Git is installed
Write-Host "[*] Checking Git installation..."
try {
    $gitVersion = git --version 2>&1
    Write-Host "[✓] Git is installed: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Git not found!" -ForegroundColor Red
    Write-Host "Please install Git from https://git-scm.com/download/win" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""

# Create .env from template
if (-not (Test-Path ".env")) {
    if (Test-Path ".env.template") {
        Write-Host "[*] Creating .env from template..." -ForegroundColor Cyan
        Copy-Item ".env.template" ".env"
        Write-Host "[✓] Created .env" -ForegroundColor Green
        Write-Host "[!] Please edit .env with your database credentials if needed." -ForegroundColor Yellow
    } else {
        Write-Host "[ERROR] .env.template not found" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
} else {
    Write-Host "[✓] .env already exists" -ForegroundColor Green
}

Write-Host ""

# Option: Create virtual environment
Write-Host "Do you want to create a local Python virtual environment?"
Write-Host "This is only needed if you want to run Python code directly on Windows."
Write-Host "If using Docker, you don't need this."
Write-Host ""

$venvChoice = Read-Host "Create virtual environment? (y/n)"

if ($venvChoice -eq "y" -or $venvChoice -eq "Y") {
    Write-Host "[*] Creating virtual environment..." -ForegroundColor Cyan
    python -m venv venv
    
    Write-Host "[*] Activating virtual environment..." -ForegroundColor Cyan
    & ".\venv\Scripts\Activate.ps1"
    
    Write-Host "[*] Upgrading pip..." -ForegroundColor Cyan
    python -m pip install --upgrade pip setuptools wheel
    
    Write-Host "[*] Installing dependencies..." -ForegroundColor Cyan
    pip install -e ".[dev]"
    
    Write-Host "[✓] Virtual environment created and dependencies installed" -ForegroundColor Green
    Write-Host ""
    Write-Host "To activate the environment later, run:" -ForegroundColor Cyan
    Write-Host "  .\venv\Scripts\Activate.ps1" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host "[INFO] Skipping virtual environment setup" -ForegroundColor Yellow
    Write-Host "[INFO] You can set it up later with: python -m venv venv" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=========================================="
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "=========================================="
Write-Host ""

Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Using Docker (Recommended):" -ForegroundColor Yellow
Write-Host "   docker compose build" -ForegroundColor White
Write-Host "   docker compose run --rm etl bash" -ForegroundColor White
Write-Host ""

Write-Host "2. Using local Python (if venv created):" -ForegroundColor Yellow
Write-Host "   .\venv\Scripts\Activate.ps1" -ForegroundColor White
Write-Host "   python -m etl_cli check-env" -ForegroundColor White
Write-Host "   python -m etl_cli generate-mock-data --rows 50 --seed 42" -ForegroundColor White
Write-Host "   pytest" -ForegroundColor White
Write-Host ""

Write-Host "3. Read the documentation:" -ForegroundColor Yellow
Write-Host "   - README.md - Project overview (English & Arabic)" -ForegroundColor White
Write-Host "   - ONBOARDING.md - Beginner-friendly guide" -ForegroundColor White
Write-Host "   - SETUP_GUIDE.md - Detailed setup instructions" -ForegroundColor White
Write-Host "   - CONTRIBUTING.md - Code standards" -ForegroundColor White
Write-Host ""

Write-Host "4. For more help:" -ForegroundColor Yellow
Write-Host "   python -m etl_cli --help" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to exit"
