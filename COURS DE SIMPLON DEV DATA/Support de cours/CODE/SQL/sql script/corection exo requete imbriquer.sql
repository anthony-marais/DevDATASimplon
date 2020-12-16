SHOW databases;
use sakila;
show tables from sakila ;

# Avec une requête imbriquée sélectionner tout les acteurs ayant joués
# dans les films ou a joué « MCCONAUGHEY CARY ».

SELECT film.title , first_name , last_name FROM actor
join film_actor on film.film_id = film_actor.film_id
join actor on film_actor.actor_id = actor.actor_id
and concat(last_name, '  ', first_name) = "MCCONAUGHEY CARY";

USE sakila;

SELECT f1.title, i1.inventory_id, f1.film_id 
FROM film f1
INNER JOIN inventory i1 ON f1.film_id = i1.film_id
WHERE NOT EXISTS 
    (    SELECT DISTINCT f2.title, i2.inventory_id, f2.film_id 
        FROM film f2
        INNER JOIN inventory i2 on f2.film_id = i2.film_id
        INNER JOIN rental r ON i2.inventory_id = r.inventory_id
        where f2.film_id = f1.film_id and i2.inventory_id = i1.inventory_id
    ) ;
    
  
  
## question 1 - Avec une requête imbriquée sélectionner tout les acteurs ayant joués dans les films ou a joué « MCCONAUGHEY CARY ».
    SELECT DISTINCT A.first_name, A.last_name
FROM film as F
INNER JOIN film_actor FA USING(film_id)
INNER JOIN actor A USING(actor_id)
WHERE F.film_id IN
  (SELECT F.film_id FROM film F
    INNER JOIN film_actor FA USING(film_id)
    INNER JOIN actor A ON A.actor_id=FA.actor_id AND (A.first_name="CARY" AND A.last_name="MCCONAUGHEY"))
AND A.actor_id != (SELECT actor_id FROM actor WHERE actor.first_name = "CARY" AND actor.last_name = "MCCONAUGHEY");
    
    
    