{{ config(
    materialized='incremental',
) }}

WITH source_data AS (
    SELECT
        *
    FROM {{ source('Inc', 'Prod') }} 
    WHERE current_flag = 'Y' OR updated_at >= (SELECT MAX(updated_at) FROM {{ this }})  -- Handle case when no records exist
),

updated_records AS (
    SELECT
        id,
        'N' AS current_flag,  -- Set flag to 'N' for updated records
        name,
        description,
        updated_at
    FROM source_data
    WHERE id IN (
        SELECT id
        FROM {{ this }}
        WHERE current_flag = 'Y' AND updated_at < (SELECT MAX(updated_at) FROM {{ this }})
    )
)

SELECT
    s.id,
    COALESCE(u.current_flag, 'Y') AS current_flag,  -- Keep 'Y' if no update is found
    s.name,
    s.description,
    s.updated_at
FROM source_data s
LEFT JOIN updated_records u ON s.id = u.id
