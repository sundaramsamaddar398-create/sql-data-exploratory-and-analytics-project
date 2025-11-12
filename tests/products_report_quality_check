/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and accuracy of the products_report. These checks ensure:
    - Validation of Transformed Dimensions and Aggregates Measures.

Usage Notes:
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/


-- Final Check of gold_report_products
SELECT * FROM gold_report_products;

-- Distict product_segment check
SELECT DISTINCT product_segment FROM gold_report_products;


-- product_segment behaviour metric
SELECT
    product_segment,
    SUM(total_customers) As total_customers,
    SUM(total_sales) AS total_sales,
    SUM(total_orders) AS total_orders,
    SUM(total_quantity) AS total_quantity,
    ROUND(AVG(lifespan), 2) AS avg_lifespan,
    ROUND(AVG(avg_selling_price), 2) AS avg_selling_price
FROM gold_report_products
GROUP BY product_segment;
