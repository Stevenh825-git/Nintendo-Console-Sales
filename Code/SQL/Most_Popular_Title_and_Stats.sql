# Query to find the most popular title for each console/platform
# Also gives insight for each platform
#       -Total, min, max, and average sales
SELECT
  cleaned.Platform,
  Name AS Most_Popular_Title,
  sales.Max_Sales,
  sales.Min_Sales,
  sales.Avg_Sales,
  sales.Total_Sales_Millions
FROM `capstone-24544.Cleaned_Data.Fixed_Year`  AS cleaned
RIGHT JOIN
  ( #This generates a table where each platform is grouped, and filtered by manafacturer 
  SELECT
    Platform,
    Count(*) AS Num_of_Titles, 
    Min(Global_Sales) AS Min_Sales,
    Max(Global_Sales) AS Max_Sales,
    AVG(Global_Sales) AS Avg_Sales,
    ROUND(SUM(Global_Sales),3) AS Total_Sales_Millions
  FROM `capstone-24544.Cleaned_Data.Fixed_Year` 
  GROUP BY
    Platform
  ) AS sales ON sales.Max_Sales = cleaned.Global_Sales
WHERE  #Ensures we are looking at the data where the global_sales and platform match between the two dataset
  sales.Platform = cleaned.Platform
