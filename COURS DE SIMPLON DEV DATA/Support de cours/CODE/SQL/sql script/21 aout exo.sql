# 1.Reécrire requêtes en utilisant des vues

# 2.Créer des procédures stockées(basées sur les requêtes des semaines passées) avec des paramètres pertinents(ex: nom acteur,
# titre du film, etc) 

# 3.Créer une fonction scalaire qui concatene 2 chaines, et l'utiliser pour concatener nom et prénom des acteurs/actrices.


USE sakila;

#10- Lister les films contenant 'din' dans le titre 

SELECT title FROM film
WHERE title LIKE "%din%";

DELIMITER ||
CREATE PROCEDURE characteres(IN titre VARCHAR(128), OUT title_char VARCHAR(128))
BEGIN
	SELECT "prout" 
    FROM film
    WHERE title LIKE titre;
END||
DELIMITER ;

CALL characteres ('%DIN%',@title_char);
SELECT@title_char;

drop procedure characteres;



#13- Afficher les films ayant été empruntés mais n'ayant pas encore été restitués, triés par date d'emprunt. Afficher seulement les 10 premiers. 
SELECT title , rental.rental_date FROM film 
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.return_date is null
ORDER BY rental.rental_date LIMIT 10;






DELIMITER aie
CREATE PROCEDURE boiteaprout(IN mot VARCHAR(128), OUT titre VARCHAR(128))
BEGIN
	SELECT"prout"
    INTO titre;
ENDaie
DELIMITER ;
CALL boiteAProut("coucou", @message);
SELECT @message;

