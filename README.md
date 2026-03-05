# Customer Data ETL

Python ETL application with Docker.

## Setup

```bash
python3 -m venv venv
source venv/bin/activate  # or .\venv\Scripts\activate on Windows
pip install -e .
```

## Run

```bash
# CLI commands
python -m etl_cli --help
python -m etl_cli check-env
python -m etl_cli generate-mock-data
python -m etl_cli run-pipeline

# Tests
pytest tests/ -v

# Docker
docker compose build
docker compose run --rm etl python -m etl_cli --help
```

## Project Structure

```
├── src/etl_cli/       Application code
├── tests/             Unit tests (24 tests)
├── docker/            Dockerfile
├── docker-compose.yml Docker config
├── pyproject.toml     Project config
└── .env.template      Environment template
```
