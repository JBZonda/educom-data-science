select concat_ws(" - ",hoofd_r.name,sub_r.name) as name, count(sr.id)
from 
	mhl_rubrieken as hoofd_r
right join
	mhl_rubrieken as sub_r on sub_r.parent=hoofd_r.id
left join 
	mhl_suppliers_mhl_rubriek_view as sr on sub_r.id=sr.mhl_rubriek_view_ID

group by name
order by name