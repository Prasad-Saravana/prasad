-- row_count_consistency

with source_data as (
    select count(*) as row_count
    from {{ source('INC', 'product') }}
),

target_data as (
    select count(*) as row_count
    from {{ ref('product_sale') }}
)

select
    s.row_count as source_row_count,
    t.row_count as target_row_count,
    case
        when s.row_count = t.row_count then 'PASS'
        else 'FAIL'
    end as status
from source_data s, target_data t
