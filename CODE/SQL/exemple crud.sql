use sakila ;

DROP PROCEDURE IF EXISTS "PI_Customer";

DELIMITER ||

CREATE PROCEDURE "PI_Customer" ()

BEGIN
	IF (1!=1) THEN
    BEGIN
		select * FROM customer;
		SELECT 
    *
FROM
    actorCATEGORY_CATALOGUE;
	
    ELSE
    BEGIN
		select "hello world";
	END
    END IF;
    
