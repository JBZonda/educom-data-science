--  
-- aantal gold silver bronze en other members per stad
-- gesorteerd op gold->silver->bronze->other

select c.name, SUM(if(mt.name="Gold",1,0)) as Gold, SUM(if(mt.name="Silver",1,0)) as Silver, SUM(if(mt.name="Bronze",1,0)) as Bronze,
SUM(if(mt.name <> "Gold" and mt.name <> "Silver" and mt.name <> "Bronze",1,0)) as Other
from mhl_suppliers as sp
left join mhl_cities as c on c.id = sp.city_ID 
left join mhl_membertypes as mt on sp.membertype=mt.id
group by sp.city_ID
order by Gold desc, Silver desc, Bronze desc, Other desc