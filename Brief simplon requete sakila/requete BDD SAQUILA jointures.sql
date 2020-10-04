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

SELECT DISTINCT title, DATEDIFF(rental.return_date , rental.rental_date)
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE DATEDIFF(rental.return_date , rental.rental_date)<2
ORDER BY DATEDIFF(rental.return_date , rental.rental_date);

SELECT DISTINCT title FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE DATEDIFF(rental.return_date , rental.rental_date)<2;


SELECT timediff('2020-07-13 10:33:55','2020-07-01 13:22:00');


#jointure entre la table film et language 

SELECT title, name FROM language RIGHT JOIN film ON film.language_id = language.language_id ;

SELECT title, name FROM language LEFT JOIN film ON film.language_id = language.language_id ;

SELECT title, name FROM language INNER JOIN film ON film.language_id = language.language_id ;


#1. Afficher le nombre de films dans les quels à joué l'acteur « JOHNNY LOLLOBRIGIDA », regroupé par catégor
SELECT COUNT(film.title),category.name FROM film 
JOIN film_actor ON film_actor.film_id = film.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id 
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE actor.first_name = 'JOHNNY' AND actor.last_name = 'LOLLOBRIGIDA'
GROUP BY category.name;


#2. Ecrire la requête qui affiche les catégories dans les quels « JOHNNY LOLLOBRIGIDA » totalise plus de 3 films

SELECT COUNT(film.title), category.name FROM film 
JOIN film_actor ON film_actor.film_id = film.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id 
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE actor.first_name = 'JOHNNY' AND actor.last_name = 'LOLLOBRIGIDA'
GROUP BY category.name
HAVING COUNT(film.title) > 3;

#3. Afficher la durée moyenne d'emprunt des films par acteur

SELECT actor.first_name ,actor.last_name, AVG(datediff(return_date,rental_date))
FROM rental 
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY actor.first_name , actor.last_name;

#4 L'argent total dépensé au vidéos club par chaque clients, classé par ordre décroissant


SELECT customer.first_name , customer.last_name, SUM(payment.amount) as total
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.first_name, customer.last_name ORDER BY total DESC;

#5 Afficher tous les films ayant été loués 10 fois ou plus

SELECT film.title, count(rental.rental_date)
FROM film
JOIN inventory
JOIN rental 
ON film.film_id = inventory.film_id AND inventory.inventory_id = rental.inventory_id
GROUP BY film.title HAVING count(rental.rental_date) >= 10 ORDER BY count(rental.rental_date) DESC;

#6 Lister les films de la catégorie « Action » ordonnés par ordre alphabétique.

SELECT film.title FROM film
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'action'
ORDER BY film.title;

# 7. Quel sont les films dont la duré d’emprunt à été inférieur à 2 jour ?

SELECT DISTINCT film.title FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE datediff(R.rental_date , R.return_date) < '47:00:00'
AND datediff(R.return_date, R.rental);