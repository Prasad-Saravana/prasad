{{
    config(
        materialized='view'
    )
}}

with v_TEAMS as 
(select * from {{ source('Hockey_Table', 'TEAMS') }})

select * from v_TEAMS