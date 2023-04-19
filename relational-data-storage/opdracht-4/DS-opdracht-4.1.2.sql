SELECT 
    sp.name, sp.straat, sp.huisnr, sp.postcode
FROM
    mhl_suppliers AS sp
        LEFT JOIN
    mhl_cities AS c ON sp.city_ID = c.id
    left join 
    mhl_communes as com on c.commune_ID = com.id
WHERE
    com.name = 'Steenwijkerland'