SELECT 
    sp.name, sp.straat, sp.huisnr, sp.postcode
FROM
    mhl_suppliers AS sp
WHERE
    (sp.huisnr between 10 AND 20)
        OR sp.huisnr > 100