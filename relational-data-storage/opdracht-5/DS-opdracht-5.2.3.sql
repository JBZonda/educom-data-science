-- totale hits per kwartaal en totaal voor elk jaar
SELECT 
    year,
    SUM(IF(month BETWEEN 1 AND 3, hitcount, 0)) AS Q1,
    SUM(IF(month BETWEEN 4 AND 6, hitcount, 0)) AS Q2,
    SUM(IF(month BETWEEN 7 AND 9, hitcount, 0)) AS Q3,
    SUM(IF(month BETWEEN 10 AND 12, hitcount, 0)) AS Q4,
    SUM(hitcount) AS Totaal
FROM
    mhl_hitcount
GROUP BY year
