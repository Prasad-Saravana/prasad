{{
    config(
        materialized='table'
    )
}}

WITH Team_Avg_score as(
select t.name,s.tmid,round(avg(s.g))
from 
{{ source('Hockey_Table', 'TEAMS') }} T JOIN
{{ source('Hockey_Table', 'SCORING') }} S
ON T.TMID = S.TMID
group by t.name,s.tmid
)

select * from Team_Avg_score

