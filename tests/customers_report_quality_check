/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and accuracy of the customers_report. These checks ensure:
    - Validation of Transformed Dimensions and Aggregates Measures.

Usage Notes:
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/




-- Final Check of gold_report_customers
SELECT * FROM gold_report_customers;

-- Distict age_group check
SELECT DISTINCT age_group FROM gold_report_customers;

-- age_group behaviour metric
SELECT
    age_group,
    COUNT(customer_number) As total_customers,
    SUM(total_sales) AS total_sales,
    AVG(avg_order_value) AS average_order_value,
    AVG(avg_monthly_spend) AS average_monthly_spends
FROM gold_report_customers
GROUP BY age_group;


-- customer_segment behaviour metric
SELECT
    customer_segment,
    COUNT(customer_number) As total_customers,
    SUM(total_sales) AS total_sales,
    AVG(avg_order_value) AS average_order_value,
    AVG(avg_monthly_spend) AS average_monthly_spends
FROM gold_report_customers
GROUP BY customer_segment;
