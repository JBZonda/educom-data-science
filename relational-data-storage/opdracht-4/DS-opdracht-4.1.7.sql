SELECT 
    c1.name,
    c2.name,
    c1.id,
    c2.id,
    c1.commune_ID,
    c2.commune_ID
FROM
    mhl_cities AS c1
        LEFT JOIN
    mhl_cities AS c2 ON c1.name = c2.name
        LEFT JOIN
    mhl_communes AS com1 ON c1.commune_ID = com1.id
        LEFT JOIN
    mhl_communes AS com2 ON c2.commune_ID = com2.id
WHERE
    c1.id != c2.id
		AND c1.id < c2.id
ORDER BY c1.name