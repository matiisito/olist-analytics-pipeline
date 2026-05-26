FROM apache/airflow:2.9.1
RUN pip install kaggle pandas sqlalchemy psycopg2-binary python-dotenv dbt-core dbt-postgres