select DATE_FORMAT(sp.joindate,"%d.%m.%Y") as joindate, sp.id
from
mhl_suppliers as sp
where datediff(LAST_DAY(sp.joindate),sp.joindate) <= 7
