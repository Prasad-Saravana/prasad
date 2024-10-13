{{ config(
    materialized='incremental',
    pre_hook="""
        {% if is_incremental() %}
            TRUNCATE TABLE {{ this }}
        {% endif %}
    """,
    post_hook="""
        INSERT INTO audit_log (message, created_at)
        VALUES ('Incremental model run complete for {{ this }}', CURRENT_TIMESTAMP)
    """
) }}

WITH source_data AS (
    SELECT
        *
    FROM {{ source('Inc', 'INC_PRE_POST') }}
    WHERE updated_at > (SELECT COALESCE(MAX(updated_at), '1970-01-01') FROM {{ this }})
)

SELECT
    *
FROM source_data
