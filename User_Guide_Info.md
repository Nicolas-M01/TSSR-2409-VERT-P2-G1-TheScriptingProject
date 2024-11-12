
## Partie Information
---

### :arrow_forward: Fonctionnalités de base et avancées


La partie Information concerne la deuxième partie des choix du menu principal. Liste des informations disponibles pour la partie:  
* **[1] Utilisateur**  

![Menu Utilisateur1](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/menu1.png)  
  



Liste des informations disponibles pour la partie:
* **[2] Ordinateur client**

![Menu Utilisateur2](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/menu2.png)


La partie information permet d'obtenir une ou plusieurs informations. En effet la sélection peut être multiple. Il suffit de rentrer les numéros de commandes souhaités en espaçant chaque numéro et taper [Entrée]. La sélection fonctionne dans l'ordre croissant, décroissant et également en ordre aléatoire des chiffres :

![choix multiple](https://github.com/WildCodeSchool/TSSR-2409-VERT-P2-G1-TheScriptingProject/blob/main/Images/choix%20multiple.png)

Le résultat de la sélection ou les sélections s'affiche en dessous dans l'ordre de la sélection. Le script peut demander des informations complémentaires en fonction de la commande souhaitée, notamment un nom d'utilisateur.  
Exemple : `Menu principal` :arrow_right: `[2] Utilisateur` :arrow_right: `[8] Date de dernière connection de l'utilisateur`.  
Il suffit de rentrer l'utilisateur pour obtenir sa dernière connection.  



[PHOTO COMMANDE [8]]


  
#### :arrow_forward: Affichage et enregistrement des résultats

Pour la partie Information, il y a deux possibilités d'affichage.<br>Dans le cas d'une sélection unique, le script permet d'afficher directement la commande sélectionnée ainsi que le résultat à l'écran

[PHOTO Information Unique affichée Ecran]


Dans le cas d'une sélection multiple, le script va afficher les commandes sélectionnées mais les résultats seront directement sauvegardés dans un fichier texte.<br>
Ce fichier se trouve dans le répertoire de l'utilisateur actuel puis dans documents : 
>**`~/Documents/info_<cible>_<date>.txt`**<br>

La partie <cible> sera la cible renseignée après le choix de la commande, ou l'utilisateur actuel, si pas de cible spécifique.
La date est formatée sous la forme : YYYYMMDD  

[PHOTO FICHIER INFO]



#### :arrow_forward: Fichier Log

Chaque sélection, que ce soit une Action ou une Information est enregistrée dans un fichier de Logs nommé **`log_evt.log`**, situé dans :

>**`/var/log/log_evt.log`**

Ce fichier permet de conserver une trace de tout ce qui a été effectué sur le script. Il affiche les résultat

![Logs]
