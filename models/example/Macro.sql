{{
    config(materialized='table')
}}

WITH my_macro AS (
  SELECT 
    id,
    name,
    description,
    updated_at AS created_date,
    {{ current_date_formatted() }} AS updated_date
  FROM 
    {{ source('Inc', 'INC_PRE_POST') }}
)

select * from my_macro