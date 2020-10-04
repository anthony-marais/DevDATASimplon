SHOW DATABASES;
use sakila;
show tables from sakila;


##
CREATE VIEW sakila.role AS
SELECT a.actor_id,a.last_name,a.first_name,
        f.film_id,f.title,f.description,f.release_year,
        f.language_id,f.original_language_id,
        f.rental_duration,f.rental_rate,f.length,
        #f.replacement_cost,
        f.rating
        #,f.special_features
FROM actor as a
INNER JOIN film_actor as fa on a.actor_id = fa.actor_id
INNER JOIN film as f ON f.film_id = fa.film_id;




##
DELIMITER $$
CREATE FUNCTION sakila.nom_prenom (nom VARCHAR(45),prenom VARCHAR(45))
RETURNS varchar(91)
BEGIN
declare nom_prenom varchar(91);
SET nom_prenom = CONCAT(nom, " ", prenom);
RETURN nom_prenom;
END$$
DELIMITER ;




##
SELECT distinct nom_prenom(r.last_name, r.first_name)
FROM role as r
where r.film_id IN (    SELECT distinct r2.film_id
                        FROM role as r2
                        where r2.first_name = 'CARY' and r2.last_name = 'MCCONAUGHEY'    )
and (r.first_name <> 'CARY' and r.last_name <> 'MCCONAUGHEY')
AND r.actor_id != (SELECT actor_id FROM actor WHERE actor.first_name = "CARY" AND actor.last_name = "MCCONAUGHEY");

##
DELIMITER $$$
CREATE PROCEDURE same_film_actors (IN NOM varchar(55), PRENOM varchar(55))
BEGIN

SELECT DISTINCT nom_prenom(r.last_name, r.first_name)
FROM role as r
where r.film_id IN (    SELECT distinct r2.film_id
                        FROM role as r2
                        where r2.first_name = PRENOM and r2.last_name = NOM    )
and (r.first_name <> PRENOM and r.last_name <> NOM)
AND r.actor_id != (    SELECT actor_id 
                    FROM actor 
                    WHERE actor.first_name = PRENOM 
                    AND actor.last_name = NOM);
END$$$
DELIMITER ;

CALL `sakila`.`same_film_actors`('MCCONAUGHEY', 'CARY');
CALL `sakila`.`same_film_actors`('TORN', 'KENNETH');