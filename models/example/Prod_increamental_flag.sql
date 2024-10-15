{{ config(
    materialized='incremental'
) }}

WITH source_data AS (
    SELECT
        *
    FROM {{ source('Inc', 'Prod') }} 
    WHERE current_flag = 'Y' OR updated_at >= (SELECT MAX(updated_at) FROM {{ this }})  -- Handle case when no records exist
),

updated_records AS (
     SELECT
        s.id,
        'N' AS current_flag,  -- Set flag to 'N' for updated records
        s.name,
        s.description,
        s.updated_at,
        ROW_NUMBER() OVER (PARTITION BY s.id ORDER BY s.updated_at DESC) AS rn
    FROM source_data s
    JOIN {{ this }} e ON s.id = e.id
    WHERE e.current_flag = 'Y' 
      AND (s.name <> e.name OR s.description <> e.description OR s.updated_at <> e.updated_at)
)

SELECT
    s.id,
    CASE
        WHEN u.rn = 1 THEN u.current_flag  -- Use the updated flag if it's the latest version
        ELSE 'Y'  -- Keep 'Y' for unchanged records
    END AS current_flag,
    s.name,
    s.description,
    s.updated_at
FROM source_data s
LEFT JOIN (
    SELECT id, current_flag, name, description, updated_at
    FROM updated_records
    WHERE rn = 1  -- Only select the latest updated records
) u ON s.id = u.id
