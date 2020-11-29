
import sqlalchemy 
import pandas as pd
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql import text
from sqlalchemy import create_engine
from jinja2 import Environment, FileSystemLoader 
import hashlib
#import CONFIGG
#import flask
from flask import * 

app = Flask(__name__)
#app.config.from_object(Config)

#app.config['SECRET_KEY']='Ma super secret key'

"""app.config.from_object(config)
print(config.CONFIGG['SECRET_KEY'])
capp = app.config['CONFIGG']"""

app.config.update( 
    SECRET_KEY  = 'ma cle secrete'
)

engine = create_engine('mysql+pymysql://simplon:Simplon2020@localhost:3306/perrenot')
con=engine.connect()

@app.route('/', methods=['GET','post'])
def home():
     
    return render_template('pages/index1.html')
#**************************************************************************************contact************************************************
@app.route('/contact', methods=['GET','post'])
def contact():
     
    return render_template('pages/index1.html')
#***********************************************************************Ajouter chauffeur**********************************************************************
#
@app.route('/ajouter_chauf', methods=['GET','post'])
def ajouter_chauf():
    if request.method=='POST':
        nom=request.form['nom']
        prenom=request.form['prenom']
        cout=request.form['horaire']
        panier1=request.form['panier1']
        panier2=request.form['panier2']
        panier3=request.form['panier3']
        #con.execute(text(insert into chauffeur ))
    return render_template('pages/ajouter_chauf.html')
    

#***********************************************************************valider suppression**************************************************************
@app.route('/chaufeur_supprime', methods=['GET','post'])
def chauffeur_supprime():
    chauf=request.form['chauf_select']
    print('confirmation chauffeur supprimé',chauf)
    return render_template('pages/modifier_chauf.html')
    
#***********************************************************************valider modification*****************************************************************

@app.route('/chaufeur_modifié', methods=['GET','post'])
def chauffeur_modifie():
    nom=request.form['nom'] 
    prenom=request.form['prenom']
    print('formulailre de la fenetre modale envoyée avec succes', nom, prenom)
    return render_template('pages/modifier_chauf.html')





#*************************************************************Modifier un Chauffeur********************************************************************
@app.route('/modification_chauffeur', methods=['GET','post'])
def modifier_chauf():
    rech_chauf=''
    chauf_select=''
    chauf_info=[ '' for i in range(9)]
    liste_chauf= con.execute(text("select chauf_nom, chauf_prenom, chauf_cout_horaire, chauff_panier1, chauff_panier2, chauff_panier3, statut_intitule, date_debut, date_fin, chauf_id   from chauffeur left join  chauffeur_statut on chauffeur_statut.chauff_id= chauffeur.chauf_id left join statut on statut.statut_id = chauffeur_statut.statut_id where date_fin>date(now()) or date_fin is null")).fetchall()
    data={ 'liste_chauf': liste_chauf,
            'rech_chauf':rech_chauf, 
            'chauf_info':chauf_info,
            'test':'bonjour'
    }
       
    if request.method=='POST':
        # Si l utilisateur a tapé un nom dans la bare de recherche:
        if request.form['rech_chauf']:
            rech_chauf=request.form['rech_chauf']
            liste_chauf_rech=con.execute(text("select chauf_nom, chauf_prenom, chauf_cout_horaire, chauff_panier1, chauff_panier2, chauff_panier3, statut_intitule, date_debut, date_fin   from chauffeur left join  chauffeur_statut on chauffeur_statut.chauff_id= chauffeur.chauf_id left join statut on statut.statut_id = chauffeur_statut.statut_id where (date_fin>date(now()) or date_fin is null) and chauf_nom = :chauf  "), {'chauf':rech_chauf}).fetchall()
            print('chaufeuuuuuuuuuuuuuuuuuuuuuuur selectioné11111111111111111', request.form['chauf_select'])
            if liste_chauf_rech:
                data['liste_chauf']=liste_chauf_rech
            else:
                flash(' aucun chauffeur avec ce nom','danger')
            return render_template('pages/modifier_chauf.html', **data)   
        # si l utilisateur a coché un nom:
            
            
        if request.form['chauf_select']!='':
            print('chaufeuuuuuuuuuuuuuuuuuuuuuuur selectioné222222222222222222', request.form['chauf_select'])
            chauf_select=request.form['chauf_select']
            chauf_info=con.execute(text("select chauf_nom, chauf_prenom, chauf_cout_horaire, chauff_panier1, chauff_panier2, chauff_panier3, statut_intitule, date_debut, date_fin   from chauffeur left join  chauffeur_statut on chauffeur_statut.chauff_id= chauffeur.chauf_id left join statut on statut.statut_id = chauffeur_statut.statut_id where chauf_id=:chauf_select and (date_fin>date(now()) or date_fin is null) "), {'chauf_select':chauf_select}).fetchone()
            data['chauf_info']=chauf_info
            #return render_template('pages/modifier_chauf.html', **data)
        print('chauffeeeeeeeeeeeeeeeeeeeeeur_info', chauf_info)

    return render_template('pages/modifier_chauf.html', **data)   
    
