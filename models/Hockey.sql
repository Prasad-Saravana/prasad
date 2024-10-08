{{
    config(
        materialized='table'
    )
}}

with Hockey_teams as (
    select name,g,year
    from hockeydb.hockey.teams
    limit 5
   )

select  * from Hockey_teams order by name ,g


