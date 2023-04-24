-- add the coms
ALTER TABLE employees
ADD  column salary DECIMAL(10,2) NOT NULL AFTER email,
ADD  column date_hired DATE NOT NULL default NOW() AFTER email,
ADD  column date_fired  DATE AFTER email;

-- employeeArchive table
CREATE TABLE employeeArchive (
    employeeNumber INT,
    firstName varchar(50),
    lastName varchar(50),
    email varchar(100),
    date_hired DATE,
    date_fired DATE NOT NULL DEFAULT NOW(),
    PRIMARY KEY (employeeNumber)
);

-- fire employee
DROP TRIGGER IF EXISTS employee_bur;
DELIMiter $$

CREATE TRIGGER employee_bur
BEFORE update
ON employees FOR EACH ROW
BEGIN
	IF new.date_fired <> old.date_fired then
		INSERT INTO employeeArchive(employeeNumber,firstName,lastName, email, date_hired,date_fired)
		VALUES(OLD.employeeNumber,OLD.firstName, OLD.lastName, OLD.email, OLD.date_hired, new.date_fired)
         ON DUPLICATE KEY UPDATE date_fired=new.date_fired;
    END IF;
    
END$$    
DELIMITER ;

select * from employeearchive;
select * from employees;

update employees
set date_fired = NOW()
where employeeNumber=1076;

-- fired function
DROP FUNCTION IF EXISTS f_is_fired;
DELIMITER $$
CREATE FUNCTION f_is_fired(
emplNum int(11)
)
returns varchar(10)
DETERMINISTIC
Begin
 declare return_text varchar(10);
 declare fd DATE;
 
 select date_fired
 into fd
 from employees
 where employeeNumber=emplNum;
 
 IF isnull(fd) THEN
	set return_text="";
	else
		set return_text="FIRED";
 END IF;
 return return_text;
END $$
DELIMITER ;

select f_is_fired(1076);
select f_is_fired(1006);

CREATE view v_emploeymentStatus
as
SELECT
	employeeNumber, lastName,firstName, f_is_fired(employeeNumber) as "Employment status"
from employees;

-- raise procedure
DROP procedure IF EXISTS p_give_all_raise;
DELIMITER $$
CREATE procedure p_give_all_raise(percentage dec(4,2))
BEGIN
	UPDATE employees SET salary = salary * (1 + percentage);
END$$

DELIMITER ;

select * from employees;
call p_give_all_raise(0.05);
select * from employees;

-- remove fired employees
DROP procedure IF EXISTS p_remove_fired_employees;
DELIMITER $$
CREATE procedure p_remove_fired_employees()
BEGIN
	
    delete from employees
    where f_is_fired(employeeNumber)="FIRED";
    
END$$

DELIMITER ;






