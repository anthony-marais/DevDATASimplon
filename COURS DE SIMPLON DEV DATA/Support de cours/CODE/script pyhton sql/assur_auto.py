



def choix_ville():
    city_store_CMD = input('Choisissez une action(Tappez "Aide" pour connaitre la liste)')
        print('Section AIDE:\n'
        '1 -choisir la ville Lethbridge \n'
        '2 -choisir la ville Woodridge\n'
        '0 - Quitte l\'application')
        choix_ville()
    elif city_store_CMD == '1':
        AjoutClient()
    elif city_store_CMD == '2':
        AjoutContrat()
    elif city_store_CMD == '0':
        exit()
    else:
        choix_ville()


#Importer Sqlalchemy (déjà installé avec anaconda).
import sqlalchemy as db
from sqlalchemy.exc import SQLAlchemyError
import pandas as pd
import datetime

#Utiliser la méthode create_engine() de Sqlalchemy pour établir une connexion.
engine = db.create_engine('mysql://simplon:simplon@127.0.0.1')
connection = engine.connect()

#Tester la connexion en important les données de la table jeux_video. Utilser la methode pd.read_sql_query() de pandas.
read_data = pd.read_sql_query('SELECT * FROM jeux_simplon.jeux', connection)

def StartRoutine():
    CL_CMD = input('Choisissez une action(Tappez "Aide" pour connaitre la liste)').upper()
    if CL_CMD == 'AIDE':
        print('Section AIDE:\n'
        '1 - Ajouter un nouveau client\n'
        '2 - Ajouter un nouveau contrat\n'
        '0 - Quitte l\'application')
        StartRoutine()
    elif CL_CMD == '1':
        AjoutClient()
    elif CL_CMD == '2':
        AjoutContrat()
    elif CL_CMD == '0':
        exit()
    else:
        StartRoutine()

def AjoutClient():
#Le nom doit être intégré dans la base de données tout en majuscule, même si le conseillé ne le rentre pas forcément en majuscule.
#L’ID ne doit pas être saisi par le conseillé, mais attribué automatiquement et être unique.
#Partie Client
    CL_NOM = isEmpty('Nom Client: ').upper()
    CL_PRENOM = isEmpty('Prenom Client: ').upper()
    CL_ADRESSE = isEmpty('Adresse: ')
    CL_VILLE = isEmpty('Ville: ').upper()
    CL_TEL = isEmpty('Téléphone: ')
    CL_CP = isValidCP('Code Postal: ')

    #result = connection.execute("SELECT MAX(CL_ID) as Max FROM assur_auto.CLIENTS")
    #row = result.fetchone()
    #row['Max']

    #• Pour ce projet on ne remplira que les tables clients et contrat.
    #• Vous devrez utiliser la méthode engine.execute() pour exécuter du script SQL et insérer des données.
    try:
        engine.execute("INSERT INTO assur_auto.CLIENTS (CL_ID, CL_NOM, CL_PRENOM, CL_ADRESSE, CL_CP, CL_VILLE, CL_TEL) VALUES ((SELECT MAX(CL_ID)+1 FROM assur_auto.CLIENTS CL), '%s', '%s', '%s', '%s', '%s', '%s');" %(CL_NOM, CL_PRENOM, CL_ADRESSE, CL_CP, CL_VILLE, CL_TEL))
        print('Ajout de Client avec Succès')
        StartRoutine()
    except SQLAlchemyError as e:
        print("Une erreur s'est produite avec la requête.")

def AjoutContrat():
    CO_DATE = isValidDate('Date du Contrat: ')
    CO_CATEGORIE = isEmpty('Catégorie: ')
    CO_BONUS_MALUS = isValidBM('Coéfficient Bonus/Malus: ')

    try:
        engine.execute("INSERT INTO assur_auto.CONTRATS (CO_ID, CO_DATE, CO_CATEGORIE, CO_BONUS_MALUS, CO_CLIENT_FK, CO_VU_FK, CO_VT_FK, CO_AG_FK) VALUES ((SELECT MAX(CO_ID)+1 FROM assur_auto.CONTRATS CO), '%s', '%s', %s, (SELECT MAX(CL_ID) FROM assur_auto.CLIENTS CL), 1, NULL, 1);" %(CO_DATE, CO_CATEGORIE, CO_BONUS_MALUS))
        print('Ajout de Contrat avec Succès')
        StartRoutine()
    except SQLAlchemyError as e:
        print("Une erreur s'est produite avec la requête.")

#On vérifie si le champ n'a pas été laissé vide
def isEmpty(prompt):
    value = input(prompt)
    while not value:
        print("Vous devez renseigner une valeur.")
        value = input(prompt)
    return value

#On vérifie si le CP est valide et si il ne depasse pas 5 Caractere
def isValidCP(prompt):
    value = input(prompt)
    while value.isnumeric() == False or len(value) > 5:
        print("Le code Postal n'est pas valide.")
        value = input(prompt)
    return value

#On vérifie si la date est valide
def isValidDate(prompt):
    value = input(prompt)
    try:
        datetime.datetime.strptime(value, '%Y-%m-%d')
    except ValueError:
        print("Format de date Incorrect, Format autorisé YYYY-MM-DD")
        value = isValidDate(prompt)
    return value

#On vérifie que le BonusMalus est valide
def isValidBM(prompt):
    value = input(prompt)
    try:
        float(value)
    except ValueError:
        print("Le Coefficiant Bonus/Malus n'est pas valide.")
        value = isValidBM(prompt)
    return value

StartRoutine()
