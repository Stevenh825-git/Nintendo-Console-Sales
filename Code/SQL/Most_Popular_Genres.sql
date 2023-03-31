# Query to find the most popular genre for each manufacturer

# Temporary table to see what was the biggest sales for each manufactuerer
WITH genre AS (
  SELECT
    Console_Manafacturer,
    MAX(Total_Sales_Millions) AS Max_Sales_Millions,
  FROM
  ( # Table to see how many copies were sold for each genre, split by manufacturer
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
  ) AS genre1
  GROUP BY
    Console_Manafacturer
)

# Takes the max sales for each manufacturer from the temporary table genre
# Left Joins it with the table with sales for each genre by manufacturer to find the genre 
SELECT
  genre2.Genre,
  genre.Console_Manafacturer,
  genre2.Total_Sales_Millions
FROM genre
LEFT JOIN
(
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
) AS genre2 ON genre.Max_Sales_Millions = genre2.Total_Sales_Millions
