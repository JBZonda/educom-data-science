SELECT 
	sp.name, SUM(hitcount) as numhits,
    
    COUNT(hitcount) as nummonths,
    round(AVG(hitcount)) as avgpermonth
    
FROM
    mhl_hitcount as hc
    left join mhl_suppliers as sp on hc.supplier_ID=sp.id
group by sp.name
order by avgpermonth desc
