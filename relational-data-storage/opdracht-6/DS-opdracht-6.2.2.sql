select sp.id, joindate, datediff(curdate(),joindate) as dagen_lid
from mhl_suppliers as sp
order by dagen_lid