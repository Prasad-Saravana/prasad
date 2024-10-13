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



