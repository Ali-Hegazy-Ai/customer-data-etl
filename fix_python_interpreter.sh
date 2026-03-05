#!/bin/bash
# Customer Data ETL - Comprehensive Python Interpreter Fix
# This script helps fix common VS Code Python interpreter errors

set -e

echo ""
echo "=========================================="
echo "Customer Data ETL - Python Interpreter Fix"
echo "=========================================="
echo ""

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_ROOT"

echo "[*] Project root: $PROJECT_ROOT"
echo ""

# Check if venv exists
if [ -d "venv" ]; then
    echo "[✓] Virtual environment found at: $PROJECT_ROOT/venv"
    PYTHON_PATH="$PROJECT_ROOT/venv/bin/python"
    
    if [ -f "$PYTHON_PATH" ]; then
        echo "[✓] Python executable found at: $PYTHON_PATH"
        $PYTHON_PATH --version
    else
        echo "[ERROR] Python executable not found at: $PYTHON_PATH"
        echo "[*] Creating virtual environment..."
        python3 -m venv venv
        echo "[✓] Virtual environment created"
    fi
else
    echo "[WARNING] Virtual environment not found"
    echo "[*] Creating virtual environment..."
    python3 -m venv venv
    echo "[✓] Virtual environment created"
    PYTHON_PATH="$PROJECT_ROOT/venv/bin/python"
fi

echo ""

# Install/upgrade dependencies
echo "[*] Installing/upgrading dependencies..."
$PYTHON_PATH -m pip install --upgrade pip setuptools wheel
$PYTHON_PATH -m pip install -e ".[dev]"
echo "[✓] Dependencies installed"

echo ""

# Create VS Code settings if not exists
if [ ! -d ".vscode" ]; then
    echo "[*] Creating .vscode directory..."
    mkdir -p .vscode
fi

echo "[✓] .vscode directory exists"

echo ""
echo "=========================================="
echo "Interpreter Configuration"
echo "=========================================="
echo ""

# Show Python interpreter path
echo "Python interpreter path:"
echo "  $PYTHON_PATH"
echo ""

# Verify it works
echo "[*] Testing Python interpreter..."
$PYTHON_PATH --version
echo "[✓] Python interpreter works"

echo ""

# Show VS Code configuration
echo "VS Code Configuration (.vscode/settings.json):"
echo ""
echo 'Add this line to your .vscode/settings.json if not already present:'
echo '  "python.defaultInterpreterPath": "'$PYTHON_PATH'"'
echo ""

# Show how to reload VS Code
echo "To apply changes in VS Code:"
echo "  1. Close all Python files in VS Code"
echo "  2. Reload the window (Ctrl+R on Windows/Linux, Cmd+Shift+P then 'Reload Window' on macOS)"
echo "  3. Or: Go to View > Command Palette > Python: Select Interpreter"
echo "  4. Choose the interpreter at: $PROJECT_PYTHON_PATH/venv/bin/python"
echo ""

# Optional: Test importing packages
echo "[*] Testing required packages..."
$PYTHON_PATH -c "import pandas; print(f'  pandas: {pandas.__version__}') " || echo "  [WARNING] pandas not found"
$PYTHON_PATH -c "import typer; print(f'  typer: {typer.__version__}')" || echo "  [WARNING] typer not found"
$PYTHON_PATH -c "import pytest; print(f'  pytest: {pytest.__version__}')" || echo "  [WARNING] pytest not found"

echo ""
echo "=========================================="
echo "✓ Fix Complete!"
echo "=========================================="
echo ""
echo "Common solutions for VS Code errors:"
echo ""
echo "1. Python extension issues:"
echo "   - Reload VS Code window"
echo "   - Re-select the interpreter"
echo ""
echo "2. Module not found errors:"
echo "   - Make sure venv is activated in terminal"
echo "   - Reinstall dependencies: pip install -e '.[dev]'"
echo ""
echo "3. Wrong interpreter path:"
echo "   - Open Command Palette (Ctrl+Shift+P)"
echo "   - Type: 'Python: Select Interpreter'"
echo "   - Choose the venv option"
echo ""
echo "4. VS Code can't find venv:"
echo "   - Check that .vscode/settings.json has the correct path"
echo "   - Restart VS Code completely"
echo ""
