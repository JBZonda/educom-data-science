
SELECT 
    sp.name AS leverancier,
    IFNULL(ct.name, 'tav de directie') AS aanhef,
    if(sp.p_address="",CONCAT(sp.straat," ",sp.huisnr), sp.p_address) AS adres,
    if(sp.p_address="",sp.postcode,sp.P_postcode) as postcode, if(sp.p_address <> "",p_c.name,c.name) as stad, if(sp.p_address <> "",p_dis.name,dis.name) as prov
FROM
    mhl_suppliers AS sp
		Left join
	mhl_cities as c on c.id = sp.city_ID
        LEFT JOIN
	mhl_communes as com on c.commune_ID=com.id
		Left join
	mhl_districts as dis on com.district_ID=dis.id
		left join
    mhl_contacts AS ct on ct.supplier_ID = sp.id and ct.department=3
		Left join
	mhl_cities as p_c on p_c.id = sp.p_city_ID
        LEFT JOIN
	mhl_communes as p_com on p_c.commune_ID=p_com.id
		Left join
	mhl_districts as p_dis on p_com.district_ID=p_dis.id
    where postcode <> ""
	order by  prov, stad, sp.name