#*******************************************************************************Ajouter un utilisateur*****************************************************************

@app.route('/ajout_utilisateur', methods=['GET','post'])
def ajouter_user():
    Fpseudo=''
    Frole,Fmdp,FCmdp,Fnom,Fprenom='','','','',''
    requete_role="select role_id, role_intitule from role"
    role=con.execute(text(requete_role)).fetchall()
    role_n=[row[0] for row in role]
    nbre_role=len(role_n)
    data={
                'role_selec':Frole,
                'role':role,
                'nbre_role' : nbre_role,
                'pseudo':Fpseudo,
                'mdp':Fmdp,
                'Cmpd':FCmdp,
                'nom':Fnom,
                'prenom':Fprenom
         }
    if request.method =='POST':
        Frole=request.form['liste_roles']
        Fpseudo=request.form['pseudo']
        Fnom=request.form['nom']
        Fprenom=request.form['prenom']
        Fmdp=request.form['mdp']
        FCmdp=request.form['Cmdp']
        requet_pseudo=text('select utilisateur_id from utilisateur where utilisateur_pseudo=:pseudo')
        pseudo=con.execute(requet_pseudo,{'pseudo':Fpseudo}).fetchone()
        
        if pseudo:
            flash('ce pseudo existe déjà, veuillez le changer', 'danger')
        elif request.form['mdp'] != request.form['Cmdp']:
            flash('les deux mots de passe ne correspondent pas','danger')
        else:
            Fmdp=hashlib.sha1(str.encode(Fmdp)).hexdigest()
            #requete_ajout="call create_utilisateur(:nom,:prenom,:mdp,:pseudo, :role)"
            requete_ajout="INSERT INTO utilisateur (utilisateur_nom, utilisateur_prenom, utilisateur_MDP, utilisateur_pseudo, role_id) VALUES (:nom, :prenom, :mdp, :pseudo,:role)"

            con.execute(text(requete_ajout),{'nom': Fnom, 'prenom':Fprenom, 'mdp':Fmdp, 'pseudo':Fpseudo,'role':Frole})
            #con.execute(text("call create_utilisateur('Janvier','fevier','mars','pseudo', 2)"))
            flash("l'utilisateur a été bien enregistré", 'success')
            Fpseudo=''
            Fnom=''
            Fprenom=''
            Fmdp=''
            FCmdp=''
            Frole=''
        data['pseudo']=Fpseudo 
        data['nom']  =Fnom 
        data['prenom']=Fprenom
        data['mdp']=Fmdp
        data['role_selec']=Frole
        return render_template('pages/ajouter_utilisateur.jinja', **data)   
        
    else:
        
        return render_template('pages/ajouter_utilisateur.jinja', **data)    

