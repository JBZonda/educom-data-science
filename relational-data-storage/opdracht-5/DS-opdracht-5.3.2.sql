CREATE VIEW verzendlijst
AS
select sp.id as ID, if(sp.p_address <> "",sp.p_address,CONCAT(sp.straat," ",sp.huisnr)) as adres,
if(sp.p_address <> "",sp.p_postcode,sp.postcode) as postcode,
if(sp.p_address <> "",p_c.name,c.name) as stad
from mhl_suppliers as sp
left join 
	mhl_cities as c on c.id = sp.city_ID
left join 
	mhl_cities as p_c on p_c.id = sp.p_city_ID;
    
SELECT 
    *
FROM
    verzendlijst
