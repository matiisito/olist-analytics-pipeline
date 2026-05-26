CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS intermediate;
CREATE SCHEMA IF NOT EXISTS marts;

COMMENT ON SCHEMA raw          IS 'Data as-is from source (Olist CSVs)';
COMMENT ON SCHEMA staging      IS 'Cleaned and typed, 1:1 with source';
COMMENT ON SCHEMA intermediate IS 'Business logic, joins and enrichment';
COMMENT ON SCHEMA marts        IS 'Final tables ready for dashboard';