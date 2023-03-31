# Query to see how many sales there are for each genre between different manufacturers
# Also keeps track of how many titles in the genre and the average sales
SELECT
  Genre,
  Console_Manafacturer,
  ROUND(SUM(Global_Sales),3) AS Total_Sales_Millions,
  COUNT(*) AS Total_Titles,
  AVG(Global_Sales) AS AVG_Sales
FROM `capstone-24544.Cleaned_Data.Fixed_Year` 
GROUP BY 
  Genre, Console_Manafacturer
ORDER BY
  Total_Sales_Millions DESC
