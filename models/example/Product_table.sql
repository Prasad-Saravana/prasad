{{
    config(
        materialized='table'
    )
}}

 with Product as 
 (SELECT 
    id,
    name,
    description,
    FROM 
    {{ source('Inc', 'INC_PRE_POST') }} )

select * from Product

