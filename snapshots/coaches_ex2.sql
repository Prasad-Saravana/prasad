{% snapshot coach_snapshot_check %}
    {{ config(
        unique_key='coach_id', 
        strategy='check',  
        check_cols=['coach_name', 'team', 'email'] 
    ) }}

SELECT
        coach_id,
        coach_name,
        team,
        email,
        updated_at
    FROM {{ source('Coaches_Table', 'Coach_Snap_check') }}
{% endsnapshot %}





