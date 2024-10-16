{{ config(
    materialized='incremental',
    unique_key='COACHID,YEAR,STINT'
) }}

WITH Coaches_incremental as (
    select * from 
{{ source('Hockey_Table', 'COACHES')
  }})

 select * from Coaches_incremental 

select  COACHID,year,STINT,count(*) from Coaches_incremental
 group by 1,2,3 having count(*)=1