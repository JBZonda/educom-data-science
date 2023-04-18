SELECT 
    sp.name, sp.straat, sp.huisnr, sp.postcode
FROM
    mhl_suppliers AS sp
        LEFT JOIN
    mhl_cities AS c ON sp.city_ID = c.id
WHERE
    c.name = "Amsterdam"