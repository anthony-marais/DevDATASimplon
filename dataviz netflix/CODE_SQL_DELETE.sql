use netflix;


SELECT director from DIRECTOR
WHERE director_id NOT IN(SELECT director_id FROM DIRECTOR_CATALOGUE);


INSERT INTO DIRECTOR (director) VALUES ('ANTHONY MARAIS');


SET SQL_SAFE_UPDATES = 0;
DELETE FROM DIRECTOR WHERE director_id 
NOT IN(SELECT director_id FROM DIRECTOR_CATALOGUE);


USE netflix;

DROP PROCEDURE IF EXISTS checkDirector;

DELIMITER fin
CREATE PROCEDURE checkDirector(IN director_name VARCHAR(100))
IF EXISTS(SELECT * FROM director WHERE director.director_name = director_name)
THEN
    IF NOT EXISTS(SELECT * FROM catalog_director JOIN director ON catalog_director.director_id = director.director_id WHERE director.director_name = director_name)
    THEN
        DELETE FROM director WHERE director.director_id = director_id;
    END IF;
END IF fin



DELIMITER $$
DROP PROCEDURE IF EXISTS director_test $$
CREATE PROCEDURE director_test (IN director_test VARCHAR(50))

sortie :

BEGIN
DECLARE nb_film INT;
START TRANSACTION;
delete from director where director= director_test;

SET nb_film = (select count(title) from shows
    right join show_director on shows.show_id=show_director.show_id
    right join director on show_director.director_id=director.director_id
    and director like director_test);

IF (nb_film > 0) THEN
    ROLLBACK;
    LEAVE sortie;
END IF;
COMMIT;
END $$
DELIMITER ;










SELECT CATALOGUE.show_id ,  DIRECTOR.director
FROM CATALOGUE 
JOIN DIRECTOR_CATALOGUE ON CATALOGUE.show_id = DIRECTOR_CATALOGUE.show_id 
JOIN DIRECTOR ON DIRECTOR_CATALOGUE.director_id = DIRECTOR.director_id
WHERE DIRECTOR.director_id 
NOT IN(SELECT director_id FROM DIRECTOR_CATALOGUE);

INSERT INTO DIRECTOR (director) VALUES ('ANTHONY MARAIS');


SELECT director, director_id FROM DIRECTOR 
WHERE director = 'ANTHONY MARAIS';


SELECT director from DIRECTOR
WHERE director_id NOT IN(SELECT director_id FROM DIRECTOR_CATALOGUE);