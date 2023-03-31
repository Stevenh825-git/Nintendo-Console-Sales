# 3
#Removed any rows with missing global_sales value and Year
WITH removedEmptyVal AS(
  SELECT 
    *
  FROM `capstone-24544.VG_Sales.filtered_columns` 
  WHERE
    Global_Sales is NOT NULL AND
    Year <> 'N/A' )
#Getting the table
SELECT
  *
FROM removedEmptyVal