#***********************************************************************************Ajouter un MAGASN**************************************************************************
@app.route('/ajout_magasin', methods=['GET','post'])
def ajouter_magasin():
    Fcode=''
    Fadresse=''
    Fheure=''
    Frolls=0
    Fpal=0
    Fbox=0
    Fenseigne=''
    requete_ens="select enseigne_id, enseigne_intitulé from enseigne"
    enseigne=con.execute(text(requete_ens)).fetchall()
    ens_n=[row[0] for row in enseigne]
    nbre_ens=len(ens_n)
    data={
                'code':Fcode,
                'adresse':Fadresse,
                'heure' : Fheure,
                'rolls':Frolls,
                'palette':Fpal,
                'boxe':Fbox,
                'nbre_ens':nbre_ens,
                'enseigneS':Fenseigne,
                'enseigne':enseigne
         }
    if request.method =='POST':
        Fcode=request.form['code']
        Fadresse=request.form['adresse']
        Fheure=request.form['heure']
        Frolls=request.form['rolls']
        Fpal=request.form['palette']
        Fbox=request.form['boxe']
        Fenseigne=request.form['liste_ens']
        requet_magasin=text('select magasin_id from magasin where magasin_code=:code and enseigne_id=:enseigne')
        magasin=con.execute(requet_magasin,{'code':Fcode, 'enseigne':Fenseigne}).fetchone()
        if magasin:
            flash('ce code magasin existe déjà pour cette enseigne, veuillez le changer', 'danger')
        else:
            requete_ajout="INSERT INTO magasin (magasin_code, magasin_adresse, magasin_heure_livr, magasin_tarif_rolls, enseigne_id, magasin_tarif_palette, magasin_tarif_boxe) VALUES (:code, :adresse, :heure, :rolls,:enseigne, :pal, :boxe)"

            con.execute(text(requete_ajout),{'code': Fcode, 'adresse':Fadresse, 'heure':Fheure, 'rolls':Frolls,'enseigne':Fenseigne,'pal':Fpal, 'boxe':Fbox})
            flash("le magasin a été bien enregistré", 'success')
            Fcode=''
            Fadresse=''
            Fheure=''
            Frolls=''
            Fpal=''
            Fbox=''
            Fenseigne=''
        data['code']=Fcode
        data['adresse']  =Fadresse 
        data['heure']=Fheure
        data['rolls']=Frolls
        data['palette']=Fpal
        data['boxe']=Fbox
        data['enseigneS']=Fenseigne
        return render_template('pages/ajouter_magasin.html', **data)   
        #return redirect(url_for('ajouter_user'))
    else:
        
        return render_template('pages/ajouter_magasin.html', **data)    

#**************************************************************************************Ajouter statut à un chauffeur**********************************************************
@app.route('/ajout_statut', methods=['GET','post'])
def ajouter_statut_chauf():
    
    #liste chauffeurs
    requete_chauf="select chauf_id, chauf_nom, chauf_prenom, concat(chauf_nom,'---' ,chauf_prenom) as NP from chauffeur where chauf_actif=1"
    liste_chauf=con.execute(text(requete_chauf)).fetchall()
    
     #liste statuts
    requete_statu=" select STATUT_ID, STATUT_INTITULE from statut"
    liste_statut=con.execute(text(requete_statu)).fetchall()

    
    data={
                'liste_chauf':liste_chauf,
                'liste_statut':liste_statut,
                
         }
    if request.method== 'POST':
        chauf_id=request.form['liste_chauf']  
        statut_id=request.form['liste_statut']
        date_debut=request.form['date_D']
        date_fin=request.form['date_F']
        requete_date_fin=' select chauff_id, date_fin from chauffeur_statut where chauff_id=:chauf_id and (date_fin > :date_debut) '  
        ver_date_fin=con.execute(text(requete_date_fin), {'chauf_id':chauf_id , 'date_debut':date_debut}).fetchall()
        
        if date_debut>date_fin:
            flash('la date fin doit être supperieure à la date début', 'danger')
        elif ver_date_fin :
            flash('ce chauffeur a déjà un statut pour cette date', 'danger') 
        else:
            con.execute(text('insert into chauffeur_statut (chauff_id, statut_id, date_debut, date_fin) values (:chauf_id, :statut_id, :date_debut, :date_fin)'), {'chauf_id':chauf_id, 'statut_id':statut_id, 'date_debut': date_debut, 'date_fin': date_fin})    
            flash('ce statut a été ajouté avec succès à ce chauffeur', 'success') 
        
            
    
    return render_template('pages/ajouter_statut_chauf.jinja', **data)    


  #resultat_pseudo=request.args.get('resultat_pseudo')
    
