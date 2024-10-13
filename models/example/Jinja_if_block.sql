{{ config(
    materialized='table'
) }}

WITH jinja_if AS (
    SELECT
        *
    FROM {{ source('Inc', 'prod_jing_if_Block') }}
)

SELECT
    *
FROM jinja_if
WHERE 1 = 1

{% if var('col',false) %}
    AND description = '{{ var('val') }}'
{% endif %}

