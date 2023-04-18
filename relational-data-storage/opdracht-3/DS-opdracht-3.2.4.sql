SELECT 
    sp.name, sp.straat, sp.huisnr, sp.postcode
FROM
    mhl_suppliers AS sp
        LEFT JOIN
    mhl_cities AS c ON sp.city_ID = c.id
        LEFT JOIN
    mhl_cities AS c2 ON sp.p_city_ID = c2.id
WHERE
    c.name = 'Amsterdam'
        OR c2.name = 'Den Haag'