SELECT 
    YEAR(sp.joindate) AS yr,
    MONTHNAME(sp.joindate) AS mth,
    COUNT(sp.id) AS 'Aantal aanmelingen'
FROM
    mhl_suppliers AS sp
GROUP BY yr , mth
ORDER BY yr , MONTH(sp.joindate)
