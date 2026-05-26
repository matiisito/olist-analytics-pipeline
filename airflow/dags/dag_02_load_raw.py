import os
import pendulum
import pandas as pd
from sqlalchemy import create_engine
from airflow import DAG
from airflow.operators.python import PythonOperator


def get_engine():
    host = os.environ['POSTGRES_HOST']
    port = os.environ['POSTGRES_PORT']
    db = os.environ['POSTGRES_DB']
    user = os.environ['POSTGRES_USER']
    password = os.environ['POSTGRES_PASSWORD']
    return create_engine(f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{db}')


def load_csv(filename, table_name):
    engine = get_engine()
    filepath = f'/opt/airflow/data/raw/{filename}'
    df = pd.read_csv(filepath)
    df.to_sql(
        name=table_name,
        con=engine,
        schema='raw',
        if_exists='replace',
        index=False
    )
    print(f'Loaded {len(df)} rows into raw.{table_name}')


TABLES = {
    'olist_orders_dataset.csv':               'orders',
    'olist_customers_dataset.csv':            'customers',
    'olist_order_items_dataset.csv':          'order_items',
    'olist_products_dataset.csv':             'products',
    'olist_sellers_dataset.csv':              'sellers',
    'olist_order_reviews_dataset.csv':        'order_reviews',
    'olist_order_payments_dataset.csv':       'order_payments',
    'olist_geolocation_dataset.csv':          'geolocation',
    'product_category_name_translation.csv':  'product_category_translation',
}

with DAG(
    dag_id='dag_02_load_raw',
    description='Carga los CSVs de Olist a PostgreSQL schema raw',
    schedule=None,
    start_date=pendulum.datetime(2024, 1, 1, tz='UTC'),
    catchup=False,
    tags=['olist', 'load'],
) as dag:

    previous = None
    for filename, table in TABLES.items():
        task = PythonOperator(
            task_id=f'load_{table}',
            python_callable=load_csv,
            op_kwargs={'filename': filename, 'table_name': table},
        )
        if previous:
            previous >> task
        previous = task