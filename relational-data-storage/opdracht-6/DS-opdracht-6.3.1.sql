SELECT 
    c.name,
    IF(SUBSTRING(c.name, 1, 1) = "'",
        CONCAT(SUBSTRING(c.name, 1, 3),
                UPPER(SUBSTRING(c.name, 4, 1)),
                SUBSTRING(c.name, 5)),
        CONCAT(UPPER(SUBSTRING(c.name, 1, 1)),
                SUBSTRING(c.name, 2))) AS nice_name
FROM
    mhl_cities AS c
GROUP BY c.id
ORDER BY c.name;
