
SHOW COLUMNS FROM rental;

SELECT rental_date FROM rental;

#1. Afficher tout les emprunt ayant été réalisé en 2006.
SELECT day(rental_date), ' ',monthname(rental_date),' ', year(rental_date)   
FROM rental 
WHERE YEAR (rental_date)=2006;

#2. Afficher la colonne qui donne la durée de location des films en jour
SELECT DATEDIFF(return_date,rental_date) as duree_location FROM rental;  


#3 Afficher les emprunts réalisés avant 1h du matin en 2005.
SELECT * FROM rental WHERE YEAR (rental_date)=2005 AND HOUR (rental_date)<1 ;

SELECT * FROM rental WHERE YEAR(rental_date) = 2005 AND extract(HOUR FROM rental_date)<1;

SELECT * FROM rental WHERE YEAR(rental_date) = 2005 AND TIME(rental_date) < '01:00:00';

##SELECT rental_date FROM rental WHERE rental_date BETWEEN '2005-01-01 00:00:00' and '2005-12-31 01:00:00';

#4 Afficher les emprunts réalisé entre le mois d’avril et le mois de mai. La liste doit être trié du plus ancien au plus récent
##SELECT rental_date FROM rental WHERE rental_date BETWEEN '2005-04-01 00:00:00' AND '2005-05-31 24:00:00'  rental_date;

SELECT * FROM rental WHERE MONTH(rental_date) IN ('04','05') ORDER BY rental_date ASC;



#5 Lister les film dont le nom ne commence pas par le "Le" 

SHOW COLUMNS from film ;

SELECT title FROM film WHERE title NOT LIKE 'Le%' ;
SELECT title FROM film WHERE LEFT(title, 2) <> 'Le';

#6 Lister les films ayant la mention « PG-13 » ou « NC-17 ». Ajouter une colonne qui affichera « oui » si « NC-17 » et « non » Sin

SELECT *,
		case rating
			WHEN 'NC-17' then 'oui' 
            ELSE 'non'
		END AS 'oui ou non'
FROM film WHERE rating in ('PG-13' , 'NC-17');



SELECT *, IF(rating='NC-17','oui','non') AS 'NC-17 = oui'
FROM film
WHERE rating in ('PG-13' , 'NC-17');

#7 Fournir la liste des catégorie qui commence par un ‘A’ ou un ‘C’. (Utiliser LEFT)
SELECT *, name from category WHERE  LEFT(name,1) in ('A' , 'C');

## n'est pas la bonne solution 
#SELECT name FROM category WHERE name like 'A%' OR name like 'C%' ;

#8 Lister les trois premiers caractères des noms des catégorie

SELECT LEFT(name,3) from category;

#9 Lister les premiers acteurs en remplaçant dans leur prenom les E par des A

SELECT *, replace(first_name,'E','A') AS modified_first_name FROM actor LIMIT 100;

SELECT *, replace(first_name,'E',1) AS modified_first_name FROM actor LIMIT 100;
