# Query to find out how many copies were sold in a year for every console
# Also, how many titles were released that year
SELECT 
  Year,
  Platform,
  Count(*) AS Total_Titles,
  ROUND(SUM(Global_Sales),2) AS Games_Sold_Mill
FROM `capstone-24544.Cleaned_Data.Fixed_Year` 
GROUP BY 
  Year, Platform
Order BY 
  Year 