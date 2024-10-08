{{ config(
    materialized='incremental',
    unique_key='COACHID,YEAR,STINT'
) }}

WITH Coaches_incremental as (
    select * from 
{{ source('Hockey_Table', 'COACHES')
  }})

select * from Coaches_incremental