CREATE DATABASE IF NOT EXISTS ASSURAUTO ;
USE ASSURAUTO ;

CREATE TABLE IF NOT EXISTS CLIENTS(
CL_ID INT NOT NULL PRIMARY KEY,
CL_NOM VARCHAR(30) NOT NULL,
CL_PRENOM VARCHAR(30) NOT NULL,
CL_ADRESSE VARCHAR(50) NOT NULL,
CL_CODEPOSTAL CHAR(5) NOT NULL CHECK(CL_CODEPOSTAL = '06400') ,
CL_VILLE VARCHAR(30) NOT NULL CHECK(CL_VILLE = 'Cannes'),
CL_TELEPHONE VARCHAR(15) NOT NULL,
CL_FAX VARCHAR(15) NOT NULL,
CL_MAIL VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS CONTRAT(
CO_NUMERO INT NOT NULL PRIMARY KEY,
CO_DATE DATE NOT NULL,
CO_CATEGORIE CHAR(20) NOT NULL ,
CO_BONUS FLOAT NOT NULL ,
CO_MALUS FLOAT NOT NULL ,
CO_CLIENT_FK INT NOT NULL,
FOREIGN KEY (CO_CLIENT_FK) REFERENCES CLIENTS(CL_ID)
);

INSERT INTO CLIENTS (CL_ID, CL_NOM, CL_PRENOM, CL_ADRESSE, CL_CODEPOSTAL, CL_VILLE, CL_TELEPHONE, CL_FAX, CL_MAIL) VALUES
	(1, 'Willice', 'Brousse', '18 rue Bidon', '06400', 'Cannes', '0623303030', '0909090909','devdata@cannes.fr'),
	(2, 'Wil', 'Pawtowski' ,'17 rue bidon', '06400', 'Cannes', '0606060606', '4909090909', 'xx.xx@xx.xx');

INSERT INTO CONTRAT (CO_NUMERO, CO_DATE, CO_CATEGORIE, CO_BONUS, CO_MALUS, CO_CLIENT_FK) VALUES
(1, '2020-07-08' , 'TIERS' , 2.5 , 0, 1),
(2, '2019-05-22' , 'TOUT RISQUE' , 0, 1.2, 2);

SELECT * FROM CONTRAT;
SELECT * FROM CLIENTS;

