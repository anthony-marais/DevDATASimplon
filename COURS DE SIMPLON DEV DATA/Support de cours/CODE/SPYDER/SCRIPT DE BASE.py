#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul 20 13:48:44 2020

@author: virus
"""
import pandas as pd
from sqlalchemy import create_engine
engine = create_engine('mysql+pymysql://root:Viruscloud1:@127.0.0.1:3306/simplon')

data = pd.read_sql_query('SELECT * FROM jeux_video',engine)
print(data)

print (engine.execute('SELECT * FROM jeux_video'))
