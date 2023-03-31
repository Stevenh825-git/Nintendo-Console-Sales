# 2
#Removed any rows with missing global_sales value and Year
WITH removedEmptyVal AS(
  SELECT 
    *
  FROM `capstone-24544.VG_Sales.filtered_columns` 
  WHERE
    Global_Sales is NOT NULL AND
    Year <> 'N/A' )
#Checking if values in column are valid
SELECT
  Year, Platform 
FROM removedEmptyVal
GROUP BY Year, Platform
ORDER BY Year ASC