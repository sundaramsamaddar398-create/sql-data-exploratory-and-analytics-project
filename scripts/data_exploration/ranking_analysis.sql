/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), LIMIT
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/


-- ---------------------------------------------------
-- Which 5 products Generating the Highest Revenue?
-- ---------------------------------------------------

-- Simple Ranking

SELECT
    gdp.product_name,
    SUM(gfs.sales_amount) AS total_revenue
FROM gold_dim_products AS gdp
LEFT JOIN gold_fact_sales AS gfs
    ON gdp.product_key = gfs.product_key
GROUP BY gdp.product_name
ORDER BY total_revenue DESC
LIMIT 5;


-- Complex but Flexibly Ranking Using Window Functions

SELECT
    *
From(
    SELECT
        gdp.product_name,
        SUM(gfs.sales_amount) AS total_revenue,
        RANK() OVER (ORDER BY SUM(gfs.sales_amount) DESC) rank_products
    FROM gold_dim_products AS gdp
    LEFT JOIN gold_fact_sales AS gfs
        ON gdp.product_key = gfs.product_key
    GROUP BY gdp.product_name
) AS ranked_products
WHERE rank_products < 6;


-- -------------------------------------------------------------
-- What are the 5 worst-performing products in terms of sales?
-- -------------------------------------------------------------

-- Simple Ranking

SELECT
    gdp.product_name,
    SUM(gfs.sales_amount) AS total_revenue
FROM gold_dim_products AS gdp
LEFT JOIN gold_fact_sales AS gfs
    ON gdp.product_key = gfs.product_key
GROUP BY gdp.product_name
ORDER BY total_revenue ASC
LIMIT 5;


-- Complex but Flexibly Ranking Using Window Functions

SELECT
    *
From(
    SELECT
        gdp.product_name,
        SUM(gfs.sales_amount) AS total_revenue,
        RANK() OVER (ORDER BY SUM(gfs.sales_amount) ASC) rank_products
    FROM gold_dim_products AS gdp
    LEFT JOIN gold_fact_sales AS gfs
        ON gdp.product_key = gfs.product_key
    GROUP BY gdp.product_name
) AS ranked_products
WHERE rank_products < 6;


-- ------------------------------------------------------------------
-- Find the top 10 customers who have generated the highest revenue
-- ------------------------------------------------------------------

SELECT 
    gdc.customer_key,
    gdc.first_name,
    gdc.last_name,
    SUM(gfs.sales_amount) AS total_revenue
FROM gold_fact_sales AS gfs
LEFT JOIN gold_dim_customers gdc
    ON gdc.customer_key = gfs.customer_key
GROUP BY 
    gdc.customer_key,
    gdc.first_name,
    gdc.last_name
ORDER BY total_revenue DESC
LIMIT 10;


-- ------------------------------------------------------------------
-- The 3 customers with the fewest orders placed
-- ------------------------------------------------------------------

SELECT 
    gdc.customer_key,
    gdc.first_name,
    gdc.last_name,
    COUNT(DISTINCT gfs.order_number) AS total_orders
FROM gold_fact_sales AS gfs
LEFT JOIN gold_dim_customers gdc
    ON gdc.customer_key = gfs.customer_key
GROUP BY 
    gdc.customer_key,
    gdc.first_name,
    gdc.last_name
ORDER BY total_orders ASC
LIMIT 3;
