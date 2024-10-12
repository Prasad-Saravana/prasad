{{
    config(
        materialized='view'
    )
}}

with v_MASTER as 
(select * from {{ source('Hockey_Table', 'MASTER') }})

select * from v_MASTER