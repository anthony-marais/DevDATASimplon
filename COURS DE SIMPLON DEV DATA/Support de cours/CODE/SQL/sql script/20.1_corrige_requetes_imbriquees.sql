USE sakila;

# Avec une requête imbriquée sélectionner tout les acteurs ayant joués dans les films ou a joué « MCCONAUGHEY CARY »
SELECT DISTINCT a.last_name, a.first_name
FROM actor as a
INNER JOIN film_actor as fa on a.actor_id = fa.actor_id
INNER JOIN film as f ON f.film_id = fa.film_id
where f.film_id IN (	SELECT distinct f2.film_id
						FROM actor as a2
						INNER JOIN film_actor as fa2 on a2.actor_id = fa2.actor_id
						INNER JOIN film as f2 ON f2.film_id = fa2.film_id
						where a2.first_name = 'CARY' 
						and a2.last_name = 'MCCONAUGHEY' )
AND a.actor_id != (	SELECT actor_id 
					FROM actor 
					WHERE actor.first_name = "CARY" 
					AND actor.last_name = "MCCONAUGHEY");

SELECT DISTINCT a.last_name, a.first_name
FROM actor as a
INNER JOIN film_actor as fa on a.actor_id = fa.actor_id
INNER JOIN film as f ON f.film_id = fa.film_id
where exists (	SELECT distinct f2.film_id
				FROM actor as a2
				INNER JOIN film_actor as fa2 on a2.actor_id = fa2.actor_id
				INNER JOIN film as f2 ON f2.film_id = fa2.film_id
				where a2.first_name = 'CARY' and a2.last_name = 'MCCONAUGHEY'
                and f2.film_id = f.film_id)
AND a.actor_id != (	SELECT actor_id 
					FROM actor 
					WHERE actor.first_name = "CARY" 
					AND actor.last_name = "MCCONAUGHEY");

--# Afficher tout les acteurs n’ayant pas joués dans les films ou a joué « MCCONAUGHEY CARY »
--# attention, il pourrait y avoir des acteurs n'ayant joué dans aucun film

SELECT DISTINCT a.last_name, a.first_name
FROM actor as a
INNER JOIN film_actor as fa on a.actor_id = fa.actor_id
INNER JOIN film as f ON fa.film_id = fa.film_id
where f.film_id NOT IN ( 	SELECT distinct f2.film_id
							FROM actor as a2
							INNER JOIN film_actor as fa2 on a2.actor_id = fa2.actor_id
							INNER JOIN film as f2 ON f2.film_id = fa2.film_id
							where a2.first_name = 'CARY' 
							and a2.last_name = 'MCCONAUGHEY' );

SELECT DISTINCT a.last_name, a.first_name
FROM actor as a
INNER JOIN film_actor as fa on a.actor_id = fa.actor_id
INNER JOIN film as f ON fa.film_id = fa.film_id
where NOT exists ( 	SELECT distinct f2.film_id
					FROM actor as a2
					INNER JOIN film_actor as fa2 on a2.actor_id = fa2.actor_id
					INNER JOIN film as f2 ON f2.film_id = fa2.film_id
					where a2.first_name = 'CARY' and a2.last_name = 'MCCONAUGHEY'
					and f2.film_id = f.film_id);
					

# Niry debut ########################################
use sakila;
SELECT DISTINCT a1.first_name, a1.last_name
FROM film_actor AS fa1
JOIN actor AS a1 ON fa1.actor_id = a1.actor_id
RIGHT JOIN ( SELECT fa2.film_id
			 FROM actor AS a2
			 JOIN film_actor AS fa2 ON a2.actor_id = fa2.actor_id
			 WHERE a2.last_name = 'MCCONAUGHEY'
			 AND a2.first_name = 'CARY') AS fa3 ON fa1.film_id = fa3.film_id
AND a.actor_id != (	SELECT actor_id 
					FROM actor 
					WHERE actor.first_name = "CARY" 
					AND actor.last_name = "MCCONAUGHEY");

#2- Afficher tous les acteurs n’ayant pas joué dans les films où a joué «MCCONAUGHEY CARY»
select distinct a1.first_name, a1.last_name
from film_actor as fa1
join actor as a1 on fa1.actor_id=a1.actor_id
left join ( select fa2.film_id
			from actor as a2
            join film_actor as fa2 on a2.actor_id=fa2.actor_id
			where a2.last_name='MCCONAUGHEY' 
			and a2.first_name='CARY') as fa3 on fa1.film_id=fa3.film_id
where fa1.film_id is null;
#Niry fin ########################################

# Afficher Uniquement le nom du film qui contient le plus d'acteur et le
# nombre d'acteurs associé sans utiliser LIMIT (2 niveaux de sous
# requêtes).

select count(a.actor_id) as actors_number, f.title
FROM actor as a
INNER JOIN film_actor as fa on a.actor_id = fa.actor_id
INNER JOIN film as f ON f.film_id = fa.film_id
group by f.title
having count(a.actor_id) = (SELECT max(AN2.actors_number)
							from ( 	select count(a2.actor_id) as actors_number, f2.title
									FROM actor as a2
									INNER JOIN film_actor as fa2 
										on a2.actor_id = fa2.actor_id
									INNER JOIN film as f2 
										ON f2.film_id = fa2.film_id
									group by f2.title) AS AN2)
;

# Afficher les acteurs ayant joué uniquement dans des films d’actions (Utiliser EXISTS).

SELECT *
from actor as a2
WHERE NOT EXISTS (
					select distinct a.actor_id
					FROM actor as a
					INNER JOIN film_actor as fa on a.actor_id = fa.actor_id
					INNER JOIN film as f ON f.film_id = fa.film_id
					INNER JOIN film_category as fc ON f.film_id = fc.film_id
					INNER JOIN category as c ON c.category_id = fc.category_id
					where c.name <> 'Action'
					and a2.actor_id = a.actor_id )
;


--# liste des exemplaires n'ayant jamais été empruntés
SELECT f1.title, i1.inventory_id, f1.film_id
FROM film f1
INNER JOIN inventory i1 ON f1.film_id = i1.film_id
WHERE NOT EXISTS
( SELECT DISTINCT i2.inventory_id
FROM inventory i2
        INNER JOIN rental r ON i2.inventory_id = r.inventory_id
        where i2.inventory_id = i1.inventory_id
) ;
   
SELECT f1.title, i1.inventory_id, f1.film_id
FROM film f1
INNER JOIN inventory i1 ON f1.film_id = i1.film_id
WHERE i1.inventory_id NOT IN
( SELECT DISTINCT i2.inventory_id
FROM inventory i2
        INNER JOIN rental r ON i2.inventory_id = r.inventory_id
) ;   