SHOW DATABASES ;
USE simplon ;
SHOW TABLES ;
SHOW COLUMNS from jeux_video ;
select nom,console from jeux_video ;
select nom FROM jeux_video WHERE console= 'SuperNES' order by nom ;
select possesseur FROM jeux_video WHERE nom = 'Street Fighter 2';
SELECT nom,console,prix  FROM jeux_video ORDER BY prix ASC LIMIT 4;
SELECT nom,possesseur FROM jeux_video WHERE possesseur LIKE '%O%';
SELECT nom FROM jeux_video WHERE console = 'PC' AND nbre_joueurs_max BETWEEN 4 AND 12 ;
SELECT distinct console FROM jeux_video;
  