##use sakila;


DELIMITER aie
CREATE PROCEDURE charactere(IN titre VARCHAR(128), OUT title_char VARCHAR(128))
BEGIN
	SELECT COUNT(title)
    FROM film
    
    WHERE title LIKE titre
    INTO title_char;
ENDaie
DELIMITER ;
CALL charactere("%din%", @title_char);
SELECT @title_char;



DELIMITER aie
CREATE PROCEDURE charactereListe(IN titre VARCHAR(128))
BEGIN
	SELECT title
    FROM film
    
    WHERE title LIKE CONCAT("%", titre, "%");
ENDaie
DELIMITER ;
CALL charactereListe("din");

DROP PROCEDURE charactere;
DROP PROCEDURE charactereListe;
