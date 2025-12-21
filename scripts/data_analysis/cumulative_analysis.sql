/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/


-- ---------------------------------------------------
-- Calculate the total sales per month 
-- and the running total of sales over time
-- and the moving average price over time
-- ---------------------------------------------------

SELECT
    year_end,
    total_sales,
    SUM(total_sales) OVER(ORDER BY year_end ASC) AS running_total_sales,
    AVG(avg_price) OVER(ORDER BY year_end ASC) AS moving_average_price
FROM (
    SELECT
        LAST_DAY(MAKEDATE(YEAR(order_date), 365)) AS year_end, -- Makedate used for calculating the last day of the year with 365 being the last day of the year
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold_fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY year_end
    ORDER BY year_end ASC
) AS t;
