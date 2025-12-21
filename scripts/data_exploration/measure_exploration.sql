/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/


-- -------------------------------------
-- Find the Total Sales
-- -------------------------------------

SELECT
    SUM(sales_amount) AS total_sales
FROM gold_fact_sales;


-- -------------------------------------
-- Find how many items are sold
-- -------------------------------------

SELECT
    SUM(quantity) AS total_quantity
FROM gold_fact_sales;


-- -------------------------------------
-- Find the average selling price
-- -------------------------------------

SELECT
    AVG(price) AS AVG_sales
FROM gold_fact_sales;


-- -------------------------------------
-- Find the Total number of Orders
-- -------------------------------------

SELECT
    COUNT(order_number) AS total_orders
FROM gold_fact_sales;

SELECT 
    COUNT(DISTINCT order_number) AS total_orders -- one order may contains multiple products by a single customer
FROM gold_fact_sales;


-- -------------------------------------
-- Find the total number of products
-- -------------------------------------

SELECT DISTINCT
    COUNT(product_key) AS total_products
FROM gold_dim_products;

SELECT DISTINCT
    COUNT(DISTINCT product_key) AS total_products
FROM gold_dim_products;


-- -------------------------------------
-- Find the total number of customers
-- -------------------------------------

SELECT DISTINCT
    COUNT(customer_key) AS total_customers
FROM gold_dim_customers;

SELECT DISTINCT
    COUNT(DISTINCT customer_key) AS total_customers
FROM gold_dim_customers;


-- ---------------------------------------------------------------
-- Find the total number of customers that has placed an order
-- ---------------------------------------------------------------

SELECT
    COUNT(DISTINCT customer_key) AS total_customers_ordered
FROM gold_fact_sales; 



-- ---------------------------------------------------------------
-- Generate a Report that shows all key metrics of the business
-- ---------------------------------------------------------------

SELECT "Total Sales" AS measure_name, SUM(sales_amount) AS measure_value FROM gold_fact_sales
UNION ALL
SELECT "Total Quantity" AS measure_name, SUM(quantity) AS measure_value FROM gold_fact_sales
UNION ALL
SELECT "Average Price" AS measure_name, AVG(price) AS measure_value FROM gold_fact_sales
UNION ALL
SELECT "Total Orders" AS measure_name, COUNT( DISTINCT order_number) AS measure_value FROM gold_fact_sales
UNION ALL
SELECT "Total Products" AS measure_name, COUNT(DISTINCT product_key) AS measure_value FROM gold_dim_products
UNION ALL
SELECT "Total Customers" AS measure_name, COUNT(DISTINCT customer_key) AS measure_value FROM gold_dim_customers
UNION ALL
SELECT "Total Customers Ordered" AS measure_name, COUNT(DISTINCT customer_key) AS measure_value FROM gold_fact_sales;
