-- Drop des prodédures existantes
DROP PROCEDURE IF EXISTS create_actor;
DROP PROCEDURE IF EXISTS select_actor;
DROP PROCEDURE IF EXISTS update_actor;
DROP PROCEDURE IF EXISTS delete_actor;

# Creation de la procedure Create(Insert) sur la table Actor
DELIMITER |
CREATE PROCEDURE create_actor(IN firstname VARCHAR(25), lastname VARCHAR(25))  
BEGIN
    INSERT INTO actor(first_name, last_name, last_update) VALUES(firstname, lastname, NOW());
END |
DELIMITER ;

# Creation de la procedure Create(Insert) sur la table Actor
DELIMITER |
CREATE PROCEDURE select_actor(IN firstname VARCHAR(25), lastname VARCHAR(25))  
BEGIN
    SELECT first_name, last_name FROM actor WHERE first_name=firstname AND last_name=lastname;
END |
DELIMITER ;

# Creation de la procedure Create(Insert) sur la table Actor
DELIMITER |
CREATE PROCEDURE update_actor(IN firstname VARCHAR(25), lastname VARCHAR(25), new_firstname VARCHAR(25), new_lastname VARCHAR(25))  
BEGIN
    UPDATE actor SET first_name=new_firstname, last_name=new_lastname, last_update=NOW() WHERE first_name=firstname AND last_name=lastname;
END |
DELIMITER ;

# Creation de la procedure Create(Insert) sur la table Actor
DELIMITER |
CREATE PROCEDURE delete_actor(IN firstname VARCHAR(25), lastname VARCHAR(25))  
BEGIN
    DELETE FROM actor WHERE first_name=firstname AND last_name=lastname;
END |
DELIMITER ;

#  Creation des variables Nom & Prenom
SET @first_name := CONCAT("Bob-", SUBSTRING(MD5(RAND()), 1, 5));
SET @last_name := CONCAT("Joe-", SUBSTRING(MD5(RAND()), 1, 5));
#  Création des variables Nom & Prenom pour l'Update
SET @new_first_name := CONCAT("Bob-", SUBSTRING(MD5(RAND()), 1, 5));
SET @new_last_name := CONCAT("Joe-", SUBSTRING(MD5(RAND()), 1, 5));

#  Insert un nouvel Acteur
CALL create_actor(@first_name, @last_name);
#  Select l'acteur ajouté si il a bien été ajouté
CALL select_actor(@first_name, @last_name);
#  Update l'acteur ajouté
CALL update_actor(@first_name, @last_name, @new_first_name, @new_last_name);
# Select l'acteur ajouté si il a bien été ajouté
CALL select_actor(@new_first_name, @new_last_name);
# Delete l'actor ajouté
CALL delete_actor(@new_first_name, @new_last_name);
# Select l'acteur ajouté si il a bien été ajouté
CALL select_actor(@new_first_name, @new_last_name);