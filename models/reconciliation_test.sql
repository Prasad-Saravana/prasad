with reconciliation_count as (
    select
        (select source_count from {{ ref('reconciliation') }}) as Source_records,
        (select target_count from {{ ref('reconciliation') }}) as Target_records,
        (select missing_in_target_count from {{ ref('reconciliation') }} ) as missing_records
)
select
    Source_records,
    Target_records,
    missing_records,
    case
        when missing_records = 0 then 'Success: No missing_records found'
        else 'Failure: missing_records detected'
    end as result
from reconciliation_count
