#!/usr/bin/env python
# coding: utf-8

# In[2]:


print ('Programme équation de second degrés')
print ('')
print ('Nous allons éxecuter ensemble la formule Mathématique Δ=b²-4*a*c')
print ('')
print ('veuillez isoler votre "a","b","c"' )
print ('')
from math import sqrt
a = int(input('Entrez la valeur de votre A = '))
b = int(input('Entrez la valeur de votre B = '))
c = int(input('Entrez la valeur de votre C = '))
Δ = ((b**2)-4*a*c)
print ('')
print('Le resultat de vôtre Delta (Δ) est =',Δ)
print('')
r = (sqrt(Δ))
print ('Nous allons calculer la valeurs de x1 via ce calcul: x1=-b-√Δ/2*a')
x1 = (-b-r)/(2*a)
print("")
print ("Le resultat de x1 est =" ,x1)
print("")
print ('Nous allons calculer la valeurs de x2 via ce calcul: x1=-b+√Δ/2*a')
x2 = (-b+r)/(2*a)
print("")
print ("Le resultat de x2 est =" ,x2)


# In[ ]:





# In[ ]:




