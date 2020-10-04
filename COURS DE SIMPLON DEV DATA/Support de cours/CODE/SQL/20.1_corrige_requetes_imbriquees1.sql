#--1 Avec une requête imbriquée sélectionner tout les acteurs ayant joués dans les films ou a joué « MCCONAUGHEY CARY ».
SELECT DISTINCT A.first_name, A.last_name
FROM film as F
INNER JOIN film_actor FA USING(film_id)
INNER JOIN actor A USING(actor_id)
WHERE F.film_id IN
  (SELECT F.film_id FROM film F
    INNER JOIN film_actor FA USING(film_id)
    INNER JOIN actor A ON A.actor_id=FA.actor_id AND A.first_name="CARY" AND A.last_name="MCCONAUGHEY")
AND A.actor_id != (SELECT actor_id FROM actor WHERE actor.first_name = "CARY" AND actor.last_name = "MCCONAUGHEY");

#--2 Afficher tout les acteurs n’ayant pas joués dans les films ou a joué « MCCONAUGHEY CARY ».
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

#--3 Afficher Uniquement le nom du film qui contient le plus d'acteur et le nombre d'acteurs associé sans utiliser LIMIT (2 niveaux de sous requêtes).
SELECT F.title, F.film_id as film_ID, MAX(NbActor) as TotalActor
FROM (SELECT film_id, COUNT(*) AS NbActor FROM film_actor GROUP BY film_id) AS ActorsFilmCount
INNER JOIN film F ON F.film_id=ActorsFilmCount.film_id
GROUP BY film_ID
HAVING TotalActor=(
  SELECT MAX(NbActor) as Nb
  FROM (SELECT COUNT(*) NbActor FROM film_actor GROUP BY film_id) MaxActor
);

#--4 Afficher les acteurs ayant joué uniquement dans des films d’actions (Utiliser EXISTS).
SELECT A.first_name, A.last_name
FROM film F
INNER JOIN film_actor FA ON FA.film_id=F.film_id
INNER JOIN actor A ON A.actor_id=FA.actor_id
INNER JOIN film_category FC ON FC.film_id=F.film_id
WHERE NOT EXISTS(
  SELECT A.first_name, A.last_name
  FROM category CA
  INNER JOIN film_category FC ON FC.category_id=CA.category_id
  INNER JOIN film_actor FA ON FA.film_id=FC.film_id
  INNER JOIN actor A ON A.actor_id=FA.actor_id
  WHERE CA.name="Action");

#--5 Afficher tous les films n'ayant jamais été empruntés
#--Affiche les films qui n'ont jamais été emprunté dans un ou plusieurs inventaires
SELECT F.title
FROM film as F
INNER JOIN inventory as I ON F.film_id = I.film_id
LEFT JOIN rental as R on I.inventory_id = R.inventory_id
WHERE R.rental_id IS NULL;
