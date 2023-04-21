-- ASSIGNMENT #2 : Alter the code from the procedure p_get_total_order() so it only summarizes the order per given customer.
DELIMITER $$
CREATE PROCEDURE p_get_total_order_of(IN customer_number int)
BEGIN
    DECLARE totalOrder INT DEFAULT 0;
    
    SELECT COUNT(*) 
    INTO totalOrder
    FROM orders
    where customerNumber = customer_number;
    
    SELECT totalOrder;
END$$

DELIMITER ;

-- testing 
SELECT * FROM orders;
call p_get_total_order_of(114);