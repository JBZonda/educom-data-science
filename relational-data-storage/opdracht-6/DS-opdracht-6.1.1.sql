/*create view maanden_nederlands (id,maand) as
select 1,"Januari"
union
select 2,"Februari"
union
select 3,"Maart"
union
select 4,"April"
union
select 5,"Mei"
union
select 6,"Juni"
union
select 7,"Juli"
union
select 8,"Augustus"
union
select 9,"September"
union
select 10,"Oktober"
union
select 11,"November"
union
select 12,"December";*/

SELECT 
    year,
    mn.maand AS maand,
    count(ht.supplier_ID/*sp.id*/)/*SUM(IF(sp.joindate <= CONCAT(ht.year, '-', if(ht.month<10,"0",""),ht.month , '-00'),
        1,
        0))*/ AS 'aantal leveranciers',
    SUM(hitcount) AS 'toataal aantal hits'
FROM
    mhl_hitcount AS ht
        /*LEFT JOIN
    mhl_suppliers AS sp ON ht.supplier_ID = sp.id*/
        LEFT JOIN
    maanden_nederlands AS mn ON mn.id = ht.month
GROUP BY year , month
ORDER BY year DESC , maand