#*************************************************************************************************Ancienne Selection des magasins à livrer ********************************************   

@app.route('/selection-enseigne', methods=['get','post'])
def selection_ens():
    Test=False
    Fenseigne=''
    cpt=0
    magasin_jour = pd.DataFrame(columns=['magasin_code','nbre_rolls','nbre_pal','nbre_box'])
    requete_nbre_ens='select count(*) from enseigne'
    nbre_ens=con.execute(text(requete_nbre_ens)).fetchone()[0]
    requete_ens='select enseigne_id,enseigne_intitulé from enseigne'
    liste_enseigne=con.execute(text(requete_ens)).fetchall()
    
    requete_camion="call liste_camion()"
    camion=con.execute(text(requete_camion)).fetchall()
    liste_camion= [row[0] for row in camion]
    nbre_camion=len(liste_camion)

    # récupérer le nombre d 'eneignes et les enseignes, camion et nbre camion pour les afficher dans la page

    data={
                'nbre_ens': nbre_ens,
                'L_enseigne': liste_enseigne,
                'camion' : camion,
                'nbre_camion':nbre_camion,
                'test':Test,
                'enseigne': Fenseigne,
                'magasin_jour': magasin_jour,
                'cpt':cpt
        }
    if request.method== 'POST':
        Test=True 
        data['test']  = Test   
        Fenseigne=request.form.getlist('liste_ens') #liste enseigne_id cochées
        Fcamion=request.form.getlist('liste_camion')
        data['nbre_ens_selec']=len(Fenseigne)
        Fenseigne_intit=con.execute(text("select enseigne_id, enseigne_intitulé from enseigne where enseigne_id in :enseigne"),{'enseigne':Fenseigne}).fetchall()
        data['enseigne_intit']=Fenseigne_intit
        
        #mag_id=con.execute(text("select magasin_id from magasin where enseigne_id=:enseigne"),{'enseigne':Fenseigne[0][0]}).fetchall()
        liste_mag=[con.execute(text("select magasin_code,magasin_id from magasin where enseigne_id=:enseigne"),{'enseigne':Fenseigne[j][0]}).fetchall() for j in range(len(Fenseigne))]
        L1=[]
        L2=[]
        L3=[]
        L4=[]
        for i in range(len(liste_mag)):
            for mag in liste_mag[i]:
                L1.append(mag[0])
                L2.append(0)
                L3.append(0)
                L4.append(0)
        magasin_jour['magasin_code']=L1
        magasin_jour['nbre_rolls']=L2
        magasin_jour['nbre_pal']=L3
        magasin_jour['nbre_box']=L4
        magasin_jour.reset_index(inplace=True)
        print( magasin_jour)
        
        data['liste_mag']=liste_mag
        data['camionC']=Fcamion
        data['magasin_jour']=magasin_jour
        
        requete_magasin='select magasin_id, magasin_code from magasin where enseigne_id in :enseigne'
        magasin=con.execute(text(requete_magasin),{'enseigne':Fenseigne}).fetchall() # récupérer des magasins des enseignes cochés
        data['magasin']=magasin
        data['nbre_mag']=len(magasin)
        
    return render_template('pages/selection_ens.jinja', **data)

#*******************************************************************************************************Selection magasin****************************************************
@app.route('/selection-magasin', methods=['post'])
def selection_mag():
    #récupérer les camions cochés
    camion=request.form.getlist('liste_camion')
    print("coucou1")
    requete_camion="select camion_mat, camion_cap from camion where camion_mat in :camion"
    print("coucou2")
    camion_code=con.execute(text(requete_camion),{'camion':camion})
    print('ENSEIGNE',camion_code)
    #requete_mag='select magasin_code from magasin where enseigne_id in :enseigne_id'
    #magasin=con.execute(text(requete_mag),{'enseigne_id':enseigne_id}).fetchall()
    
    # récupérer le nombre d 'eneignes et les enseignes pour les afficher dans la page
    data={
            'camion': camion_code
        }
       
    #return render_template('pages/valider_tournée.jinja', **data)
    return render_template('pages/contact.jinja', **data)

