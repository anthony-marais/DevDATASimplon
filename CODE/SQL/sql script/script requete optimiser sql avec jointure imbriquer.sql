# Réecrire les requêtes en tenant compte des preconisations du support de cours

# déterminer quel indexes sont pertinents 
#et les creer ( en fonction des requêtes de la question précédentes)

USE sakila;

#1 requete de optimisé
#1 Avec une requête imbriquée sélectionner tout les acteurs ayant joués dans les films ou a joué « MCCONAUGHEY CARY ».
SELECT DISTINCT A.first_name, A.last_name
FROM film as F
INNER JOIN film_actor FA ON F.film_id = FA.film_id
INNER JOIN actor A ON FA.actor_id = A.actor_id AND A.actor_id != (SELECT actor_id FROM actor WHERE actor.first_name = "CARY" AND actor.last_name = "MCCONAUGHEY")
WHERE F.film_id IN
  (SELECT F.film_id FROM film F
    INNER JOIN film_actor FA USING(film_id)
    INNER JOIN actor A ON A.actor_id=FA.actor_id AND A.first_name="CARY" AND A.last_name="MCCONAUGHEY");

# 1 create index

CREATE INDEX index_nom ON actor (first_name,last_name);
DROP INDEX index_nom ON actor;

#2 Afficher tout les acteurs n’ayant pas joués dans les films ou a joué « MCCONAUGHEY CARY ».


SELECT DISTINCT A.first_name, A.last_name
FROM film as F
INNER JOIN film_actor FA USING(film_id)
INNER JOIN actor A USING(actor_id)
WHERE F.film_id NOT IN
  (SELECT F.film_id FROM film F
    INNER JOIN film_actor FA USING(film_id)
    INNER JOIN actor A ON A.actor_id=FA.actor_id AND A.first_name="CARY" AND A.last_name="MCCONAUGHEY")
AND A.actor_id != (SELECT actor_id FROM actor WHERE actor.first_name = "CARY" AND actor.last_name = "MCCONAUGHEY")
GROUP BY A.first_name, A.last_name;

#2 requete optimisé

#2 Afficher tout les acteurs n’ayant pas joués dans les films ou a joué « MCCONAUGHEY CARY ».
SELECT DISTINCT A.first_name, A.last_name
FROM actor as A
INNER JOIN film F USING(film_id)
INNER JOIN film_actor FA USING(actor_id)
WHERE F.film_id NOT IN
  (SELECT F.film_id FROM film F
    INNER JOIN film_actor FA USING(actor_id)
    INNER JOIN actor A ON A.actor_id=FA.actor_id AND A.first_name="CARY" AND A.last_name="MCCONAUGHEY")
AND A.actor_id != (SELECT actor_id FROM actor WHERE actor.first_name = "CARY" AND actor.last_name = "MCCONAUGHEY")
GROUP BY A.first_name, A.last_name;













