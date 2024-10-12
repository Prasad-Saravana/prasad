{{
    config(
        materialized='view'
    )
}}

with v_SCORING as 
(select * from {{ source('Hockey_Table', 'SCORING') }})

select * from v_SCORING