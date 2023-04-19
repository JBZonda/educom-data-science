SELECT 
    sp.name,
    sp.straat,
    sp.huisnr,
    sp.postcode
FROM
    mhl_suppliers AS sp
        LEFT JOIN
    mhl_yn_properties AS yn ON sp.id = yn.supplier_ID
        LEFT JOIN
    mhl_propertytypes AS prop ON yn.propertytype_ID = prop.id
WHERE
    (prop.name = 'ook voor particulieren'
        AND yn.content = 'Y')
        OR (prop.name = 'specialistische leverancier'
        AND yn.content = 'Y')
ORDER BY sp.name