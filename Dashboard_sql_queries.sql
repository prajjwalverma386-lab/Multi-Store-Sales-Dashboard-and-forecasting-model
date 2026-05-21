/* =========================================================
   MULTI-STORE SALES ANALYSIS PROJECT
   Tools: PostgreSQL | Power BI | Python
   Objective:
   Analyze multi-store sales performance, seasonal demand
   fluctuations, forecasting trends, and store contribution.
========================================================= */


/* =========================================================
   1. DATA QUALITY CHECKS
========================================================= */

-- Check for null values

SELECT *
FROM cleaned_sales
WHERE weekly_sales IS NULL
   OR store IS NULL;


/* =========================================================
   2. DUPLICATE RECORD DETECTION
========================================================= */

-- Identify duplicate store-week entries

SELECT store,
       week_date,
       COUNT(*)
FROM sales
GROUP BY store, week_date
HAVING COUNT(*) > 1;


/* =========================================================
   3. TOTAL SALES BY STORE
========================================================= */

-- Analyze top-performing stores by total sales

SELECT store,
       SUM(weekly_sales) AS total_store_sales
FROM cleaned_sales
GROUP BY store
ORDER BY total_store_sales DESC;


/* =========================================================
   4. YEARLY SALES ANALYSIS
========================================================= */

-- Evaluate yearly sales contribution by store

SELECT store,
       TO_CHAR(TO_DATE(week_date, 'DD-MM-YYYY'), 'YYYY') AS year,
       SUM(weekly_sales) AS total_year_sales
FROM cleaned_sales
GROUP BY store, year
ORDER BY year, total_year_sales DESC;


/* =========================================================
   5. MONTHLY SALES TREND ANALYSIS
========================================================= */

-- Analyze monthly sales peaks and seasonal demand behavior

SELECT store,
       TO_CHAR(TO_DATE(week_date, 'DD-MM-YYYY'), 'MM-YYYY') AS month_year,
       SUM(weekly_sales) AS monthly_sales
FROM cleaned_sales
GROUP BY month_year, store
ORDER BY monthly_sales DESC;