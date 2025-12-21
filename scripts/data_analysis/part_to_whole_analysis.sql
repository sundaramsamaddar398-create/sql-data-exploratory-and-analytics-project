/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/


-- ----------------------------------------------------------
-- Which categories contribute the most to overall sales?
-- ----------------------------------------------------------

WITH category_sales AS (
    SELECT
        dp.category,
        SUM(f.sales_amount) AS total_sales
    FROM gold_dim_products AS dp
    LEFT JOIN gold_fact_sales AS f
        ON f.product_key = dp.product_key
    WHERE f.sales_amount IS NOT NULL
    GROUP BY dp.category
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    CONCAT(ROUND((total_sales / SUM(total_sales) OVER ()) * 100, 2), "%") As percentage_of_total
From category_sales
ORDER BY total_sales;
