SELECT 
    sp.name, sp.straat, sp.huisnr, sp.postcode, com.name, dis.name
FROM
    mhl_suppliers AS sp
    left join 
    mhl_cities as c on sp.city_ID=c.id
    left join
    mhl_communes as com on c.commune_ID=com.id
    left join
    mhl_districts as dis on dis.id= com.district_ID

where
dis.name = "Limburg" or dis.name = "Noord-Braband" or dis.name = "Zuid-Holland"
