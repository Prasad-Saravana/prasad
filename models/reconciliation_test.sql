with reconciliation as (
    select
        (select count(*) from {{ ref('reconciliation') }}) as total_records,
        (select count(*) from {{ ref('reconciliation') }} where missing_in_target_count > 0) as missing_records
)
 
select
    total_records,
    missing_records,
    case
        when missing_records = 0 then 'Success: No missing_records found'
        else 'Failure: missing_records detected'
    end as result
from reconciliation
