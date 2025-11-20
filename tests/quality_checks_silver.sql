/*
==============================================================================  
Quality Checks
============================================================================== 
Script Purpose :
    This script perform various quality checks, for date consistency, accuracy,
    standardization across the 'silver' schemas. It includes checks for : 
    - Null or duplicate primary keys.
    - Unwanted spaces in  string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage notes :
    - Run this script after data loading silver layer.
    - Investigate and resolve any discrepancies found during the checks.
============================================================================== 
*/

-- ======================================================
-- Checking 'silver.crm_cust_info'
-- ======================================================
-- Check for NULLS or Duplicates in Primary Key
-- Expetation: No Results
SELECT
    cst_id,
    COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for Unwanted Spaces
-- Expetation: No Results
SELECT
    cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Data Standardization & Consistency
SELECT DISTINCT
    cst_marital_status
FROM silver.crm_cust_info;


-- ======================================================
-- Checking 'silver.crm_prd_info'
-- ======================================================
-- Check for NULLS or Duplicates in Primary Key
-- Expetation: No Results
SELECT
    prd_id,
    COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for Unwanted Spaces
-- Expetation: No Results
SELECT
    prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm); 

-- Check for NULLS or Negative values in cost
-- Expetation: No Results
SELECT 
    prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT
    prd_line
FROM silver.crm_prd_info;

-- Check for Invalid Date Orders (Start Date > End Date)
-- Expetation: No Results
SELECT 
    *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ======================================================
-- Checking 'silver.crm_sales_details'
-- ======================================================
-- Check for Invalid Dates
-- Expetation: No Invalid Dates
SELECT 
    NULLIF (sls_due_date, 0) AS sls_due_date
FROM silver.crm_sales_details
WHERE sls_due_date <=0
    OR LEN(sls_due_date) != 8
    OR sls_due_date > '20500101'
    OR sls_due_date < '19000101';

-- Check for Invalid  Date Orders (Order Date > Shipping / Due Dates)
-- Expetation: No Results
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
OR sls_order_dt > sls_due_date;

-- Check Data Consistency: Sales = Quantity * Price
-- Expetation: No Results
SELECT DISTINCT
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
  OR sls_sales IS NULL
  OR sls_quantity IS NULL
  OR sls_price IS NULL
  OR sls_sales <= 0
  OR sls_quantity <= 0
  OR sls_price <= 0
ORDER BY   sls_sales,  sls_quantity,  sls_price;

-- ======================================================
-- Checking 'silver.erp_cust_az12'
-- ======================================================
-- Identify Out-of-Range Dates
-- Expetation: Birthdates between '1924-01-01 and Today
SELECT DISTINCT
    bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01'
OR bdate > GETDATE();

-- Data Standardization and Consistency
SELECT DISTINCT
    gen
FROM silver.erp_cust_az12;

-- ======================================================
-- Checking 'silver.erp_loc_a101'
-- ======================================================
-- Data Standardization & Consistency
SELECT DISTINCT
    cntry
FROM silver.erp_loc.a101
ORDER BY cntry;

-- ======================================================
-- Checking 'silver.erp_px_cat_g1v2'
-- ======================================================
-- Check for unwanted spaces 
-- Expetation: No Results
SELECT 
  *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
OR subcat != TRIM(subcat)
OR maintenance != TRIM(maintenance);

--Data Standardization & Consistency
SELECT DISTINCT
  maintenance
FROM silver.erp_px_cat_g1v2;
