SELECT 
    DAYNAME(sp.joindate) AS 'Dag van de week',
    COUNT(sp.id) AS 'Aantal aanmelingen'
FROM
    mhl_suppliers AS sp
GROUP BY DAYNAME(sp.joindate)
ORDER BY DAYOFWEEK(sp.joindate);
