CREATE ROLE data_engineer;
CREATE ROLE data_analyst;

GRANT USAGE, CREATE ON SCHEMA raw          TO data_engineer;
GRANT USAGE, CREATE ON SCHEMA staging      TO data_engineer;
GRANT USAGE, CREATE ON SCHEMA intermediate TO data_engineer;
GRANT USAGE, CREATE ON SCHEMA marts        TO data_engineer;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA raw          TO data_engineer;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA staging      TO data_engineer;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA intermediate TO data_engineer;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA marts        TO data_engineer;

ALTER DEFAULT PRIVILEGES IN SCHEMA raw          GRANT ALL ON TABLES TO data_engineer;
ALTER DEFAULT PRIVILEGES IN SCHEMA staging      GRANT ALL ON TABLES TO data_engineer;
ALTER DEFAULT PRIVILEGES IN SCHEMA intermediate GRANT ALL ON TABLES TO data_engineer;
ALTER DEFAULT PRIVILEGES IN SCHEMA marts        GRANT ALL ON TABLES TO data_engineer;

GRANT USAGE ON SCHEMA marts TO data_analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA marts TO data_analyst;
ALTER DEFAULT PRIVILEGES IN SCHEMA marts GRANT SELECT ON TABLES TO data_analyst;

CREATE USER airflow_user  PASSWORD 'airflow_pass_123' IN ROLE data_engineer;
CREATE USER looker_user   PASSWORD 'looker_pass_456'  IN ROLE data_analyst;