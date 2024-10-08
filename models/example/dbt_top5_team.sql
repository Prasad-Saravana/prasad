{{
    config(
        materialized='table'
    )
}}

with top_5 as (
    select name,  MAX(g) OVER (PARTITION BY g ORDER BY g desc) as no_of_goals, year 
    from {{ source("Hockey_Table", "TEAMS") }}  
    where year = '2011'
     limit 5
)

select * from top_5  