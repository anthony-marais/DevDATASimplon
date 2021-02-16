#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 19 11:12:44 2020

@author: virus
"""

import random

HOW=["Comment allez-vous ?", "Pourquoi venez-vous me voir ?", "Comment s’est passée votre journée ?"]

FAMILLY=["père", "mère", "copain", "copine", "maman", "papa", "ami", "amie"]

QUESTIONNING=["Comment va votre {} ?", "La relation avec {} vous pose-t-elle problème ?", "Pourquoi pensez-vous en ce moment à votre {}"]

QUESTIONNING_2=["Pourquoi me posez-vous cette question ?", "Oseriez-vous poser cette question à un humain ?","Je ne peux malheureusement pas répondre à cette question."]

RANDOMING=["J’entends bien.", "Je sens une pointe de regret.","Est-ce une bonne nouvelle ?", "Oui, c’est ça le problème.","Pensez-vous ce que vous dites ?","Hum... Il se peut."]

HOW_QUESTIONNING=["je vais bien merci","Un peu fatigué mais ça va"]

HUMEUR=[]

print(HOW[random.randint(0, len(HOW)-1)])
response = input()


if "toi" in response or "vous" in response:
    print(HOW_QUESTIONNING[random.randint(0, len(HOW_QUESTIONNING)-1)])

print("Comment vous sentes-vous ?")
response = input()






while response:

    for i in FAMILLY:
        if i in response:
            print(QUESTIONNING[random.randint(0, len(QUESTIONNING)-1)].format(i))
            
    
        if "?" in response:
            print(QUESTIONNING_2[random.randint(0, len(QUESTIONNING_2)-1)].format(i))
            response=input()
            
        else:
            print(RANDOMING[random.randint(0, len(RANDOMING)-1)].format(i))
            response=input()
        
            