#********************************************************************************************************recente selection magasin***********************************************************
@app.route('/selection_enseigne', methods=['get','post'])
def selection_ens_recente():

    requete_nbre_ens='select count(*) from enseigne'
    nbre_ens=con.execute(text(requete_nbre_ens)).fetchone()[0]
    requete_ens='select enseigne_id,enseigne_intitulé from enseigne'
    liste_enseigne=con.execute(text(requete_ens)).fetchall()
    
    requete_camion="call liste_camion()"
    camion=con.execute(text(requete_camion)).fetchall()
    liste_camion= [row[0] for row in camion]
    nbre_camion=len(liste_camion)
    liste_mag=[con.execute(text("select magasin_code,magasin_id from magasin where enseigne_id=:enseigne"),{'enseigne':liste_enseigne[j][0]}).fetchall() for j in range(len(liste_enseigne))]
       
    # récupérer le nombre d 'eneignes et les enseignes, camion et nbre camion pour les afficher dans la page

    data={
                'nbre_ens': nbre_ens,
                'L_enseigne': liste_enseigne,
                'camion' : camion,
                'nbre_camion':nbre_camion,
                'liste_mag': liste_mag
                
        }
       
    if request.method=='POST' :
        camion_coche=request.form.getlist('liste_camion')
        date=request.form['date']
        excel=request.form['fichier_excel']
        print('camion cachés .....', camion_coche)
        mag_selc=request.form.getlist('mag')
        rolls=request.form.getlist('rolls')
        palette=request.form.getlist('palette')
        box=request.form.getlist('box')
        #récupérer info des camions cochés

        detail_cam_coch=con.execute(text("select camion_mat, camion_cap, camion_tonnage from camion where camion_mat in :camion_coche"),{'camion_coche': camion_coche}).fetchall()
        nbre_rolls,nbre_pal,nbre_boxe=[],[],[]
        print ('AVANNNT  ROLLS',rolls,'PALETTE' ,palette,'BOX', box)
        cpt=len(rolls)
        for i in range(cpt):
            if not (rolls[i]=='' and palette[i]=='' and box[i]==''):
               print("je suis dedans")
               nbre_rolls.append(rolls[i])
               nbre_pal.append(palette[i])
               nbre_boxe.append(box[i])
        data['mag_selc']=mag_selc     
        data['date']=date
        data['excel']=excel  
        data['camion_coch']=detail_cam_coch
        print(nbre_pal, nbre_boxe, nbre_rolls,detail_cam_coch)               

        return render_template('pages/selection_ens_recente.jinja',**data)

    return render_template('pages/selection_ens_recente.jinja',**data)
    #return 'contact'

 #******************************************************************************************************Valider les TOURNEES**********************************************************       
@app.route('/tournee', methods=['get','post'])
def valider_tournee():
    
    #récupérer le nombre de magains à livrer (sont stockés dans la table magasin_journalier)
    requete_nbre_mag='select count(*) from magasin_journalier'
    nbre_mag=con.execute(text(requete_nbre_mag)).fetchone()[0]

    #récupérer les info des magasins à livrer
    requete_mag_code='select magasin_code,nbre_rolls,nbre_pal,nbre_boxe from magasin_journalier '
    mag_code=con.execute(text(requete_mag_code)).fetchall()

    #récupérer la liste des camion cochés
    camion=request.form.getlist('liste_camion')
    requete_camion="select camion_mat, camion_cap from camion where camion_mat in :camion"
    liste_camion=con.execute(text(requete_camion),{'camion':camion}).fetchall()
    nbre_camion=len([row[0] for row in liste_camion])
    #récupérer la liste des chauffeurs dispo
    requete_chauffeur='call liste_chauffeur()'
    chauffeur=con.execute(text(requete_chauffeur)).fetchall()
    liste_chauffeur = [row[0] for row in chauffeur]
    nbre_chauffeur=len(liste_chauffeur)
    
    # données à envoyer a la page valider_tournée
    data={
                'nbre_mag': nbre_mag,
                'mag_code': mag_code,
                'chauffeur': chauffeur,
                'liste_chauffeur':liste_chauffeur,
                'nbre_chauffeur':nbre_chauffeur,
                'liste_camion':liste_camion,
                'nbre_camion':nbre_camion
            }
    
    return render_template('pages/valider_tournée.jinja', **data)
    #return'tourne'
