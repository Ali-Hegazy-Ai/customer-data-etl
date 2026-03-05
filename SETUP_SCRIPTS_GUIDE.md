# Setup Scripts Guide

Quick reference for running the project setup on different operating systems.

## ✅ Your System (Linux/macOS)

### Option 1: Automated Script (Recommended)
```bash
bash fix_python_interpreter.sh
```

**What it does:**
- Creates a Python virtual environment if missing
- Installs all dependencies
- Creates `.vscode/settings.json` with correct interpreter path
- Tests that critical packages (pandas, typer, pytest) are importable
- Provides troubleshooting tips for common issues

**After running:**
1. Reload your VS Code window (`Cmd+Shift+P` → "Reload Window")
2. Open any `.py` file and verify Python 3.10+ is selected in the status bar

### Option 2: Manual Setup
```bash
python3.10 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

---

## 🪟 Windows Team Members

### Option 1: PowerShell (Modern, Recommended)
**Requires:** Windows 7 SP1 or later, Python 3.10+, Docker Desktop

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\setup_windows.ps1
```

**Features:**
- ✓ Colored output (Green/Yellow/Red messages)
- ✓ Execution policy guidance
- ✓ Better error messages
- ✓ Try-Catch exception handling

### Option 2: Command Prompt (Legacy)
**Requires:** Python 3.10+, Docker Desktop (optional but recommended)

```cmd
setup_windows.bat
```

**Features:**
- ✓ Works on legacy Windows systems
- ✓ Error level checking
- ✓ Simpler, straightforward prompts

---

## Common Issues & Fixes

### ❌ "venv/bin/python: No such file or directory" (VS Code)
**Solution:**
```bash
# Linux/macOS
bash fix_python_interpreter.sh

# Then reload VS Code (Cmd+Shift+P → "Reload Window")
```

### ❌ "python.exe is not recognized" (Windows)
**Solution:**
- Ensure Python is installed: `python --version`
- If not, install from [python.org](https://www.python.org/downloads/)
- Then run: `setup_windows.ps1` or `setup_windows.bat`

### ❌ "Docker is not installed" 
**Note:** Docker is optional for local development. You can:
- Install Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop)
- OR run CLI commands directly: `python -m etl_cli --help`

### ❌ "Permission denied" (Linux/macOS)
```bash
chmod +x fix_python_interpreter.sh
bash fix_python_interpreter.sh
```

### ❌ "pip: command not found"
Ensure Python 3.10+ is installed and in your PATH:
```bash
python3.10 --version
python3.10 -m pip --version
```

---

## Verification Checklist

After running setup scripts, verify everything works:

### 1. Check Python & Virtual Environment
```bash
# Should show path to venv/bin/python (or Scripts\python.exe on Windows)
which python  # or: where python  (Windows)

# Should show Python 3.10 or higher
python --version
```

### 2. Check Dependencies
```bash
python -c "import pandas; import typer; import pytest; print('✓ All packages installed')"
```

### 3. Check Docker (Optional)
```bash
docker --version
docker-compose --version
```

### 4. Test CLI
```bash
python -m etl_cli --help
```

---

## VS Code Setup (All Platforms)

After running the setup script, VS Code should automatically recognize the Python interpreter from `.vscode/settings.json`.

**If not:**
1. Open Command Palette: `Cmd+Shift+P` (macOS) / `Ctrl+Shift+P` (Windows/Linux)
2. Type: "Python: Select Interpreter"
3. Choose the one with path: `./venv/bin/python` or `.\venv\Scripts\python.exe`
4. Click "Reload Window" to apply changes

**Verify:**
- Status bar at bottom should show: `Python [version] ./venv/bin/python` ✓
- Debug and test configurations should be available in Run menu

---

## Docker Setup (Optional)

If Docker is installed, you can use containers for development:

```bash
# Build and start containers
docker-compose up -d

# Inside container, run CLI
docker-compose exec app python -m etl_cli --help

# Stop containers
docker-compose down
```

---

## Team Workflow

**For new team members:**
1. Clone the repository
2. `cd customer-data-etl`
3. Run appropriate setup script for their OS
4. Read [ONBOARDING.md](./ONBOARDING.md) for project structure
5. Run tests to verify everything: `pytest -v`

**For existing developers:**
1. Pull latest changes: `git pull origin main`
2. Update dependencies: `pip install -r requirements.txt`
3. Run tests: `pytest -v`

---

## Questions?

- See [SETUP_GUIDE.md](./SETUP_GUIDE.md) for detailed Docker/Python setup
- See [ONBOARDING.md](./ONBOARDING.md) for project structure and best practices
- See [README.md](./README.md) for project overview
