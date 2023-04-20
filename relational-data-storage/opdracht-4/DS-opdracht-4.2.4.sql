-- V1 not set properties niet gejoined
select sp.name as suplier, pr_ty.name as property, ifnull(yn.content,"NOT SET") as value
from mhl_yn_properties as yn
left join mhl_propertytypes as pr_ty on yn.propertytype_ID=pr_ty.id
right join mhl_suppliers as sp on yn.supplier_ID=sp.id
left join mhl_cities as c on sp.city_ID=c.id
where c.name="Amsterdam";

-- V2 join de niet gezette properties (Taxaties staat niet in de db voor zover ik kan zien)

SELECT 
    sp.name, propeties.name, ifnull(yn.content,"NOT SET") as value
FROM
    mhl_suppliers AS sp
        LEFT JOIN
    mhl_cities AS c ON sp.city_ID = c.id
        LEFT JOIN
    (SELECT 
        pr_ty.name
    FROM
        mhl_propertytypes AS pr_ty
    WHERE
        pr_ty.name = ANY (SELECT 
                pr_ty.name
            FROM
                mhl_yn_properties AS yn
            LEFT JOIN mhl_propertytypes AS pr_ty ON yn.propertytype_ID = pr_ty.id)) AS propeties ON TRUE
            
		LEFT JOIN
    mhl_propertytypes AS pr_ty ON propeties.name = pr_ty.name
		LEFT JOIN
    mhl_yn_properties AS yn ON yn.supplier_ID = sp.id and yn.propertytype_ID = pr_ty.id
        
WHERE
    c.name = 'Amsterdam'
ORDER BY sp.id