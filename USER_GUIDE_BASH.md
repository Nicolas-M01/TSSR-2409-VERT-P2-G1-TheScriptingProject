
## ▶️ Guide utilisateur
---
#### Sommaire
#### :one: [Présentation du menu](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/edit/main/USER_GUIDE.md#arrow_forward-fonctionnalit%C3%A9s-de-base-et-avanc%C3%A9es)  
#### :two: [Affichage et enregistrement des résultats dans fichier info](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/edit/main/USER_GUIDE.md#arrow_forward-affichage-et-enregistrement-des-r%C3%A9sultats-dans-fichier-info)
#### :three: [Fichier Log](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/edit/main/USER_GUIDE.md#arrow_forward-fichier-log)
#### :four: [Connection SSH](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/edit/main/USER_GUIDE.md#four-connection-ssh)
#### :five: [Arrêt du script](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/edit/main/USER_GUIDE.md#arrow_forward-arr%C3%AAt-du-script)
#### :six: [FAQ](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/edit/main/USER_GUIDE.md#interrobang-faq)

---
### :one: Présentation du menu

Le menu principal nous permet de choisir entre **`Utilisateur`** ou **`Ordinateur client`**  
#### `[1] Utilisateur`

![Menu Utilisateur1](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/menu1.png)  




#### `[2] Ordinateur client`

![Menu Utilisateur2](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/menu2.png)


Les parties Actions et Informations permettent d'obtenir une ou plusieurs informations et/ou d'effectuer une ou plusieurs actions. En effet la sélection peut être multiple.  Il suffit de rentrer les numéros de commandes souhaitées en espaçant chaque numéro et taper [Entrée]. Il est également possible de sélectionner des actions et des informations en même temps.  
La sélection fonctionne dans l'ordre croissant, décroissant et également en ordre aléatoire des chiffres :

![choix multiple](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/choix%20multiple.png)

Le résultat de la sélection ou les sélections s'affiche en dessous dans l'ordre de la sélection. Le script peut demander des informations complémentaires en fonction de la commande souhaitée, notamment un nom d'utilisateur ou une confirmation pour une action sensible.  

- Exemple : `Menu principal` :arrow_right: `[1] Utilisateur` :arrow_right: `[8] Date de dernière connection de l'utilisateur`.

Il suffit de rentrer l'utilisateur pour obtenir sa dernière connection :  



![COMMANDE 8](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/Commande%208.png)

---
  
### :two: Affichage et enregistrement des résultats dans fichier info

Pour la partie Information, il y a deux possibilités d'affichage.<br>
* Dans le cas d'une sélection unique, le script permet d'afficher directement la commande sélectionnée ainsi que le résultat à l'écran :

![Information Unique affichée Ecran](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/Affichage%20simple.png)


* Dans le cas d'une sélection multiple, le script va afficher les commandes sélectionnées mais les résultats seront directement sauvegardés dans un fichier texte.<br>

![Affichage multiple](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/Affichage%20multiple.png)

Ce fichier se trouve dans le répertoire de l'utilisateur actuel puis dans documents : 
>**`~/Documents/info_<cible>_<date>.txt`**<br>

La partie "cible" sera la cible renseignée après le choix de la commande, ou l'utilisateur actuel, si pas de cible spécifique.
La date est formatée sous la forme : YYYYMMDD  

![FICHIER INFO](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/Fichier%20info.png)

---

### :three: Fichier Log

Chaque sélection, que ce soit une Action ou une Information est enregistrée dans un fichier de Logs nommé **`log_evt.log`**, situé dans :

>**`/var/log/log_evt.log`**

Ce fichier permet de conserver une trace de tout ce qui a été effectué sur le script. Il affiche les commandes et leur numéro dans l'ordre d'exécution.  
Il affiche également les débuts et fin de script. L'affichage se présente sous la forme :  

>**`<date>-<heure>-<user>-<[n°commande]commande>`**

![Logs](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/Logs.png)

---
### :four: Connection SSH

Le script permet de se connecter en SSH sur les parties `Information`. En effet, lorsque l'on clique sur une demande d'Information, le script nous propose de rester sur la machine locale ou de nous connecter en SSH sur une machine cliente du même réseau afin d'en collecter les informations souhaitées.  
* Exemple :
 >##### [Menu Principal] :arrow_right: [2] Ordinateur Client :arrow_right: [6] Version de l'OS :arrow_right: [2] Machine distante :  
  Le script nous invite à renseigner l'adresse IP cible, puis l'utilisateur et la connection se fait automatiquement sans renseigner de mot de passe car les machines sont connectées en SSH avec une paire de clés SSH.
  
![Connection SSH](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/Information%20SSH.png)  

Les enregistrements dans le fichier des logs et le fichier des informations fonctionne de manière similaire aux commandes effectuées localement, à l'exeption que nous avons l'information de l'adresse IP et nom d'utilisateur de la machine distante dans le fichier Info.

![Fichir Infos SSH](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/fichier%20Info%20machine%20cliente%20SSH.png)
---
### :five: Arrêt du script

Le script est programmé pour tourner en boucle sauf en cas de grosse erreur. Après l'affichage des commandes, il propose de continuer ou de quitter le script. Il suffit de rentrer le choix correspondant. (Pour rappel, les démarrages et arrêts du script sont enregistrés dans le fichier des logs)

![Fin de script](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/Fin%20de%20script.png)

---
### :six: :interrobang: FAQ

L'historique des commandes tapées avec `history` est par défaut désactivé dans les scripts. Il faut le réactiver. Cette réactivation est prévue dans le script mais seulement au lancement de la commande `history` et elle va donc afficher les commandes avant le lancement du script. Une fois la commande `history` réactivée, elle va afficher les dernières lignes exécutées par le script, qui sont donc des commandes bash, sans grand intérêt. Pour éviter un spam de l'historique, il est limité aux 10 dernières actions.
