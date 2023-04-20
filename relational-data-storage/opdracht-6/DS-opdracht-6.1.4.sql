select concat_ws(" - ",hoofd_r.name,sub_r.name) as name, ifnull(count.total,"Geen hits") as total
from 
	mhl_rubrieken as hoofd_r
right join
	mhl_rubrieken as sub_r on sub_r.parent=hoofd_r.id
left join     
(select r.id, sum(hitcount) as total
from mhl_suppliers_mhl_rubriek_view as srv
left join mhl_rubrieken as r on srv.mhl_rubriek_view_ID=r.id
inner join 
	mhl_hitcount as hc on srv.mhl_suppliers_ID=hc.supplier_ID

where r.name  is not null
group by srv.mhl_rubriek_view_ID    
order by r.name)
as count on count.id=sub_r.id
group by name
order by name