{{
    config(
        materialized='table'
    )
}}

with src_COACHES as 
(select * from {{ source('Hockey_Table', 'COACHES') }})

select * from src_COACHES