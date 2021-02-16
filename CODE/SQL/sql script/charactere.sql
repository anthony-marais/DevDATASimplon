CREATE PROCEDURE characteres (IN titre VARCHAR(128), OUT title_char VARCHAR(128))
BEGIN
	SELECT title 
    FROM film
    WHERE titre LIKE title_char;
END
