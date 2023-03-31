# 1
# First Query to Select Columns Needed + Removed Any duplicate ranking since that is the primary key for the table
  SELECT 
    DISTINCT Rank,
    Name, 
    Year,
    Platform,
    Global_Sales,
    Genre 
  FROM `capstone-24544.VG_Sales.vg_sales`