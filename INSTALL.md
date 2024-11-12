### Présentation technique du projet :
**********************************************
**SOMMAIRE**
##### * 1  Prérequis techniques :
* #####  2  Installations des ISO :
  * #####  2.1 Ubuntu 24.
  * #####  2.2 Debian 12.
  * #####  2.3 Windows 10.
  * ##### 2.4 Windows 2022.
* ##### 3 Configuration des ISO
  * ##### 3.1 Cartes Réseaux
  * ##### 3.2 IP statiques 
  * ##### 3.3 Ping
  * ##### 3.4 SSH
     * ##### 3.4.1 Instalation
     * ##### 3.4.2 Clé SSH + Test
* ##### 4 FAQ 
   






* #### 1 Prérequis techniques :
##### :large_blue_diamond: Diposer d'un ordinateur suffisament puissant pour acceuillir plusieurs VM:
##### :large_blue_diamond: Disque (SSD mini, nvme recommandé) 200Go.
##### :large_blue_diamond: Ram 16 Go minimun, 32 Go recomandé.
##### :large_blue_diamond: Processeur capable de prendre en charge la virtualisation
************************************************************************************
* ##### 2  Installations des ISO :
  * ##### 2.1 Ubuntu 24.
   * ##### Nom utilisateur et ISO : 
