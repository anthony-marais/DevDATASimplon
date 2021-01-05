SHOW DATABASES ;
USE sakila;

#1 Lister les 10 premiers films ainsi que leur langues.

SELECT title, NAME AS langue
FROM film JOIN language
ON film.language_id = language.language_id
LIMIT 10;

#2 Afficher les film dans les quel à joué « JENNIFER DAVIS » sortie en 2006.

SELECT film.title , actor.first_name , actor.last_name , film.release_year
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film.film_id = film_actor.film_id AND film.release_year = 2006
WHERE (actor.last_name = 'DAVIS'
AND actor.first_name = 'JENNIFER') ;

#3 Afficher le noms des client ayant emprunté « ALABAMA DEVIL »

SELECT customer.last_name , film.title FROM customer
JOIN rental ON rental.customer_id = customer.customer_id
JOIN inventory ON inventory.inventory_id = rental.inventory_id
JOIN film ON film.film_id = inventory.film_id AND film.title = "ALABAMA DEVIL"; 

#4 Afficher les films louer par des personne habitant à « Woodridge ». 
#   Vérifié s’il y a des films qui n’ont jamais été emprunté

SELECT film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
WHERE city = 'Woodridge'

UNION

SELECT film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_id IS NULL;

#5 Quel sont les 10 films dont la durée d’emprunt à été la plus courte

SELECT title, DATEDIFF(rental.return_date , rental.rental_date)
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE DATEDIFF(rental.return_date , rental.rental_date) IS NOT NULL
ORDER BY DATEDIFF(rental.return_date , rental.rental_date)
LIMIT 10;

#6 Lister les films de la catégorie « Action » ordonnés par ordre alphabétique.

SELECT film.title FROM film
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "action" ORDER BY film.title;

#7 Quel sont les films dont la duré d’emprunt à été inférieur à 2 jour


