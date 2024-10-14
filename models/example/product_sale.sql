{{ config(
    materialized='table'
) }}

WITH monthly_data AS (
    SELECT
        product_id,
        product_name,
        extract(MONTH from Sale_date) AS month_year,
        SUM(sales) AS total_sales,
        SUM(quantity_sold) AS total_quantity,
        SUM(cost_price * quantity_sold) AS total_cost,
        SUM(selling_price * quantity_sold) AS total_revenue,
        SUM(discounts) AS total_discounts,
        SUM(returns) AS total_returns
    FROM {{ source('Inc', 'product') }}  -- Reference to your product table
    GROUP BY product_id, product_name, month_year
)

SELECT
    product_id,
    product_name,
    month_year,
    total_sales,
    total_quantity,
    CASE 
        WHEN total_quantity = 0 THEN 0
        ELSE total_revenue / NULLIF(total_quantity, 0)  -- Calculate unit price
    END AS unit_price,
    total_revenue - total_cost AS profit  -- Calculate profit
FROM monthly_data
ORDER BY month_year, product_id
