# Olist Analytics Pipeline

End-to-end data engineering project using the Brazilian e-commerce dataset from Olist.

## Architecture

![Architecture](docs/img/architecture.png)

## Tech stack

| Layer | Tool |
|---|---|
| Orchestration | Apache Airflow 2.9 |
| Compute | Databricks Community Edition |
| Transformation | dbt Core 1.8 |
| Database | PostgreSQL (Supabase) |
| Dashboard | Looker Studio |

## Project structure
## How to run

### 1. Clone and configure
```bash
git clone https://github.com/TUUSUARIO/olist-analytics-pipeline.git
cd olist-analytics-pipeline
cp .env.example .env
# Edit .env with your credentials
```

### 2. Start Airflow
```bash
docker compose up -d
```

### 3. Run dbt
```bash
cd dbt_project
dbt run
dbt test
```

## Status

- [ ] Phase 1: Database setup and roles
- [ ] Phase 2: Airflow DAGs
- [ ] Phase 3: dbt models
- [ ] Phase 4: Databricks notebooks
- [ ] Phase 5: Looker Studio dashboard
