{{
    config(
        materialized='table'
    )
}}

with src_Hockey as 
(select * from {{ source('Hockey_Table', 'TEAMS') }})

select * from src_Hockey