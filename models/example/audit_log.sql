{{ config(
    materialized='table'
) }}

CREATE TABLE IF NOT EXISTS {{ this }} (
    id INT PRIMARY KEY,
    message STRING,
    created_at TIMESTAMP
);

SELECT
    ROW_NUMBER() OVER (ORDER BY created_at DESC) AS id,
    'Audit log initialized' AS message,
    CURRENT_TIMESTAMP AS created_at
WHERE 1 = 0  -- Prevents initial data from being inserted
