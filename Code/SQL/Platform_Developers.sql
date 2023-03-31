# 5
# Obtain all the Video Game platforms, and include a seperate column for
# what developer owns the console 

SELECT
  DISTINCT Platform,
  IF(Platform IN ('Wii', 'NES', 'GB', 'DS', 'SNES', 'GBA', '3DS', 'N64', 'GC', 'WiiU'),'Nintendo',
    IF(Platform IN ('PS','PS2', 'PS3','PS4','PSP','PSV'),'Sony',
    IF(Platform IN ('X360','XB','XOne'),'Microsoft',
    IF(Platform IN ('GEN','Dreamcast','SAT', 'SEGA CD', 'GG'),'Sega','Other')))) AS Console_Manafacturer 

FROM `capstone-24544.VG_Sales.CleanedTable`