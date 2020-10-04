USE sakila;

#10- Lister les films contenant 'din' dans le titre 

SELECT title FROM film
WHERE title LIKE "%din%";


#13- Afficher les films ayant été empruntés mais n'ayant pas encore été restitués, triés par date d'emprunt. Afficher seulement les 10 premiers. 
SELECT title , rental.rental_date FROM film 
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.return_date is null
ORDER BY rental.rental_date LIMIT 10;
