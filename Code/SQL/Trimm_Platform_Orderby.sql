# 4
# Removed Trailing spaces in Name and Genre Column
# Fixed Unclear console names in the platform column
# Sorted the data by global sales in descending order
SELECT
  TRIM(Name) AS Name,
  Year,
  Global_Sales,
  CASE
    WHEN Platform = 'NG' THEN 'Neo-Geo'
    WHEN Platform = 'TG16' THEN 'TurboGrafx-16'
    WHEN Platform = 'SCD' THEN 'SEGA CD'
    WHEN Platform = 'DC' THEN  'Dreamcast'
    ELSE Platform
    END AS Platform,
  Trim(Genre) AS Genre
FROM `capstone-24544.VG_Sales.Removed_NA`
ORDER BY
  Global_Sales DESC