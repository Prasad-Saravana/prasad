{{ config(materialized='table') }}

with source as (
    select * from {{ source('Inc', 'INC_PRE_POST') }}
),
target as (
    select * from {{ ref('incremental_post_pre_hook') }}
),
 
missing_in_target as (
    select * from source
    except
    select * from target
),
 
missing_in_source as (
    select * from target
    except
    select * from source
)

select
    
    (select count(*) from source) as source_count,
    (select count(*) from target) as target_count,
    (select count(*) from missing_in_target) as missing_in_target_count,
    (select count(*) from missing_in_source) as missing_in_source_count

