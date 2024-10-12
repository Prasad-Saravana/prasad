{{ 
    config(
        materialized= 'ephemeral'   
    ) 
}}

with coaches_ephe as
 (SELECT * FROM {{ ref('src_COACHES') }})

 select * from coaches_ephe