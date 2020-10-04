USE sakila;

# Avec une requête imbriquée sélectionner tout les acteurs ayant joués dans les films ou a joué « MCCONAUGHEY CARY »
SELECT DISTINCT actor.last_name, actor.first_name
FROM actor
INNER JOIN film_actor on actor.actor_id = film_actor.actor_id
INNER JOIN film ON film.film_id = film_actor.film_id
where film.film_id IN (	SELECT distinct film.film_id
						FROM actor
						INNER JOIN film_actor on actor.actor_id = film_actor.actor_id
						INNER JOIN film ON film.film_id = film_actor.film_id
						where actor.first_name = 'CARY' 
						and actor.last_name = 'MCCONAUGHEY' )
AND actor.actor_id != (	SELECT actor_id 
					FROM actor 
					WHERE actor.first_name = "CARY" 
					AND actor.last_name = "MCCONAUGHEY");