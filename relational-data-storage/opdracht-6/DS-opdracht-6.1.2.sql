SELECT 
    com.name, sp.name, sum(ht.hitcount) as total_hitcount, average_hitcount.avg
FROM
    mhl_suppliers AS sp
        LEFT JOIN
    mhl_cities AS c ON c.id = sp.city_ID
        LEFT JOIN
    mhl_communes AS com ON c.commune_ID = com.id
        LEFT JOIN
    mhl_hitcount AS ht ON ht.supplier_ID = sp.id
		left join 
-- set the avg per commune
	(select com.id, AVG(ht.hitcount) as avg
    from 
     mhl_suppliers AS sp
        LEFT JOIN
    mhl_cities AS c ON c.id = sp.city_ID
        LEFT JOIN
    mhl_communes AS com ON c.commune_ID = com.id
        LEFT JOIN
    mhl_hitcount AS ht ON ht.supplier_ID = sp.id
    group by com.name
    ) as average_hitcount on average_hitcount.id=com.id
WHERE
    com.name IS NOT NULL
group by sp.name
ORDER BY com.name, total_hitcount desc