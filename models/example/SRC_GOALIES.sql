{{
    config(
        materialized='table'
    )
}}

with src_GOALIES as 
(select * from {{ source('Hockey_Table', 'GOALIES') }})

select * from src_GOALIES