#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 19 14:08:23 2020

@author: virus
"""

import random 
import time

intro = ["Comment allez-vous ?", "Pourquoi venez-vous me voir ?", "Comment s'est passée votre journée ?"]
familly = ["père", "mère", "copain", "copine", "maman", "papa", "ami", "amie"]
responses = ["Comment va votre {}", "La relation avec votre {} vous pose t'elle problème?", "Pourquoi pensez vous en ce moment à votre {}?"]
interogations = ["Pourquoi me posez-vous cette question ?", "Oseriez-vous poser cette question à un humain ?", "Je ne peux malheureusement pas répondre à cette question"]
vague = ["J'entends bien", "je sens une pointe de regret", "Est-ce une bonne nouvelle ?", "Oui, c'est ça le problème", "Pensez-vous ce que vous dites ?", "Hum... Il se peut"]
introReponse = ["Je vais bien merci", "un peu fatigué mais ça va"]
humeur = ["fatigué", "forme", "joyeux", "triste", "excité", "colère", "ennuyé", "pas top", "pas bien", "bien"]
exclamation = ["c'est fort","rester calme","vous allez bien ?","besoin d'aide ?"]



print(intro[random.randint(0, len(intro)-1)])
response = input()
if "toi" in response or "vous" in response:
    print(introReponse[random.randint(0, len(introReponse)-1)]) 



print("comment vous sentez-vous ?")
response = input()

while response:



    for i in humeur:
        if i in response:
            time.sleep(1.5)
            print("Pourquoi vous sentez vous {}".format(i))
            response= input()
    
    for i in familly:
        if response in familly and "!" in familly:
            print(exclamation[random.randint(0, len(exclamation)-1)])
            response = input()
            
    for i in familly:
        if i in response:
            print(responses[random.randint(0, len(responses)-1)].format(i))
            reponse = input()


    if "?" in response:
        print(interogations[random.randint(0, len(interogations)-1)])
        response = input()
        
    
    
    else:
        print(vague[random.randint(0, len(vague)-1)])
        response = input()
        
        