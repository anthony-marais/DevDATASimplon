#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 22 10:52:20 2020

@author: simplon
"""


import pandas as pd 
import sqlalchemy
from sqlalchemy import create_engine
engine = create_engine('mysql+pymysql://simplon:Simplon123*@localhost:3306/sakila')
import matplotlib.pyplot as plt
import tkinter as tkr 

villes = pd.read_sql_query('SELECT c.city FROM city as c join address as a on a.city_id = c.city_id join store as s on s.address_id = a.address_id  order by c.city',engine)

print ("1.Lethbridge")
print ("2.Woodridge")

utilisateur = input("Quels numero de  villes souhaitez vous selectionné?")

while (not utilisateur in ['1', '2']):
    utilisateur = input("Choisissez 1 ou 2: ")
    
location = pd.read_sql_query('select count(r.rental_id) as nbr_location,date(r.rental_date) as date  from rental as r join inventory as i on i.inventory_id = r.inventory_id join store as s on s.store_id = i.store_id join address as a on a.address_id = s.address_id join city as c on c.city_id = a.city_id where s.store_id = %s  group by date;'%(utilisateur),engine)
 
location.plot(kind='line', x='date', y="nbr_location", title= 'evolution des locations',grid='default' ,figsize=(20,10))
print(location)

num_category = pd.read_sql_query("select category_id as n°, name from category;",engine)
print(num_category)
choix_category = input("selectionner une categorie parmi celles proposées")

while (not (choix_category.isdecimal() and int(choix_category) in range(17))):
    choix_category = input("Choisissez entre 1 et 16: ")

category = pd.read_sql_query('select count(r.rental_id) as nbr_location,date(r.rental_date) as d,s.store_id,ca.name  from rental as r join inventory as i on i.inventory_id = r.inventory_id join store as s on s.store_id = i.store_id join address as a on a.address_id = s.address_id join city as c on c.city_id = a.city_id join film as f on f.film_id = i.film_id join film_category as fa on fa.film_id = f.film_id join category as ca on ca.category_id = fa.category_id where s.store_id = %s and ca.category_id=%s group by d;'%(utilisateur,choix_category),engine)
print(category)



category.plot(kind='line', x='d', y="nbr_location", title= 'evolution des locations de category',grid='default' ,figsize=(20,10))
print(choix_category)
