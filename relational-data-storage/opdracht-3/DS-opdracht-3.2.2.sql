SELECT 
    sp.name, sp.straat, sp.huisnr, sp.postcode
FROM
    mhl_suppliers AS sp
        LEFT JOIN
    mhl_membertypes AS m ON sp.membertype = m.id
WHERE
    m.name = 'Gold'
        OR m.name = 'Silver'
        OR m.name = 'Bronze'
        OR m.name = 'GEEN INTERESSE'