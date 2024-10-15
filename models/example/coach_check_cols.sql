WITH coach_check AS (
    SELECT
        coach_id,
        coach_name,
        team,
        email,
        dbt_valid_from,   -- The start date of the record (when it became valid)
        dbt_valid_to      -- The end date (when the record was replaced by a new version)
    FROM {{ ref('coach_snapshot_check') }}  -- Reference the snapshot table
    WHERE dbt_valid_to IS NULL          -- Get only the current (active) record
)

SELECT * FROM coach_check