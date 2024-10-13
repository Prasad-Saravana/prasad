
SELECT *
FROM {{ source('Inc', 'CUSTOMER_TEST') }}
WHERE name = '{{ var('my_variable') }}'
 
 

 
