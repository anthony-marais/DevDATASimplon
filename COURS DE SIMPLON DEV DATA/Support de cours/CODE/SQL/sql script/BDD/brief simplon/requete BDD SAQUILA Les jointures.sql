# Intérrogation de données jointure

SHOW DATABASES;
USE sakila;
SHOW TABLES FROM sakila ;
SELECT * FROM film, language LIMIT 10  ;



# JENNIFER DAVIS id=4

SELECT * FROM film_actor WHERE (actor_id)=4;

# Lister les 10 premiers films ainsi que leur langues.
SELECT title, name as langue 
from film, language limit 10;

SELECT title, name as langue
from film join language
on film.language_id = language.language_id
LIMIT 10;

SELECT title, name FROM film JOIN language ON film.language_id = language.language_id LIMIT 10;






# 2. Afficher les film dans les quel à joué « JENNIFER DAVIS » sortie en 2006.

SELECT film.title , actor.first_name , actor.last_name , film.release_year
FROM actor 
JOIN film_actor 
ON actor.actor_id = film_actor.actor_id
JOIN film ON film.film_id = film_actor.film_id
WHERE (actor.last_name = 'DAVIS' 
AND actor.first_name = 'JENNIFER')
AND film.release_year = 2006 ;

# 2. Afficher les film dans les quel à joué « JENNIFER DAVIS » sortie en 2006.

SELECT film.title , actor.first_name , actor.last_name , film.release_year
FROM actor 
JOIN film_actor 
	ON actor.actor_id = film_actor.actor_id
JOIN film 
	ON film.film_id = film_actor.film_id AND film.release_year = 2006 
WHERE (actor.last_name = 'DAVIS' 
AND actor.first_name = 'JENNIFER') ;

#2
SELECT film.title , actor.first_name , actor.last_name , film.release_year
FROM actor 
JOIN film_actor 
	ON actor.actor_id = film_actor.actor_id 
	AND (actor.last_name = 'DAVIS' 
	AND actor.first_name = 'JENNIFER') 
JOIN film 
	ON film.film_id = film_actor.film_id 
	AND film.release_year = 2006 ;
    






#3 Afficher le noms des client ayant emprunté « ALABAMA DEVIL »
# film , inventory , rental , customer 
SELECT customer.last_name , film.title FROM customer
JOIN rental ON rental.customer_id = customer.customer_id
JOIN inventory ON inventory.inventory_id = rental.inventory_id
JOIN film ON film.film_id = inventory.film_id AND film.title = "ALABAMA DEVIL";
#WHERE film.title = "ALABAMA DEVIL";

select C.last_name, C.first_name,title
from customer as C
join rental as R on C.customer_id = R.customer_id
join inventory as I ON I.inventory_id = R.inventory_id
join film as F on I.film_id = F.film_id
WHERE title = "ALABAMA DEVIL";





#4 Afficher les films louer par des personne habitant à « Woodridge ». 
#   Vérifié s’il y a des films qui n’ont jamais été emprunté
# film , inventory , rental , customer , address , city
SELECT city.city , film.title, store.store_id FROM city
JOIN address ON address.city_id = city.city_id 
JOIN store ON store.store_id = store.address_id 
JOIN inventory ON inventory.inventory_id = inventory.store_id
JOIN film ON film.film_id = inventory.film_id
WHERE city.city = "Woodridge";
 
 ##
SELECT film.title FROM film
JOIN city ON city.city_id = city.address_id
JOIN address ON address.address_id = customer.adress_id
JOIN customer ON customer.customer_id = customer.rental_id
JOIN rental ON rental.rental_id = rental.inventory_id
JOIN inventory ON inventory.inventory_id = inventory.film_id
WHERE city.city = "Woodridge"; 

SELECT F.title 
from film as F
join inventory as I on F.film_id = I.film_id
join rental as R on I.inventory_id = R.inventory_id
join customer as C on R.customer_id = C.customer_id
join address as A on C.address_id = A.address_id
join city as CI on A.city_id = CI.city_id
WHERE city = "Woodridge";



SELECT F.title 
from film as F
join inventory as I on F.film_id = I.film_id
join rental as R on I.inventory_id = R.inventory_id
join customer as C on R.customer_id = C.customer_id
join address as A on C.address_id = A.address_id
join city as CI on A.city_id = CI.city_id
WHERE city = "Woodridge"

UNION

SELECT F.title
from film as F
join inventary as I on F.film_id = I.film_id
left join rental as R on I.inventary_id = R.inventary_id
where R.rental_id IS NULL;



#Afficher les films louer par des personne habitant à « Woodridge ».Vérifié s’il y a des films qui n’ont jamais été emprunté.
select F.title
from film as F
join inventory as I on F.film_id = I.film_id
join rental as R on I.inventory_id = R.inventory_id
join customer as C on R.customer_id = C.customer_id
join address as A on C.address_id = A.address_id
join city as CI on A.city_id = CI.city_id
where city = 'Woodridge'


UNION 

select F.title
from film as F
join inventory as I on F.film_id = I.film_id
 left join rental as R on I.inventory_id = R.inventory_id
where R.rental_id IS NULL;



#################



SELECT title
FROM film AS f
JOIN inventory AS i 
ON f.film_id = i.film_id
LEFT JOIN rental AS r
ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;



######







#5. Quel sont les 10 films dont la durée d’emprunt à été la plus courte
SELECT title, rental_duration
FROM film ORDER BY rental_duration  LIMIT 10  ;

####
SELECT title
FROM film
JOIN inventory ON inventory.inventory_id = rental.inventory_id
JOIN film ON film.film_id = inventory.film_id
WHERE DATEDIFF(return_date, rental_date) IS NOT NULL ORDER BY rental_duration LIMIT 10

###


select title,datediff(R.return_date,R.rental_date)
from film as F
join inventory as I on F.film_id = I.film_id
join rental as R on I.inventory_id = R.inventory_id
WHERE datediff(R.return_date,R.rental_date) IS NOT NULL
ORDER BY datediff(R.return_date, R.rental_date)
LIMIT 10;

####

select title,datediff(R.return_date,R.rental_date) 
from film as F
join inventory as I on F.film_id = I.film_id
join rental as R on I.inventory_id = R.inventory_id
where datediff(R.return_date,R.rental_date)  IS NOT NULL
ORDER BY datediff(R.return_date,R.rental_date) 
LIMIT 10;

####

SELECT F.title,
TIMESTAMPDIFF(HOUR, UNIX_TIMESTAMP(RE.rental_date), UNIX_TIMESTAMP(RE.return_date)) as Duree
FROM rental AS RE
INNER JOIN inventory AS INV 
ON INV.inventory_ID=RE.inventory_id 
INNER JOIN film AS F 
ON F.film_id=INV.film_id 
HAVING Duree IS NOT NULL 
ORDER BY Duree ASC 
LIMIT 10;


####6

select f.title from film as f
join film_category as fc on fc.film_id = f.film_id
join category as c on fc.category_id = c.category_id
where c.name = "action" order by f.title;