#*************************************************************************************************Identification***************************************************************        
@app.route('/authentification', methods=['post', 'get'])
def identification():
    pseudo=''
    nom=''
    prenom=''
    data={
            'nom': nom ,
            'prenom': prenom,
            'pseudo':pseudo
        }
    if request.method== 'POST':
        
        mot_de_pass=request.form['mdp']
        mot_de_pass=hashlib.sha1(str.encode(mot_de_pass)).hexdigest() # crypter le mot de passe tapé et le comparer avec celui qui est enregitré dans la BDD
        pseudo=request.form['pseudo']
        
        requete_role="select role_id as id from utilisateur where utilisateur_pseudo=:pseudo and utilisateur_MDP=:pass"
        requete_nom="select utilisateur_nom as nom from utilisateur where utilisateur_pseudo=:pseudo and utilisateur_MDP=:pass"
        requete_prenom= "select utilisateur_prenom as prenom from utilisateur where utilisateur_pseudo=:pseudo and utilisateur_MDP=:pass" 

              
        role=con.execute(text(requete_role),{'pass':mot_de_pass, 'pseudo':pseudo}).fetchone()
        nom=con.execute(text(requete_nom),{'pass':mot_de_pass, 'pseudo':pseudo}).fetchone()
        prenom=con.execute(text(requete_prenom),{'pass':mot_de_pass, 'pseudo':pseudo}).fetchone()
        data['pseudo']=pseudo
        data['nom']=nom
        data['prenom']=prenom
        
        if role is None: 
            flash(' pseudo et mot de passe ne correspondent pas, Veuillez vérifier votre saisie','danger')
            return render_template('pages/index1.html',**data)
            
        elif role[0]==1:
            return render_template('pages/accueil_admin.html',**data)
        
        elif role[0]==2:
            return render_template('pages/accueil_agent.html',**data)
    return render_template('pages/accueil_admin.html',**data)    
            
        
            

#**********************************************************************************changement MDP********************************************************************************      

    #return render_template('pages/index1.html',**data)
        
@app.route('/changement_mdp', methods=['post'])
def change_mdp():
    # connexion BDD
    pseudo=''
    nom=''
    prenom=''
    data={
            'nom': nom ,
            'prenom': prenom,
            'pseudo':pseudo
        }
    if request.method== 'POST':
        
        mot_de_pass=request.form['mdp']
        mot_de_pass=hashlib.sha1(str.encode(mot_de_pass)).hexdigest() # crypter le mot de passe tapé et le comparer avec celui qui est enregitré dans la BDD
        pseudo=request.form['pseudo']
        
        requete_role="select role_id as id from utilisateur where utilisateur_pseudo=:pseudo and utilisateur_MDP=:pass"
        requete_nom="select utilisateur_nom as nom from utilisateur where utilisateur_pseudo=:pseudo and utilisateur_MDP=:pass"
        requete_prenom= "select utilisateur_prenom as prenom from utilisateur where utilisateur_pseudo=:pseudo and utilisateur_MDP=:pass" 

              
        role=con.execute(text(requete_role),{'pass':mot_de_pass, 'pseudo':pseudo}).fetchone()
        nom=con.execute(text(requete_nom),{'pass':mot_de_pass, 'pseudo':pseudo}).fetchone()
        prenom=con.execute(text(requete_prenom),{'pass':mot_de_pass, 'pseudo':pseudo}).fetchone()
        
               
        data['pseudo']=pseudo
        
        if role is None: 
            flash('ce pseudo n existe pas, veuillez vérifier votre saisie', 'danger')
            return 'pseudo ou mot de passe ne sont pas corrects'
            
        elif role[0]==1:    
            
            return render_template('pages/accueil_admin.html',**data)
            
        else:
            return "bonjour agent d exploitation"       


if __name__=='__main__':
     app.run(debug=True, port=3000)