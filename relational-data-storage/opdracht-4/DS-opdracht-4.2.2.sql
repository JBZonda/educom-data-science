SELECT 
    c1.name, ifnull(com1.name,"INVALID")
FROM
    mhl_cities AS c1
        LEFT JOIN
    mhl_communes AS com1 ON c1.commune_ID = com1.id