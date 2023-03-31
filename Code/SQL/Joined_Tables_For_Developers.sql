# 6
# Made a Left Join to include information on the publisher
SELECT
  Name, Year, Global_Sales, cleaned.Platform, Genre, platDev_list.Console_Manafacturer
FROM `capstone-24544.VG_Sales.CleanedTable` AS cleaned
LEFT JOIN 
  `capstone-24544.VG_Sales.Platform_Devoloper_List` as platDev_list ON cleaned.Platform = platDev_list.Platform
ORDER BY
  Global_Sales DESC