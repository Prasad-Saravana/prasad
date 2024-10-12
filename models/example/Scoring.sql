{{
    config(
        materialized='table'
    )
}}

WITH Scoring as 
(select
coalesce(playerid,'NA') playerid,
coalesce(year,9999) year,
coalesce(POS,'NA')POS,
COALESCE(GP,0) GP
from {{ source('Hockey_Table', 'SCORING') }})

select * from scoring