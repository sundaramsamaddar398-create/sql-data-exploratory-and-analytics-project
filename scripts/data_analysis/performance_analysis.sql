/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/


-- ----------------------------------------------------------------------------------------
/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */
-- ----------------------------------------------------------------------------------------


WITH yearly_product_sales AS (
        SELECT
            YEAR(f.order_date) AS order_year,
            dp.product_name,
            SUM(f.sales_amount) current_sales
        From gold_dim_products AS dp
        LEFT JOIN gold_fact_sales AS f
            ON f.product_key = dp.product_key
        WHERE f.order_date IS NOT NULL
        GROUP BY 
            order_year,
            dp.product_name
    )
    SELECT
        order_year,
        product_name,
        current_sales,
        AVG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS avg_sales,
        current_sales - AVG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) As sales_difference,
        CASE
            WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN  'Above Average'
            WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN  'Below Average'
            ELSE 'Average'
        END avg_change,
        LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) As previous_year_sales,
        current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) As previous_year_difference,
        CASE
            WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN  'Increase'
            WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN  'Decrease'
            ELSE 'No Change'
        END avg_change        
    FROM yearly_product_sales
    ORDER BY 
        product_name,
        order_year
;
