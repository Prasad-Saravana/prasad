{{
    config(
        materialized='table'
    )
}}

WITH Scoring as 
(select
coalesce(playerid,'NA'),
coalesce(year,9999),
coalesce(POS,'NA'),
COALESCE(GP,0)
from {{ source('Hockey_Table', 'SCORING') }})

select * from scoring