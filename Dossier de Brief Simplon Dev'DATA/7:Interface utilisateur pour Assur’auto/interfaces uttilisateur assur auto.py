#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul 20 14:38:52 2020

@author: virus
"""


import pandas as pd
from sqlalchemy import create_engine
engine = create_engine('mysql+pymysql://root:password@127.0.0.1:3306/ASSUR_AUTO')
print("Welcome")
data = pd.read_sql_query('SHOW TABLES FROM ASSUR_AUTO',engine)
print("Affichage des tables de la base de donnée ASSUR_AUTO")
print(data)
print()
print()
data = pd.read_sql_query('SHOW COLUMNS FROM CLIENTS',engine)
print("Affichage des colonnes de la tables CLIENTS")
print(data)

data = pd.read_sql_query('SELECT * FROM CLIENTS',engine)
print(data)
print("\n")
#CL_ID = '21'
#CL_NOM = 'Un certain club'
#engine.execute('INSERT INTO CONTRAT (CL_ID, CL_NOM) VALUES (%s, "%s");' %(CL_ID , CL_NOM))

CL_ID=1
CL_NOM = ""
CL_PRENOM = ""
CL_ADRESSE = ""
CL_CP = ""
CL_VILLE = ""
CL_TEL = ""


#id = pd.read_sql_query("SELECT max(CL_ID) FROM CLIENTS;",engine)+1

while len(CL_NOM) == 0 or len(CL_PRENOM) == 0 or len(CL_ADRESSE) == 0 or len(CL_CP) == 0 or len(CL_VILLE) == 0 or len(CL_TEL) == 0:
    
    if len(CL_NOM) == 0:
        CL_NOM = input('Veillez entrez le nom du client : ').upper()
    
    if len(CL_PRENOM) == 0: 
        CL_PRENOM = input('Veillez entrez le prénom du client : ').upper()
    
    if len(CL_TEL) == 0: 
        CL_TEL = input("Veillez entrez le numéro de téléphone du client : ")
    
    if len(CL_ADRESSE) == 0: 
        CL_ADRESSE = input("Veillez entrez l'addresse du client : ")
    
    if len(CL_VILLE) == 0:
        CL_VILLE = input("Veillez entrez la ville du client : ")
    
    if len(CL_CP) == 0: 
        CL_CP = input("Veillez entrez le code postal du client : ")
        if CL_CP.isdigit():
            CL_CP = CL_CP
        else:
            print("Veuillez entrez que des nombres")
            CL_CP = ""
    break
print()
print(data)
print()
engine.execute('INSERT INTO CLIENTS (CL_ID,CL_NOM, CL_PRENOM, CL_TEL,CL_ADRESSE , CL_VILLE, CL_CP) VALUES ((SELECT max(CL_ID)+1 FROM CLIENTS CL),"%s","%s","%s","%s","%s","%s");'%(CL_NOM, CL_PRENOM, CL_TEL,CL_ADRESSE , CL_VILLE, CL_CP))
print()
data = pd.read_sql_query('SELECT * FROM CLIENTS',engine)
print(data)
print()
print()



data = pd.read_sql_query('SHOW TABLES FROM ASSUR_AUTO',engine)
print("Affichage des tables de la base de donnée ASSUR_AUTO")
print(data)
print()
print()
data = pd.read_sql_query('SHOW COLUMNS FROM CONTRATS',engine)
print("Affichage des colonnes de la tables CONTRATS")
print(data)
print()
print()
data = pd.read_sql_query('SELECT * FROM CONTRATS',engine)
print(data)
print()
print()
print()
#CL_ID = '21'
#CL_NOM = 'Un certain club'
#engine.execute('INSERT INTO CONTRAT (CL_ID, CL_NOM) VALUES (%s, "%s");' %(CL_ID , CL_NOM))

from datetime import datetime
CO_DATE = datetime.today().strftime("%Y-%m-%d")
CO_CATEGORIE = ""
CO_BONUS_MALUS = ""

print(CO_DATE)

while len(CO_CATEGORIE) == 0 or len(CO_BONUS_MALUS) == 0:
    
    if len(CO_CATEGORIE) == 0: 
        CO_CATEGORIE = input('Veillez entrez la catégorie de contrat Tiers/Tout risques : ')
    if len(CO_BONUS_MALUS) == 0: 
        CO_BONUS_MALUS = input("Veillez entrez le bonus ou le malus : ")
    
print()
print(data)
print()
engine.execute('INSERT INTO CONTRATS (CO_ID,CO_DATE,CO_CATEGORIE,CO_BONUS_MALUS,CO_CLIENT_FK,CO_AG_FK) VALUES ((SELECT max(CO_ID)+1 FROM CONTRATS CL),"%s","%s","%s",(SELECT max(CL_ID) FROM CLIENTS CL),1);'%(CO_DATE, CO_CATEGORIE, CO_BONUS_MALUS))
print()
data = pd.read_sql_query('SELECT * FROM CONTRATS',engine)
print(data)
