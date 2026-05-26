import os
import pendulum
from airflow import DAG
from airflow.operators.python import PythonOperator


def download_olist_dataset():
    import kaggle

    kaggle.api.authenticate()
    kaggle.api.dataset_download_files(
        dataset='olistbr/brazilian-ecommerce',
        path='/opt/airflow/data/raw',
        unzip=True
    )
    print("Dataset descargado correctamente")


with DAG(
    dag_id='dag_01_extract_olist',
    description='Descarga el dataset de Olist desde Kaggle',
    schedule=None,
    start_date=pendulum.datetime(2024, 1, 1, tz='UTC'),
    catchup=False,
    tags=['olist', 'extract'],
) as dag:

    download = PythonOperator(
        task_id='download_kaggle_dataset',
        python_callable=download_olist_dataset,
    )