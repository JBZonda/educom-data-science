
SELECT 
    sp.name AS leverancier,
    IFNULL(contact_name, 'tav de directie') AS aanhef,
    if(sp.p_address="",CONCAT(sp.straat," ",sp.huisnr), sp.p_address) AS adres,
    sp.postcode, c.name as stad, dis.name as prov
FROM
    mhl_suppliers AS sp
		Left join
	mhl_cities as c on c.id = sp.city_ID
        LEFT JOIN
	mhl_communes as com on c.commune_ID=com.id
		Left join
	mhl_districts as dis on com.district_ID=dis.id
		left join
    (SELECT 
        ct.supplier_ID AS suplier_ID, ct.name AS contact_name
    FROM
        mhl_contacts AS ct
    LEFT JOIN mhl_departments AS dep ON ct.department = dep.id
    WHERE
        dep.name = 'Directie') AS ct ON ct.suplier_ID = sp.id
	where sp.p_address !="" or sp.straat != ""
	order by dis.name, c.name, sp.name
