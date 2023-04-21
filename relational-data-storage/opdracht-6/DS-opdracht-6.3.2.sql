/*
gebruik gemaakt van een functie die de html code vervangt met ht teken
Gevonden op: https://stackoverflow.com/questions/3678980/is-there-a-mysql-function-to-decode-html-entities
heeft form als:
DELIMITER $$ HTML_UnEncodeHTML_UnEncode
    DROP FUNCTION IF EXISTS `HTML_UnEncode`$$ 
    CREATE FUNCTION `HTML_UnEncode`(X VARCHAR(255)) RETURNS VARCHAR(255) CHARSET latin1 DETERMINISTIC
    BEGIN 
    DECLARE TextString VARCHAR(255) ; 
    SET TextString = X ; 

#small a, tilde 
    IF INSTR( X , '&atilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&atilde;','ã') ; 
    END IF ; 
etc
 RETURN TextString ; 

    END$$ 

    DELIMITER ;
*/

SELECT 
    sp.name, HTML_UnEncode(sp.name)
FROM
    mhl_suppliers AS sp
where sp.name like "%&%;%" 