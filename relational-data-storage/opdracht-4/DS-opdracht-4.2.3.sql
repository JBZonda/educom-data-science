-- V1 met een union

SELECT 
    r1.id,
    r1.name AS hoofdrubriek,
    sr.name AS subrubriek
FROM
    mhl_rubrieken AS r1
        LEFT JOIN
    mhl_rubrieken AS sr ON sr.parent = r1.id
WHERE
    r1.parent = 0
UNION 
SELECT 
    r.id, r.name,null
FROM
    mhl_rubrieken AS r
WHERE
    r.parent = 0
order by hoofdrubriek,subrubriek;

-- V2 zonder union
SELECT 
    sr.id,
    IFNULL(r.name, sr.name) AS hoofdrubriek,
    IF(ISNULL(r.name), '', sr.name) AS subrubriek
FROM
    mhl_rubrieken AS r
        RIGHT JOIN
    mhl_rubrieken AS sr ON sr.parent = r.id
ORDER BY hoofdrubriek , subrubriek


