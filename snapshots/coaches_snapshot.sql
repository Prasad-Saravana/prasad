{% snapshot coaches_snap %}

    {{ config(
        unique_key='coach_id', 
        strategy='timestamp',  
        updated_at='updated_at'  
    ) }}

   
    SELECT
        coach_id,
        coach_name,
        team,
        email,
        updated_at
    FROM {{ source('Coaches_Table', 'coaches_snapshot') }}

{% endsnapshot %}


-- Query to retrieve the current version of each coach (SCD Type 2 logic)

WITH coaches_2 AS (
    SELECT
        coach_id,
        coach_name,
        team,
        email,
        dbt_valid_from,   -- The start date of the record (when it became valid)
        dbt_valid_to      -- The end date (when the record was replaced by a new version)
    FROM {{ ref('coaches_snap') }}  -- Reference the snapshot table
    WHERE dbt_valid_to IS NULL          -- Get only the current (active) record
)

SELECT * FROM current_coaches;
