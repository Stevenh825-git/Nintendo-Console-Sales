# 7
# This is to fix the year cell for 2 games that were incorrect
SELECT 
  Name,
  IF(Platform = 'DS' AND Name ='Strongest Tokyo University Shogi DS', '2010',IF(Platform = 'GB' AND Name = "Disney's DuckTales", '1989',Year)) AS Year,
Global_Sales, Platform, Genre, Console_Manafacturer
FROM `capstone-24544.VG_Sales.console_manufacturer`
ORDER BY
  Global_Sales DESC
