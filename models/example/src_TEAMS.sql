{{
    config(
        materialized='table'
    )
}}

with src_TEAMS as 
(select * from {{ source('Hockey_Table', 'TEAMS') }})

select * from src_TEAMS