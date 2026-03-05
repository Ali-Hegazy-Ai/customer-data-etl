#!/usr/bin/env bash
# Quick Start Script for Customer Data ETL
# Makes the project truly plug-and-play
# Automatically detects OS and sets up environment

set -e

echo "================================================"
echo "🚀 Customer Data ETL - Quick Start Setup"
echo "================================================"
echo ""

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "linux"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    OS="windows"
fi

echo "🔍 System: $OS"

# Check Python
echo ""
echo "📋 Checking prerequisites..."

if ! command -v python3 &> /dev/null; then
    echo "❌ Python not found. Please install Python 3.10+"
    exit 1
fi

PYTHON_VERSION=$(python3 --version | awk '{print $2}')
echo "✓ Python $PYTHON_VERSION detected"

# Create venv
echo ""
echo "🏗️  Setting up virtual environment..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "✓ Created virtual environment"
else
    echo "✓ Virtual environment already exists"
fi

# Activate venv
if [[ "$OS" == "windows" ]]; then
    source venv/Scripts/activate
else
    source venv/bin/activate
fi

# Upgrade pip
echo ""
echo "📦 Installing dependencies..."
pip install --upgrade pip setuptools wheel > /dev/null 2>&1
echo "✓ Updated pip, setuptools, wheel"

# Install project
pip install -e . > /dev/null 2>&1
echo "✓ Installed project and dependencies"

# Run tests
echo ""
echo "🧪 Running tests..."
if python -m pytest tests/ -q; then
    echo "✓ All 24 tests passed"
else
    echo "❌ Some tests failed. See above for details."
    exit 1
fi

# Verify CLI works
echo ""
echo "✅ Testing CLI..."
if python -m etl_cli --help > /dev/null 2>&1; then
    echo "✓ ETL CLI is functional"
else
    echo "❌ ETL CLI failed to load"
    exit 1
fi

# Success
echo ""
echo "================================================"
echo "✅ Setup Complete!"
echo "================================================"
echo ""
echo "🎉 Your project is ready to use!"
echo ""
echo "Next steps:"
echo "  1. Activate venv: source venv/bin/activate"
echo "  2. Check environment: python -m etl_cli check-env"
echo "  3. Generate mock data: python -m etl_cli generate-mock-data"
echo "  4. Run pipeline: python -m etl_cli run-pipeline"
echo ""
echo "Or use with Docker:"
echo "  docker compose up"
echo "  docker compose run --rm etl python -m etl_cli --help"
echo ""
echo "For more info, see: README.md | SETUP_GUIDE.md | ONBOARDING.md"
echo ""
