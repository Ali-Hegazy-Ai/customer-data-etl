# 🚀 Customer Data ETL

Extract, Transform, Load customer data from multiple sources into a Data Warehouse.

**Language**: Python + Docker | **Status**: Production-ready | **License**: MIT

---

## ⚡ Quick Start (60 seconds)

### Linux/macOS
```bash
git clone https://github.com/Ali-Hegazy-Ai/customer-data-etl.git
cd customer-data-etl
bash quick-start.sh
```

### Windows (PowerShell)
```powershell
git clone https://github.com/Ali-Hegazy-Ai/customer-data-etl.git
cd customer-data-etl
.\setup_windows.ps1
```

Done! Everything is set up.

---

## 📖 Usage

```bash
# Activate environment
source venv/bin/activate  # Linux/macOS
# or
.\venv\Scripts\activate   # Windows

# See all commands
python -m etl_cli --help

# Check environment
python -m etl_cli check-env

# Generate mock data
python -m etl_cli generate-mock-data --seed 42

# Run ETL pipeline
python -m etl_cli run-pipeline

# Or use Docker
docker compose run --rm etl python -m etl_cli --help
```

---

## 🧪 Testing

```bash
python -m pytest tests/ -v
```

All 24 tests passing ✅

---

## 📁 Project Structure

```
├── src/etl_cli/              Main application
├── tests/                    24 unit tests
├── docker/                   Docker config
├── data/                     Input & output
├── docker-compose.yml        Container setup
├── pyproject.toml            Python config
└── quick-start.sh            Setup script
```

---

## 🔧 Development

```bash
# Format code
black src tests

# Lint
flake8 src tests

# Test
pytest tests/ -v
```

Or with Docker:
```bash
docker compose run --rm etl pytest tests/ -v
docker compose run --rm etl black src tests
```

---

## 💡 Tech Stack

Python 3.10+ • Docker • Typer • Pandas • pytest • Black • flake8

---

## 📝 Next Steps

1. Generate mock data: `python -m etl_cli generate-mock-data`
2. Read the code: Check `src/etl_cli/` (well-commented)
3. Run tests: `pytest tests/ -v`
4. Customize pipeline: Edit `src/etl_cli/pipeline.py`
5. Push to GitHub: Automated CI/CD runs

---

## 📜 License

MIT License - See [LICENSE](./LICENSE)
