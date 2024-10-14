SELECT
    *
FROM
    {{ ref('date_val_generic') }}
WHERE
    UPDATED_AT IS  NULL
    OR UPDATED_AT NOT BETWEEN '1900-01-01' AND '9999-12-31'