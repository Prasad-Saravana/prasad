{{
    config(
        materialized='view'
    )
}}

with v_COACHES as 
(select * from {{ source('Hockey_Table', 'COACHES') }})

select * from v_COACHES