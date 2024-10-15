{{
    config(
        materialized='table'
    )
}}

with Hockey_teams as (
    select name,g,year
    from hockeydb.hockey.teams
   )

select  * from Hockey_teams 


