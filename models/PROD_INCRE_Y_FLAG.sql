{{ config(
    materialized='incremental',
    unique_key='id'    
) }}

WITH prod_flag AS (
    SELECT
        id,
        name,
        description,
        updated_at,
        current_flag
    FROM {{ source('Inc', 'Prod') }} 
)

SELECT
    id,
    name,
    description,
    updated_at,
    current_flag
FROM prod_flag

{% if is_incremental() %}
    WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})  
{% endif %}