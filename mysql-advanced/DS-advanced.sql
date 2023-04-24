-- The following SELECT statement returns all rows in the table customers from the sample database:
SELECT 
    customerName, 
    city, 
    state, 
    postalCode, 
    country
FROM
    customers
ORDER BY customerName;

-- The following CREATE PROCEDURE statement creates a new stored procedure that wraps the query above:
DELIMITER $$

CREATE PROCEDURE p_get_customers()
BEGIN
    SELECT 
        customerName, 
        city, 
        state, 
        postalCode, 
        country
    FROM
        customers
    ORDER BY customerName;    
END$$

DELIMITER ;

-- Once you save the stored procedure, you can invoke it by using the CALL statement:
call p_get_customers();

-- Listing stored procedures (werkt niet)
SHOW PROCEDURE STATUS LIKE 'p_%';

-- Or with a query:
SELECT  routine_name
FROM information_schema.routines
WHERE routine_type = 'PROCEDURE'
  AND routine_schema = 'sales';

-- The stored procedure language is mostly constructed as any other procedural language. Analyze this stored procedure:
DELIMITER $$

CREATE PROCEDURE p_get_total_order()
BEGIN
    DECLARE totalOrder INT DEFAULT 0;
    
    SELECT COUNT(*) 
    INTO totalOrder
    FROM orders;
    
    SELECT totalOrder;
END$$

DELIMITER ;

select count(*) from orders;
call p_get_total_order();

-- We need to declare a variable before we can use it:

DECLARE varname datatype [default value];

# Multiple (same type): 

DECLARE x, y INT DEFAULT 0;

-- If your procedure has an OUT parameter however, the call is a little different:
DELIMITER $$

CREATE PROCEDURE p_get_ordercount_by_status(
    IN  orderStatus VARCHAR(25),
    OUT total INT
)
BEGIN
    SELECT COUNT(orderNumber)
    INTO total
    FROM orders
    WHERE status = orderStatus;
END$$

DELIMITER ;


# Calling
call p_get_ordercount_by_status('Shipped', @total);
select @total;

-- The IF-THEN statement allows you to execute a set of SQL statements based on a specified condition. The following illustrates the syntax of the IF-THEN statement:

IF condition THEN 
   statements;
END IF;

-- We’ll use the customers table from the sample database for the demonstration:
DROP PROCEDURE IF EXISTS p_get_customer_level;
DELIMITER $$
CREATE PROCEDURE p_get_customer_level(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL(10,2) DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
	ELSEIF credit <= 50000 AND credit > 10000 THEN
        SET pCustomerLevel = 'GOLD';
    ELSE
        SET pCustomerLevel = 'SILVER';
    END IF;
END$$

DELIMITER ;
-- First off, let's find a customer to meet the criteria:

SELECT  customerNumber, creditLimit
  FROM customers
 WHERE creditLimit > 50000
ORDER BY creditLimit DESC;

-- Customer with ID 141, is a good candidate:

CALL p_get_customer_level(141, @level);
SELECT @level;
-- Adding an ELSE: And call the procedure again:
CALL p_get_customer_level(447, @level);
SELECT @level;
-- ELSEIF And call the procedure again
CALL p_get_customer_level(447, @level);
SELECT @level;

-- CASE
DELIMITER $$

CREATE PROCEDURE p_get_customer_shipping(
    IN pCustomerNUmber INT
)

BEGIN
    
    DECLARE customerCountry VARCHAR(100);
    DECLARE pShipping VARCHAR(50);

    SELECT  country
      INTO customerCountry 
      FROM customers
     WHERE customerNumber = pCustomerNUmber;

    CASE customerCountry
        WHEN 'USA' THEN SET pShipping = '2-day Shipping';
        WHEN 'Canada' THEN SET pShipping = '3-day Shipping';
        ELSE SET pShipping = '5-day Shipping';
    END CASE;
    
    SELECT pShipping;
    
END$$

DELIMITER ;

CALL p_get_customer_shipping(112);

DROP PROCEDURE IF EXISTS p_loop_demo;

DELIMITER $$
CREATE PROCEDURE p_loop_demo()
BEGIN
    DECLARE x  INT;
    DECLARE str  VARCHAR(255);
        
    SET x = 1;
    SET str =  '';
        
    loop_label:  LOOP
        IF  x > 10 THEN 
            LEAVE  loop_label;
        END  IF;
            
        SET  x = x + 1;
        IF  (x mod 2) THEN
            ITERATE  loop_label;
        ELSE
            SET  str = CONCAT(str,x,',');
        END  IF;
    END LOOP;
    SELECT str;
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS p_while_demo;

DELIMITER $$
CREATE PROCEDURE p_while_demo()
BEGIN
    DECLARE x  INT;
    DECLARE str  VARCHAR(255);
        
    SET x = 1;
    SET str =  '';
        
    loop_label:  WHILE X <= 10 DO             
        IF NOT (x mod 2) THEN
            SET  str = CONCAT(str,x,',');
        END  IF;
        SET  x = x + 1;
    END WHILE;
    SELECT str;
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS p_repeat_demo;

DELIMITER $$
CREATE PROCEDURE p_repeat_demo()
BEGIN
    DECLARE x  INT;
    DECLARE str  VARCHAR(255);
        
    SET x = 1;
    SET str =  '';
        
    loop_label:  REPEAT             
        IF NOT (x mod 2) THEN
            SET  str = CONCAT(str,x,',');
        END  IF;
        SET  x = x + 1;
    UNTIL x > 10
    END REPEAT;
    
    SELECT str;
END$$

DELIMITER ;
call p_loop_demo();
call p_while_demo();
call p_repeat_demo();

DROP PROCEDURE IF EXISTS p_create_emaillist;

DELIMITER $$
CREATE PROCEDURE p_create_emaillist (
    INOUT emailList varchar(4000)
)
BEGIN
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE emailAddress varchar(100) DEFAULT "";

    -- declare cursor for employee email
    DEClARE curEmail 
        CURSOR FOR 
            SELECT email FROM employees;

    -- declare NOT FOUND handler
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

    OPEN curEmail;

    getEmail: LOOP
        FETCH curEmail INTO emailAddress;
        IF finished = 1 THEN 
            LEAVE getEmail;
        END IF;
        -- build email list
        SET emailList = CONCAT(emailAddress,";",emailList);
    END LOOP getEmail;
    CLOSE curEmail;

END$$
DELIMITER ;

SET @emailList = ""; 
CALL p_create_emaillist(@emailList); 
SELECT @emailList;
