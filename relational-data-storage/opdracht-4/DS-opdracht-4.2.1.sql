SELECT 
    c1.name, c1.id, c1.commune_ID, com1.name
FROM
    mhl_cities AS c1
        LEFT JOIN
    mhl_communes AS com1 ON c1.commune_ID = com1.id
WHERE
    com1.name IS NULL
ORDER BY c1.name