![VM1](https://github.com/user-attachments/assets/6e3b51a9-8991-40c7-a240-904cccbaad87)
![vm 2](https://github.com/user-attachments/assets/1cbe399b-1cc5-448f-86a3-d9bb9d43fcc5)
##### Ubuntu (safe graphics) : 
  ![vm3](https://github.com/user-attachments/assets/90d5c62c-c8fa-4ae5-bb04-8b3c0d196e6f)
##### Selectionner langue et Install Ubuntu : 
  ![vm 4](https://github.com/user-attachments/assets/a3d7e564-a4c4-455f-94b4-ac0ec7559fe5)
##### Keyboard : 
  ![vm5](https://github.com/user-attachments/assets/31c73ee2-ec35-482a-9e33-6f592b9f2dcb)
##### Normal Instalation :
![vm 6](https://github.com/user-attachments/assets/4270e182-1ab9-428b-8378-960a6b2f63f5)
##### Erase disk and Istall Ubuntu et Install Now
 ![vm 7](https://github.com/user-attachments/assets/d8bad10c-55ad-4f4b-980c-41e42f49878f)
##### Continue 
![vm 8](https://github.com/user-attachments/assets/a3ccc723-1f5c-4e80-bb9f-ac8e1bcbffd7)
##### Name and password  
![vm 9](https://github.com/user-attachments/assets/3eb8e0bd-24dd-4b97-86ae-ec628ced03b4)
##### Redémarrer
*********************************************
* ##### 2.2 Debian 12.
* ##### Nom utilisateur et ISO 
  ![VM 1](https://github.com/user-attachments/assets/c72bffd8-5888-4c73-a34f-fd0bce6d387c)
![vm 2](https://github.com/user-attachments/assets/8d2a5319-2cd0-4564-bda9-418e3b9ae8ea)
* ##### Installation graphique :
![image](https://belginux.com/content/images/2023/12/1.png)
* ##### Langue
  ![VM 1](https://github.com/user-attachments/assets/b39640a7-ed88-4c6a-8a1c-183a7830e22b)
* ##### Keyboard 
  ![VM 1](https://github.com/user-attachments/assets/cf576eb6-2df5-4050-9ae1-8422f4f54d6c)
  * ##### Laisser les champs par défauts : 
  ![image](https://github.com/user-attachments/assets/caf811f2-d826-4296-a7eb-af99b59ac55d)
  ![image](https://github.com/user-attachments/assets/019e42fd-7232-40a0-8823-ef308e0e1014)
* ##### Choisissez un mot de passe root
![image](https://github.com/user-attachments/assets/b8ab1690-378b-49b7-a1c1-96ab8a0a8b14)
* ##### Nom Utilisateur
  ![VM 1](https://github.com/user-attachments/assets/1c63a8ad-09f0-4f2e-afd9-c35066003f7b)
* ##### Mot de passe compte :
![VM 1](https://github.com/user-attachments/assets/44f7cf87-e243-4289-8859-2f75671d989a)
* ##### Disque 
 ![VM 1](https://github.com/user-attachments/assets/664d34bb-5dde-4755-8fc0-aa60297e653a)
##### Selectionner : All files..
![VM1](https://github.com/user-attachments/assets/3e83685d-282b-4d7a-860e-95d4290597dc)
##### Partition :
  ![VM 1](https://github.com/user-attachments/assets/21b7047e-5f90-455a-ac8a-f4170aaa9ab6)
##### Répondre selon vos envies au scan
##### Package manager
  ![vm 3](https://github.com/user-attachments/assets/a3d36b77-7795-4b5e-950a-5227e0888e7f)
##### cocher uniquement SSH server et standard system utilities
![VM1](https://github.com/user-attachments/assets/956735fa-4969-4d38-9c87-d4efdde0c298)
##### Reboot  
****************************************************
 * ##### 2.3 Windows 10.
 * ##### Désactiver la connection internet pour l'activation
  * ##### Nom utilisateur et ISO
  ![vm 2](https://github.com/user-attachments/assets/8bfb3fae-893a-4043-85b8-c7513b95fe64)
![VM 1](https://github.com/user-attachments/assets/af4771b1-1df3-4bb1-8473-e58ad6129ca3)
  * ##### Langue et clavier 
  ![VM 1](https://github.com/user-attachments/assets/2e139170-74c9-4e37-9ea8-b56158a93c50)
* ##### Install now
* ##### I don't have a product key
 ![VM 1](https://github.com/user-attachments/assets/0790ef16-9e7a-4a02-9b40-933ae195e75b)
* ##### Selectionner un produit 
  ![VM 1](https://github.com/user-attachments/assets/30bb84ad-fb6b-4b13-a8c5-5a5eb4ebdcb4)
* ##### Custom Install
![VM 1](https://github.com/user-attachments/assets/25b82752-47c3-47c1-a4c9-290eed66cab2)
* ##### Choix disque :
![VM 1](https://github.com/user-attachments/assets/db0a2e8e-8af4-4bda-90eb-d3f551a9c737)
* ##### Après avoir choisi la région et le clavier, Nom utilisateur
 ![VM 1](https://github.com/user-attachments/assets/30ac4cd3-cbc2-495c-8825-29af3bd172ad)
* ##### Créer un mot de passe utilisateur.
* ##### Répondre à la suite en fontion de vos envies. 
***************************************
* ##### 2.4 Windows 2022.
* ##### Nom utilisateur et ISO
![VM 1](https://github.com/user-attachments/assets/8ddefdae-ff14-48ee-ad35-054772f1e0c6)
![VM 1](https://github.com/user-attachments/assets/61773d93-1734-4caf-b53f-e029e7ac9827)
 * ##### Langue et clavier 
  ![VM 1](https://github.com/user-attachments/assets/2e139170-74c9-4e37-9ea8-b56158a93c50)
* ##### Type serveur
![VM 1](https://github.com/user-attachments/assets/2dcf1e43-a1a2-4365-8b58-b3911fafdbd6)
* ##### Custom puis choix disque : 
![VM 1](https://github.com/user-attachments/assets/5271dc88-e472-4031-a68d-f21aa913f973)


















* #### 3 Configuration des ISO
  * #### 3.1 Cartes Réseaux
  ##### Toutes le machines sont configurées avec deux cartes réseaux, afin de pouvoir avoir internet et povoir être sur le même réseau.
  * #### 3.2 IP statiques et autorisation port 22
  * ##### 3.2.1 Ubuntu
  ##### 


  * ##### 3.2.2 Debian
  * ##### 3.2.3 Windows 10
  * ##### 3.2.4 Windows 2022


  * #### 3.3 Ping
  * #### 3.4 SSH
     * #### 3.4.1 Instalation
     * #### 3.4.2 Clé SSH + Test
* #### 4 FAQ 
   

