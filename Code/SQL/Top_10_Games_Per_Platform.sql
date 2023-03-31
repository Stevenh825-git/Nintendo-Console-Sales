# Provides the Top 10 Games within each platform
SELECT
  Name, Platform, Global_Sales, Console_Manafacturer, ranking
FROM
  # Creates a table where a column with the rank is added
  (SELECT 
    Name,
    Platform,
    Global_Sales,
    Console_Manafacturer,
    row_number() over (partition by Platform order by  Global_Sales desc) AS ranking
          #the data is grouped by platform ordered by sales to provide ranking with row_number()
  FROM `capstone-24544.Cleaned_Data.Fixed_Year` )
WHERE ranking <= 10
ORDER BY
  Console_Manafacturer 