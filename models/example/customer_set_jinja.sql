{% set payment_methods_query %}
SELECT DISTINCT
    C_MKTSEGMENT
FROM {{ source('Inc', 'customer_jinja_set') }}
ORDER BY 1
{% endset %}

{% set results = run_query(payment_methods_query) %}

{% if execute %}
    {% set results_list = results.columns[0].values() %}
{% else %}
    {% set results_list = [] %}
{% endif %}

WITH segments AS (
    SELECT
        customer_id,
        C_MKTSEGMENT,
        CASE
            {% for segment in results_list %}
            WHEN C_MKTSEGMENT = '{{ segment }}' THEN '{{ segment }}'
            {% endfor %}
            ELSE 'Other'
        END AS market_segment
    FROM {{ source('Inc', 'customer_jinja_set') }}
)

SELECT
    customer_id,
    market_segment
FROM segments
