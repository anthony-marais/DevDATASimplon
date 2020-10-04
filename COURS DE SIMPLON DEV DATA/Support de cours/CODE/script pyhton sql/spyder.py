import pandas as pd
import sqlalchemy as sql
from datetime import datetime
from sqlalchemy import create_engine
engine = create_engine('mysql+pymysql://simplon:Tarek7997@localhost:3306/assurauto')

CL_ID = pd.read_sql_query("SELECT max(CL_ID) as max FROM CLIENTS;", engine)['max'].values
CL_ID = CL_ID[0] + 1
CO_CLIENTS_FK = CL_ID 
CL_NOM = ''
CL_PRENOM = ''
CL_VILLE = ''
CL_ADRESSE = ''
CL_CODEPOSTAL =''
CL_COORDONNEE = ''


print(CL_ID)
print(CO_CLIENTS_FK)

while len(CL_NOM) == 0 or len(CL_PRENOM) == 0 or len(CL_VILLE) == 0 or len(CL_ADRESSE) == 0 or len(CL_CODEPOSTAL) == 0 or len(CL_COORDONNEE) == 0:

    if len(CL_NOM) == 0:
        CL_NOM = input('veuillez entrer un NOM :')

    elif len(CL_PRENOM) == 0:
        CL_PRENOM = input('veuillez entrer un prenom :')

    elif len(CL_VILLE) == 0:
       CL_VILLE = input('veuillez entrer la ville du client :')

    elif len(CL_ADRESSE) == 0: 
        CL_ADRESSE = input("veuillez entrer l'adresse :")

    elif len(CL_CODEPOSTAL) == 0:
        CL_CODEPOSTAL = input('veuillez entrer le code postal :')
        if CL_CODEPOSTAL.isdigit() :
           CL_CODEPOSTAL = CL_CODEPOSTAL
        else:
            print('veuillez ne rentrer que des nombres')
            CL_CODEPOSTAL = ''

    elif len(CL_COORDONNEE) == 0 or len(CL_COORDONNEE) > 15:
        CL_COORDONNEE = input('veuillez entrer une COORDONNEE :')





engine.execute('INSERT INTO CLIENTS (CL_ID, CL_NOM, CL_PRENOM, CL_VILLE, CL_ADRESSE, CL_CODEPOSTAL, CL_COORDONNEE)'
               ' VALUES (%s, "%s","%s","%s","%s",%s,%s); '%(CL_ID, CL_NOM, CL_PRENOM, CL_VILLE, CL_ADRESSE, CL_CODEPOSTAL, CL_COORDONNEE))


CO_ID = pd.read_sql_query("SELECT max(CO_ID) as max2 FROM CONTRAT;", engine)['max2'].values
CO_ID = CO_ID[0]+1
CO_DATE = datetime.today().strftime('%Y-%m-%d')
CO_BONUS = ''
CO_MALUS = ''
CO_CATEGORIE = 'Tiers'
CO_AGENCE_FK = 1

while len(CO_DATE) == 0 or len(CO_BONUS) == 0 or len(CO_MALUS) == 0 :


    if len(CO_BONUS) == 0:
        CO_BONUS = input('veuillez entrer un BONUS :')

    elif len(CO_MALUS) == 0:
       CO_MALUS = input('veuillez entrer un MALUS :')

   


engine.execute('INSERT INTO CONTRAT (CO_ID, CO_DATE, CO_BONUS, CO_MALUS, CO_CATEGORIE, CO_CLIENTS_FK,CO_AGENCE_FK)'
               'VALUES(%s,"%s","%s","%s","%s", %s,%s);'%(CO_ID,CO_DATE,CO_BONUS,CO_MALUS,CO_CATEGORIE, CO_CLIENTS_FK,CO_AGENCE_FK))


print(1)
