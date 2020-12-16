SHOW DATABASES;
USE sakila;

#1- Quels acteurs ont le prénom "Scarlett "

SELECT first_name, last_name FROM actor 
WHERE first_name = "Scarlett";

#2- Quels acteurs ont le nom de famille "Johansson "

SELECT first_name, last_name FROM actor
WHERE last_name = "Johansson";


# 3- Combien de noms de famille d'acteurs distincts y a-t-il ? 

SELECT DISTINCT count(last_name) FROM actor;

# 4- Quels noms de famille ne sont pas répétés ? 

SELECT last_name FROM actor
GROUP BY last_name
HAVING count(*)=1;

# 5- Quels noms de famille apparaissent plus d'une fois ? 

SELECT last_name FROM actor 
GROUP BY last_name 
HAVING count(last_name)>1;

# 6- Quel acteur est apparu dans le plus grand nombre de films ? 

