SELECT 
    sp.name, sp.straat, sp.huisnr, sp.postcode, ll.lat, ll.lng
FROM
    mhl_suppliers AS sp
        LEFT JOIN
    pc_lat_long AS ll ON ll.pc6 = sp.postcode
ORDER BY ll.lat DESC
LIMIT 5