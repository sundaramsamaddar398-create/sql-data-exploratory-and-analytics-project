/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: YEAR(), MONTH(), DATE_FORMAT(), LAST_DAY()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/


-- --------------------------------------------
-- Analyse sales performance over time
-- --------------------------------------------

-- Quick Date Functions

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    MONTHNAME(order_date) AS order_month_name,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold_fact_sales
WHERE order_date IS NOT NULL
GROUP BY 
    YEAR(order_date),
    MONTH(order_date),
    MONTHNAME(order_date)
ORDER BY 
    YEAR(order_date) ASC,
    MONTH(order_date) ASC
;


-- Format

SELECT
    DATE_FORMAT(order_date, "%Y-%M") AS order_year_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold_fact_sales
WHERE order_date IS NOT NULL
GROUP BY 
    DATE_FORMAT(order_date, "%Y-%M")
ORDER BY 
   DATE_FORMAT(order_date, "%Y-%M") ASC
;



-- Last_day()

SELECT
    LAST_DAY(order_date) AS month_end,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold_fact_sales
WHERE order_date IS NOT NULL
GROUP BY 
    LAST_DAY(order_date)
ORDER BY 
   LAST_DAY(order_date) ASC
;
