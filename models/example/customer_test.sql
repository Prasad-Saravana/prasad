{{ config(materialized='table') }}

with customer as (
select *
from training.dbt_prasad.customer_test
)

select * from customer