#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 22 15:25:50 2020

@author: virus
"""

import sqlalchemy as db
import pandas as pd
import matplotlib.pyplot as plt

#Utiliser la méthode create_engine() de Sqlalchemy pour établir une connexion.
engine = db.create_engine('mysql://root:Simplon1!@127.0.0.1/sakila')
connection = engine.connect()

def Menu():
    choix_menu = input('Choisissez une action(Tappez "Aide" pour connaitre la liste)').upper()
    if choix_menu == 'AIDE':
        print('Section AIDE:\n'
        '1 - Afficher les Vidéo Club\n'
        '2 - Afficher les Catégories des films\n'
        '3 - Affiche sous forme de graphique l\'évolution des locations pour le Video Club Séléctionné\n'
        '4 - Affiche sous forme de graphique l\'évolution des locations pour la Catégorie de film & le Video Club Séléctionné\n'
        '0 - Quitte l\'application')
        Menu()
    elif choix_menu == '1':
        Afficher_video_club() #Afficher les videos clubs
        Menu()
    elif choix_menu == '2':
        Afficher_category_film() #Afficher les category de film
        Menu()
    elif choix_menu == '3':
        Afficher_graph_film_video_club() #Afficher le graph des location par video club  Afficher_graph_film_video_club
        Menu()
    elif choix_menu == '4':
        Afficher_graph_film_category_video_club()   #Afficher le graph par category de film par video club  Afficher_graph_film_category_video_club
        Menu()
    elif choix_menu == '0':
        exit()
    else:
        Menu()


def Afficher_video_club():
    video_club_lst = connection.execute('SELECT STO.store_id, CI.city FROM store as STO INNER JOIN address AD USING(address_id) INNER JOIN city CI USING(city_id);')
    #video_club_lst = [{column: value for column, value in rowproxy.items()} for rowproxy in video_club_lst]
    for video_club in video_club_lst:
            print(str(video_club.store_id)+' - '+video_club.city)

def Afficher_category_film():
    film_cat_lst = connection.execute('SELECT DISTINCT category_id, name FROM category;')
    #film_cat_lst = [{column: value for column, value in rowproxy.items()} for rowproxy in film_cat_lst]
    for film_cat in film_cat_lst:
            print(str(film_cat.category_id)+' - '+film_cat.name)

def Afficher_graph_film_video_club():
    video_club_id = -1
    if video_club_id == -1:
        resp = input("Vous devez séléctionner un Video Club\n Voulez vous afficher la liste?(o/n): ")
        if resp == "o":
            Afficher_video_club()
    video_club_id = isClubExist("ID du Vidéo Club: ")
    getGraphVideoClub(video_club_id)

def Afficher_graph_film_category_video_club():
    video_club_id = -1
    film_catégorie_id = -1
    if video_club_id == -1:
        resp = input("Vous devez séléctionner un Video Club\n Voulez vous afficher la liste?(o/n): ")
        if resp == "o":
            Afficher_video_club()
        video_club_id = isClubExist("ID du Vidéo Club: ")
    if film_catégorie_id == -1:
        resp = input("Vous devez séléctionner une Catégorie\n Voulez vous afficher la liste?(o/n): ")
        if resp == "o":
            Afficher_category_film()
        film_catégorie_id = isCatExist("ID de la Catégorie: ")
    getGraphFilmCatVideoClub(video_club_id, film_catégorie_id)

def getGraphVideoClub(ID_VIDEO_CLUB):
    rent_video_club_data = pd.read_sql_query("SELECT CONCAT(YEAR(RE.rental_date),'-',MONTH(RE.rental_date)) as RentDate, COUNT(RE.rental_id) as Location FROM rental as RE INNER JOIN staff as STA ON STA.staff_id=RE.staff_id INNER JOIN store as STO ON STO.store_id=STA.store_id AND STO.store_id=%(id_club)s GROUP BY RentDate;", connection, params={"id_club":ID_VIDEO_CLUB})
    graph = rent_video_club_data.plot(x='RentDate', y='Location')
    graph.plot()
    plt.show()

def getGraphFilmCatVideoClub(ID_VIDEO_CLUB, ID_FILM_CAT):
    rent_video_club_data = pd.read_sql_query("SELECT CONCAT(YEAR(RE.rental_date),'-',MONTH(RE.rental_date)) as RentDate, COUNT(CA.category_id) as Location FROM film FI INNER JOIN film_category FC ON FC.film_id=FI.film_id INNER JOIN category CA ON CA.category_id=FC.category_id and CA.category_id=%(id_cat)s INNER JOIN inventory INV ON INV.film_id=FI.film_id INNER JOIN rental RE ON RE.inventory_id=INV.inventory_id INNER JOIN staff STA ON STA.staff_id=RE.staff_id INNER JOIN store STO ON STO.store_id=STA.store_id AND STO.store_id=%(id_club)s GROUP BY RentDate;", connection, params={"id_club":ID_VIDEO_CLUB, "id_cat":ID_FILM_CAT})
    graph = rent_video_club_data.plot(x='RentDate', y='Location')
    graph.plot()
    plt.show()

def isClubExist(prompt):
    ID_CLUB = int(input(prompt))
    result = connection.execute("SELECT EXISTS(SELECT 1 FROM store WHERE store_id = %s) AS StoreExist;" %(ID_CLUB))
    row = result.fetchone()
    if bool(row['StoreExist']) == False:
        print("Ce Vidéo Club n'existe pas.")
        ID_CLUB = isClubExist(prompt)
    return ID_CLUB

def isCatExist(prompt):
    ID_CAT = int(input(prompt))
    result = connection.execute("SELECT EXISTS(SELECT 1 FROM category WHERE category_id = %s) AS CategoryExist;" %(ID_CAT))
    row = result.fetchone()
    if bool(row['CategoryExist']) == False:
        print("Cette Catégorie n'existe pas.")
        ID_CAT = isCatExist(prompt)
    return ID_CAT
Menu()