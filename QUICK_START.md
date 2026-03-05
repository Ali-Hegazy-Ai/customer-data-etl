# 🚀 Quick Start Guide

Get up and running in **60 seconds**.

## One-Command Setup (Recommended)

```bash
# Linux / macOS
bash quick-start.sh

# Windows (PowerShell - recommended)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\setup_windows.ps1

# Windows (Command Prompt)
setup_windows.bat
```

That's it! The script will:
- ✅ Check Python installation
- ✅ Create virtual environment
- ✅ Install all dependencies
- ✅ Run tests to verify setup
- ✅ Test the CLI
- ✅ Show success confirmation

## Manual Setup (If needed)

### 1. Create Virtual Environment
```bash
python3.10 -m venv venv
source venv/bin/activate  # Linux/macOS
# or
.\venv\Scripts\activate   # Windows
```

### 2. Install Dependencies
```bash
pip install --upgrade pip
pip install -e .
```

### 3. Verify Installation
```bash
python -m pytest tests/ -v
python -m etl_cli --help
```

## First Commands

```bash
# Check environment
python -m etl_cli check-env

# Generate mock data
python -m etl_cli generate-mock-data --seed 42

# Run the pipeline
python -m etl_cli run-pipeline

# View all options
python -m etl_cli --help
```

## Using Docker (Optional)

```bash
# Build and start
docker compose up -d

# Run inside container
docker compose run --rm etl python -m etl_cli --help

# Stop
docker compose down
```

## Verify Everything Works

```bash
# Run full test suite
python -m pytest tests/ -v

# Check code quality
black --check src tests
flake8 src tests
isort --check-only src tests
```

## Project Structure

```
customer-data-etl/
├── src/etl_cli/              # Main application
│   ├── __main__.py           # CLI entry point
│   ├── check_env.py          # Environment checker
│   ├── generate_mock_data.py # Data generator
│   ├── pipeline.py           # ETL pipeline
│   └── setup.py              # Setup command
├── tests/                    # Test suite (24 tests)
├── docker/                   # Docker configuration
├── data/                     # Data directory (generated)
├── docs/                     # Documentation
└── pyproject.toml           # Project configuration
```

## Troubleshooting

### "python not found"
```bash
# Ensure Python 3.10+ is installed
python --version
# or
python3 --version
```

### "ModuleNotFoundError: No module named 'etl_cli'"
```bash
# Reinstall the project
pip install -e .
```

### "Tests are failing"
```bash
# Check environment
python -m etl_cli check-env

# Reinstall dependencies
pip install -e .
pip install -e ".[dev]"
```

### "VS Code not recognizing interpreter"
- Reload VS Code: `Cmd+Shift+P` → "Reload Window"
- Select interpreter: `Cmd+Shift+P` → "Python: Select Interpreter"
- Choose: `./venv/bin/python`

## Need Help?

- 📖 [README.md](./README.md) - Project overview
- 🛠️ [SETUP_GUIDE.md](./SETUP_GUIDE.md) - Detailed setup (Docker, etc.)
- 📚 [ONBOARDING.md](./ONBOARDING.md) - For team members
- 🤝 [CONTRIBUTING.md](./CONTRIBUTING.md) - Contribution guidelines

## What's Next?

1. **Explore the code** - Start in `src/etl_cli/__main__.py`
2. **Read the docs** - Check out ONBOARDING.md for architecture overview
3. **Modify & extend** - The pipeline is a skeleton ready for your logic
4. **Run tests** - Make sure your changes don't break anything
5. **Push to GitHub** - Automated CI/CD will run all checks

---

**Questions?** Check the documentation or create an issue on GitHub.
