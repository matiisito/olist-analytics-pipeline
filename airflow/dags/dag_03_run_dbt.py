import pendulum
from airflow import DAG
from airflow.operators.bash import BashOperator

with DAG(
    dag_id='dag_03_run_dbt',
    description='Ejecuta dbt run y dbt test sobre todos los modelos',
    schedule=None,
    start_date=pendulum.datetime(2024, 1, 1, tz='UTC'),
    catchup=False,
    tags=['olist', 'dbt'],
) as dag:

    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='cd /opt/airflow/dbt_project && dbt run --profiles-dir .',
    )

    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command='cd /opt/airflow/dbt_project && dbt test --profiles-dir .',
    )

    dbt_run >> dbt_test