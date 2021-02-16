#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 22 10:52:20 2020

@author: simplon
"""
#import matplotlib.pyplot as plt
#import tkinter as tkr 
import pandas as pd 
import sqlalchemy
from sqlalchemy import create_engine
engine = create_engine('mysql+pymysql://root:Simplon1!@localhost:3306/sakila')

villes = pd.read_sql_query('SELECT city.city FROM city JOIN address ON address.city_id = city.city_id JOIN store on store.address_id = address.address_id  ORDER BY city.city',engine)

print ("1.Lethbridge")
print ("2.Woodridge")

choix_store = input("Quels numero de  villes souhaitez vous selectionné? \n --> ")

while (not choix_store in ['1', '2']):
    choix_store = input("Choisissez 1 ou 2: ")
    
evolution_location = pd.read_sql_query('select count(rental.rental_id) as nb_location , date(rental.rental_date) as date from rental JOIN inventory ON inventory.inventory_id = rental.inventory_id JOIN store on store.store_id = inventory.store_id JOIN address on address.address_id = store.address_id JOIN city on city.city_id = address.city_id WHERE store.store_id = %s  GROUP BY date;'%(choix_store),engine)
 
evolution_location.plot(kind='line', x='date', y="nb_location", title= 'evolution des locations',grid='default' ,figsize=(20,10))
print(evolution_location)

num_category = pd.read_sql_query("select category_id as n°, name from category;",engine)
print(num_category)
choix_category = input("selectionner une categorie parmi celles proposées \n --> ")

while (not (choix_category.isdecimal() and int(choix_category) in range(17))):
    choix_category = input("Choisissez entre 1 et 16: ")

category = pd.read_sql_query('select count(rental.rental_id) as nbr_location , date(rental.rental_date) as date, store.store_id , category.name  from rental JOIN inventory ON inventory.inventory_id = rental.inventory_id JOIN store on store.store_id = inventory.store_id JOIN address ON address.address_id = store.address_id JOIN city ON city.city_id = address.city_id JOIN film ON film.film_id = inventory.film_id JOIN film_category on film_category.film_id = film.film_id JOIN category ON category.category_id = film_category.category_id WHERE store.store_id = %s and category.category_id=%s GROUP BY date;'%(choix_store,choix_category),engine)
print(category)



category.plot(kind='line', x='date', y="nbr_location", title= 'evolution des locations de category',grid='default' ,figsize=(20,10))
print(choix_category)
