{{ config(
    materialized='incremental',
    unique_key='id') }}

WITH Prod_inc AS (
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
FROM Prod_inc

{% if is_incremental() %}
    WHERE updated_at  (SELECT MAX(updated_at) FROM {{ this }})  
{% endif %}