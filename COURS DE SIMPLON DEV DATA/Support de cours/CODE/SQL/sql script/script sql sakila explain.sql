USE sakila;

explain select * 
from film
order by film_id;
#where title = 'ACADEMY DINOSAUR';

explain select * 
from actor as a 
inner join film_actor as fa on a.actor_id = fa.actor_id
inner join film as f on f.film_id = fa.film_id
order by f.film_id;

