def maFonction1():
    print('Hello World!')


maFonction1()
#=====
print('Hello World!')




#########################

def maFonction2(NomEcole):
    Ecole = input(NomEcole)
    if Ecole != "simplon":
        print("Ecole inconnu")
        maFonction2('Ecole: ')
    else:
        print("Formation par: "+Ecole)

maFonction2("Ecole: ")

#=====

Ecole = ''
while Ecole != "simplon":
    Ecole = input('Ecole: ')
    print("Ecole inconnu")
print("Formation par: "+Ecole)
