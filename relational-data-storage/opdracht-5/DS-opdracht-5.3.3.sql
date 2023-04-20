select sp.name, ifnull(dir.contact,"t.a.v directie") as contact, vl.adres, vl.postcode, vl.stad
from
mhl_suppliers as sp
left join 
	directie as dir on sp.id = dir.ID
left join verzendlijst as vl on vl.ID=sp.id