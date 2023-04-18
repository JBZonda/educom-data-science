SELECT 
    sp.name, sp.straat, sp.huisnr, sp.postcode
FROM
    mhl_suppliers AS sp
WHERE  sp.huisnr > 10 and sp.huisnr < 20