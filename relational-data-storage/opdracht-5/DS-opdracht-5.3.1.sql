CREATE VIEW directie
AS
SELECT sp.id as ID,con.name as contact, con.contacttype as functie, dep.name as department
from
		mhl_contacts as con
inner join 
		mhl_departments as dep on dep.id=con.department
left join 
	mhl_suppliers as sp on con.supplier_ID=sp.id
where  dep.name="Directie" OR con.contacttype like "%directeur%";

select * from directie;



        

