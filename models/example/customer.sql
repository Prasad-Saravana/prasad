{{ config(materialized='table') }}

with customer as (
select *
from {{ref('customer_test')}}
where id = 1 
)

select * from customer