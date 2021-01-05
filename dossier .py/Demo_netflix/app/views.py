# coding: utf8
from app import app
#from app.models import get_fruits, get_fruit, insert_fruit, update_fruit, drop_fruit
from flask import render_template, request, abort, redirect, url_for
import datetime, pandas as pd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt
import seaborn as sns


engine = create_engine('mysql+pymysql://root:Leonne00@localhost/netflix')

@app.route('/')
def index():
    date = datetime.datetime.now().strftime("%x %X")
    return render_template( 'index.html', date=date)

@app.route('/directeur', methods=['GET','POST'] )
def directeur():
    date = datetime.datetime.now().strftime("%x %X")
    query = "SELECT * FROM netflix.director order by director;"
    list_dir = pd.read_sql_query(query, engine)
    return render_template( 'directeur.html', date=date, list_dir=list_dir)
    
@app.route('/dashboard_dir', methods=['GET','POST'] )
def dashboard_dir():
    date = datetime.datetime.now().strftime("%x %X")
    nom = request.form['nom_dir']
    
    query = 'select title from shows'
    query += ' join show_director on shows.show_id = show_director.show_id'
    query += ' join director on show_director.director_id = director.director_id'
    query += ' and director = "%s"'

    films_dir = pd.read_sql_query(query %(nom), engine)

    query2 = 'select listed_in from director'
    query2 += ' join show_director on show_director.director_id = director.director_id'
    query2 += ' join shows on shows.show_id = show_director.show_id'
    query2 += ' join show_listed_in on shows.show_id = show_listed_in.show_id'
    query2 += ' join listed_in on show_listed_in.listed_in_id = listed_in.listed_in_id'
    query2 += ' where director = "%s";'

    categorie = pd.read_sql_query(query2 %(nom), engine)


    palette=sns.color_palette("Paired")
    sns.set_palette(palette)
    plt.figure(figsize=[10,6])
    plt.subplot(111)

    sns.countplot(data=categorie, x="listed_in",order = categorie['listed_in'].value_counts().keys())
    plt.title("Nombre de films / catégorie")
    plt.xticks(rotation=10)
    plt.savefig('app/static/img/categorie.png')

    return render_template( 'dashboard_dir.html', date=date, nom=nom, films_dir=films_dir)
    
@app.route('/acteur')
def acteur():
    date = datetime.datetime.now().strftime("%x %X")
    return render_template( 'acteur.html', date=date)
