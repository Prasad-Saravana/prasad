--materializing the model to get the output as table 
{{
    config(
        materialized='table'
    )
}}
--selecting the name,goal count,year for the hockey teams
with Hockey_teams as (
    select name,g,year
    from hockeydb.hockey.teams
   )

select  * from Hockey_teams 


