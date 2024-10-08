{{
    config(
        materialized='table'
    )
}}

with top_5 as (
    select name,  MAX(g) OVER (PARTITION BY g) as no_of_goals, year 
    from {{ ref('Hockey') }} 
    where year = '2011'
     limit 5
)

select * from top_5  