{{ config(materialized='table') }}

with dates_val as (
    select
        *
    from {{ source('Inc', 'DATE_VAL') }}
)

select 
   *
from dates_val
