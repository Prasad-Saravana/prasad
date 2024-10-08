{{
    config(
        materialized='table'
    )
}}

with src_SCORING as 
(select * from {{ source('Hockey_Table', 'SCORING') }})

select * from src_SCORING