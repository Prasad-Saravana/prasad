{{
    config(
        materialized='table'
    )
}}

with src_MASTER1 as 
(select * from {{ source('Hockey_Table', 'MASTER') }})

select * from src_MASTER1