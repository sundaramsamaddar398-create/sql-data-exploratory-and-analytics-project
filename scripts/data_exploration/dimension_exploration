/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/


-- -----------------------------------------------------------------------------------------
-- Retrieve a list of unique countries, gender and marital_status from which dim_customers
-- -----------------------------------------------------------------------------------------

-- Country

SELECT DISTINCT 
    country 
FROM gold_dim_customers
ORDER BY country;

-- Gender

SELECT DISTINCT 
    gender 
FROM gold_dim_customers
ORDER BY gender;

-- Marital Status

SELECT DISTINCT 
    marital_status 
FROM gold_dim_customers
ORDER BY marital_status;


-- ------------------------------------------------------------------------------------------------------------------------------------
-- Retrieve a list of unique categories, subcategories, product_line and products in a big picture to understand the business
-- ------------------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT 
    category, 
    subcategory,
    product_line,  
    product_name
FROM gold_dim_products
ORDER BY category, subcategory, product_line, product_name;
