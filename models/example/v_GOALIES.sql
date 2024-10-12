{{
    config(
        materialized='view'
    )
}}

with v_GOALIES as 
(select * from {{ source('Hockey_Table', 'GOALIES') }})

select * from v_GOALIES