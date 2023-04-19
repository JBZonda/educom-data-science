SELECT 
    sp.name, sp.straat, sp.huisnr, sp.postcode
FROM
    mhl_suppliers AS sp
        LEFT JOIN
    mhl_cities AS c ON sp.city_ID = c.id
		left join 
	mhl_suppliers_mhl_rubriek_view as sup_rub on sp.id=sup_rub.mhl_suppliers_ID
		left join
	mhl_rubrieken as rub on sup_rub.mhl_rubriek_view_ID=rub.id
		left join
	mhl_rubrieken as rub_parent on rub.parent=rub_parent.id
    
WHERE
    c.name = 'Amsterdam' AND ( rub.name = "drank" OR rub_parent.name="drank")
order by rub.name, sp.name