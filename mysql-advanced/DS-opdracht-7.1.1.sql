-- ASSIGNMENT #1 Complete this fragment of code, so it shows the offices in the specified country.
-- Syntax for arguments:

DROP PROCEDURE IF EXISTS p_get_office_by_country;
DELIMITER $$
CREATE PROCEDURE p_get_office_by_country(IN countryName VARCHAR(255))

BEGIN
	select *
    from offices
    where country = countryName;
end$$

DELIMITER ;
-- test
call p_get_office_by_country("USA");
select * from offices;
