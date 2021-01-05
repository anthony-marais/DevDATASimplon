SHOW DATABASES;
USE sakila;

SHOW TABLES;

# 1- Afficher les 10 locations les plus longues (nom/prenom client, film, video club, durée) 
#												customer.first_name , customer.last_name , film.title , store ,rental_duration 

SELECT * FROM film;

SELECT customer.first_name , customer.last_name, film.title, store.store_id, datediff(rental.return_date,rental.rental_date) as duree 
FROM film 
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON store.store_id = inventory.store_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id
ORDER BY duree DESC LIMIT 10;

#2- Afficher les 10 meilleurs clients actifs par montant dépensé (nom/prénom client, montant dépensé) 
#                                                                 customer.last_name / customer.first_name /customer.active / payment.amount


SELECT customer.first_name , customer.last_name, customer.active , payment.amount
FROM payment 
JOIN rental ON payment.customer_id = rental.rental_id
JOIN customer ON rental.customer_id = customer.customer_id
WHERE customer.active=1
ORDER BY payment.amount DESC LIMIT 10 ;

#3- Afficher la durée moyenne de location par film triée de manière descendante 

SELECT AVG(datediff(return_date,rental_date)), film.title
FROM film 
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
GROUP BY film.title
ORDER BY AVG(datediff(return_date,rental_date)) DESC;

#4- Afficher tous les films n'ayant jamais été empruntés 

SELECT film.title
FROM film 
LEFT JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
WHERE film.film_id is null 
GROUP BY film.title;

#5- Afficher le nombre d'employés (staff) par video club 

SELECT count(staff_id) FROM store
INNER join staff on staff.store_id = store.store_id 
GROUP BY staff_id;

#6- Afficher les 10 villes avec le plus de video clubs 

SELECT count(store.store_id), city FROM store 
JOIN address ON store.address_id = address.address_id
JOIN city ON city.city_id = address.city_id
GROUP BY city LIMIT 10
;

#7- Afficher le film le plus long dans lequel joue Johnny Lollobrigida 

SELECT film.title, film.length , actor.first_name, actor.last_name FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film.film_id = film_actor.film_id
WHERE (actor.first_name = 'Johnny' AND actor.last_name = 'Lollobrigida')
ORDER BY film.length DESC LIMIT 1;

#8- Afficher le temps moyen de location du film 'Academy dinosaur' 

SELECT film.title, avg(datediff(rental.return_date,rental.rental_date)) from film 
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE film.title = "Academy dinosaur"
ORDER BY avg(datediff(rental.return_date,rental.rental_date)) DESC ;

#9- Afficher les films avec plus de deux exemplaires en inventaire (store id, titre du film, nombre d'exemplaires) 

SELECT film.title , inventory.film_id , inventory.store_id FROM inventory 
JOIN film ON inventory.film_id = film.film_id
WHERE inventory.film_id > 2 ;

#10- Lister les films contenant 'din' dans le titre 

SELECT title FROM film
WHERE title LIKE "%din%";

#11- Lister les 5 films les plus empruntés 

SELECT title , rental.rental_date FROM film 
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
ORDER BY rental.rental_date DESC LIMIT 5;

#12- Lister les films sortis en 2003, 2005 et 2006 
SELECT title , release_year FROM film
WHERE release_year IN (2006,2005,2003);


#13- Afficher les films ayant été empruntés mais n'ayant pas encore été restitués, triés par date d'emprunt. Afficher seulement les 10 premiers. 
SELECT title , rental.rental_date FROM film 
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.return_date is null
ORDER BY rental.rental_date LIMIT 10;

#14- Afficher les films d'action durant plus de 2h 

SELECT film.title , film.length, category.name FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE film.length >120;


#15- Afficher tous les utilisateurs ayant emprunté des films avec la mention NC-17 
SELECT customer.last_name , customer.first_name , film.rating , film.title FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id
WHERE film.rating = "NC-17" ;


#16- Afficher les films d'animation dont la langue originale est l'anglais 

SELECT film.title , language.name , category.name FROM film
JOIN language ON film.language_id = language.language_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'animation' and language.name = 'English';

#17- Afficher les films dans lesquels une actrice nommée Jennifer a joué (bonus: en même temps qu'un acteur nommé Johnny) 

SELECT film.title , actor.first_name FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film.film_id = film_actor.film_id 
WHERE actor.first_name = 'JENNIFER' 
UNION 

SELECT film.title , actor.first_name FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film.film_id = film_actor.film_id 
WHERE actor.first_name = 'JOHNNY' ;


#18- Quelles sont les 3 catégories les plus empruntées? 

SELECT category.name , datediff(rental.return_date,rental.rental_date) FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
ORDER BY  datediff(rental.return_date,rental.rental_date) DESC LIMIT 3;

#19- Quelles sont les 10 villes où on a fait le plus de locations? 

SELECT city.city , datediff(rental.return_date,rental.rental_date) FROM city
JOIN address ON city.city_id = address.city_id
JOIN store ON address.address_id = store.address_id
JOIN inventory ON store.store_id = inventory.store_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
ORDER BY datediff(rental.return_date,rental.rental_date) DESC LIMIT 10;


#20- Lister les acteurs ayant joué dans au moins 1 film

SELECT DISTINCT actor.first_name , actor.last_name FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.film_id > 1;





