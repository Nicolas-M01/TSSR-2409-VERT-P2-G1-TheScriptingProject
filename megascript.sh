#!/bin/bash


# Définir les couleurs dans les variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PINK='\e[1;31m'
NC='\033[0m' # Aucune couleur
Continue="yes"
i=0
j=0


FORMATTED_DATE=$(date +'%Y%m%d') # Formatage de la date en YYYYMMDD
FORMATTED_TIME=$(date +'%T') # Formatage de l'heure en HH:MM:SS
choice=0
target="" # Cible pour les informations. Elle peut être un utilisateur ou un ordinateur



# Lancement du script, on envoie l'information dans le fichier log
echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-${GREEN}********StartScript********${NC}" >> /var/log/log_evt.log


function menu
{
    # Menu selection multiple


	echo -e "${PINK}   __      ___ _    _    ___         _       ___     _             _ ${NC}"
	echo -e "${PINK}   \ \    / (_) |__| |  / __|___  __| |___  / __| __| |_  ___  ___| |${NC}"
	echo -e "${PINK}    \ \/\/ /| | / _' | | (__/ _ \/ _``  / -_) \__ \/ _| ' \/ _ \/ _ \ |${NC}"
	echo -e "${PINK}     \_/\_/ |_|_\__,_|  \___\___/\__,_\___| |___/\__|_||_\___/\___/_|${NC}"
	echo -e "${PINK}                                                                    ${NC}"


	echo -e "Menu Principal : "
	echo -e "[1] ${YELLOW}Utilisateur${NC}"
	echo -e "[2] ${YELLOW}Ordinateur client${NC}"
	read MainMenu

	case $MainMenu in
		# Menu UTILISATEUR / Choix entre ACTION ou INFORMATION
		1)
			
			echo -e "\n${YELLOW}Quelle action utilisateur souhaitez vous réaliser ?\nRentrez le chiffre correspondant :${NC}\n"
			echo "PARTIE ACTION"
			echo -e "[1] ${YELLOW}Créer un compte utilisateur local${NC}"
			echo -e "[2] ${YELLOW}Changer de mot de passe${NC}"
			echo -e "[3] ${YELLOW}Supprimer le compte utilisateur${NC}"
			echo -e "[4] ${YELLOW}Désactiver le compte utilisateur${NC}"
			echo -e "[5] ${YELLOW}Ajouter un utilisateur à un groupe d'administration${NC}"
			echo -e "[6] ${YELLOW}Ajouter un utilisateur à un groupe local${NC}"
			echo -e "[7] ${YELLOW}Retirer un utilisateur d'un groupe local${NC}"

			echo "PARTIE INFORMATION"
			echo -e "[8] ${YELLOW}Date de dernière connexion de l'utilisateur${NC}"
			echo -e "[9] ${YELLOW}Date de dernière modification du mot de passe${NC}"
			echo -e "[10] ${YELLOW}Liste des sessions ouvertes par l'utilisateur${NC}"
			echo -e "[11] ${YELLOW}Groupe d'appartenance d'un utilisateur${NC}"
			echo -e "[12] ${YELLOW}Historique des commandes exécutées par l'utilisateur${NC}"
			echo -e "[13] ${YELLOW}Droits/permissions de l’utilisateur sur un dossier${NC}"
			echo -e "[14] ${YELLOW}Droits/permissions de l’utilisateur sur un fichier${NC}"
			read -a choice

			for i in "${choice[@]}"
    		do
						case $i in
							
							# Utilisateur souhaite créer un nouveau compte utilisateur
							1 )
								echo -e "[1] ${YELLOW}Créer un compte utilisateur local${NC}"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[1] Créer un compte utilisateur local" >> /var/log/log_evt.log

								
								echo "Nous allons créer un compte utilisateur"
								echo "Comment souhaitez vous nommer ce nouveau compte utilisateur ?"
								read UserAccountName # Nom du nouveau compte utilisateur
								
								# On demande à l'utilisateur si il veut conserver ce nom de compte
								echo -e "Souhaitez vous conserver ${YELLOW}$UserAccountName${NC} comme nouveau compte ?"
								echo -e "Tappez ${GREEN}[yes]${NC} pour valider, ou ${RED}[no]${NC} pour annuler"
								read choice
								
								# Si utilisateur valide, le compte est créé.
								if [[ $choice = "yes" || $choice = "YES" ]]
								then

									# On vérifie que le compte utilisateur existe
									cat /etc/passwd	| grep -q "^$UserAccountName:"
									# Si il n'existe pas, la condition suivante devrait avoir 1 en entrée et donc on peut le créer
									if [ $? -ne 0 ]
									then
										sudo useradd $UserAccountName 
										sudo passwd $UserAccountName
										# Si la création du nouveau compte a fonctionné on prévient l'utilisateur
										if [ $? -eq 0 ]
										then
											echo -e "Le compte ${YELLOW}$UserAccountName${NC} a bien été créé"
										# Sinon il n'a pas été créé. On averti et on sort du programme
										else
											echo "Error. Exit 1"
										
										fi
									# La commande renvoie 0, donc le compte existe
									else
										echo "Le compte existe déjà"
										
									fi


								# Si Utilisateur ne souhaite pas créer le compte il est prévenu et le programme ferme
								elif [[ $choice = "no" || $choice = "NO" ]]
								then
									echo -e "Vous ne souhaitez pas créer le nouveau compte $UserAccountName.\nLe programme va fermer"
								

								# Fermeture en cas d'erreur
								else
									echo "Error. Exit 1"
								
								fi ;;

							# Utilisateur souhaite changer son mot de passe
							2 )
								echo "[2] Changement de mot de passe d'un compte utilisateur"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[2] Changement de mot de passe d'un compte utilisateur" >> /var/log/log_evt.log


								read -p "Vous souhaitez changer le mot de passe de quel compte utilisateur ? " UserAccountName
								# Confirmation de changer le mot de passe
								echo -e "Etes-vous sûr de vouloir changer le mot de passe de : ${YELLOW}$UserAccountName ?${NC}"
								echo -e "Tappez ${GREEN}[yes]${NC} pour valider, ou ${GREEN}[no]${NC} pour annuler"
								read choice

								# Si l'utilisateur valide
								if [[ $choice = "yes" || $choice = "YES" ]]
								then
									# On vérifie que l'utilisateur existe
									cat /etc/passwd	| grep -q "^$UserAccountName:"
									# Si il existe, la condition suivante devrait avoir 0 en entrée et donc on peut modifier le mot de passe
									if [ $? -eq 0 ]
									then
									# On execute la commande du changement de mot de passe
									sudo passwd $UserAccountName
									echo -e "Le mot de passe de ${YELLOW}$UserAccountName${NC} a bien été modifié"
									# Si le nom n'existe pas, utilisateur est averti et le programme ferme
									else
									echo "L'utilisateur n'existe pas. Le programme va fermer"
									exit 1
									fi

								# Si Utilisateur ne souhaite pas modifier le mot de passe il est prévenu et le programme ferme
								elif [[ $choice = "no" || $choice = "NO" ]]
								then
									echo -e "Vous ne souhaitez pas modifier le mot de passe du compte $UserAccountName.\nLe programme va fermer"
									exit 0

								# Si bug, il est prévenu et le programme ferme
								else
									echo "Error. Exit 1"
									exit 1
								fi ;;


								
							
							# Utilisateur souhaite supprimer compte utilisateur
							3 )
								echo "[3] Suppression de compte utilisateur"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[3] Suppression de compte utilisateur" >> /var/log/log_evt.log


								# On rentre le nom du compte à supprimer
								read -p "Quel compte souhaitez vous supprimer ? " UserAccountName
								echo -e "Etes-vous sûr de vouloir supprimer ${YELLOW}$UserAccountName${NC} ?"
								echo -e "Tappez ${GREEN}[yes]${NC} pour valider, ou ${RED}[no]${NC} pour annuler"
								read choice

								# Si l'utilisateur valide
								if [[ $choice = "yes" || $choice = "YES" ]]
								then
									# On vérifie que le compte utilisateur existe
									cat /etc/passwd	| grep -q "^$UserAccountName:"
									# Si il existe, la condition suivante devrait avoir 0 en entrée et donc on peut le supprimer
									if [ $? -eq 0 ]
									then
										# Suppression du compte utilisateur			
										sudo deluser $UserAccountName
										# On vérifie que la suppression a bien marché
										if [ $? -eq 0 ]
										then
											echo -e "Le compte ${YELLOW}$UserAccountName${NC} a bien été supprimé"
										# Sinon il n'a pas été supprimé. On averti et on sort du programme
										else
											echo "Error. Exit 1"
											exit 1
										fi
									# La commande renvoie 1, donc le compte n'existe pas
									else
										echo "Le compte n'existe pas. Le programme va fermer"
										exit 0
									fi

								# Si Utilisateur ne souhaite pas créer le compte il est prévenu et le programme ferme
								elif [[ $choice = "no" || $choice = "NO" ]]
								then
									echo -e "Vous ne souhaitez pas supprimer le compte ${YELLOW}$UserAccountName${NC}.\nLe programme va fermer"
									exit 0

									# Fermeture en cas d'erreur
								else
									echo "Error. Exit 1"
									exit 1
								fi ;;

							# Utilisateur souhaite désactiver un compte utilisateur
							4 )
								echo "[4] Désactivation de compte utilisateur"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[4] Désactivation de compte utilisateur" >> /var/log/log_evt.log


								# On rentre le nom de compte à désactiver
								read -p "Quel est le nom de compte que vous souhaitez désactiver ? " UserAccountName
								echo -e "Etes-vous sûr de vouloir désactiver le compte ${YELLOW}$UserAccountName${NC} ?"
								echo -e "Tappez ${GREEN}[yes]${NC} pour valider, ou ${RED}[no]${NC} pour annuler"		
								read choice

								# Si l'utilisateur valide
								if [[ $choice = "yes" || $choice = "YES" ]]
								then
									# On vérifie que le compte utilisateur existe
									cat /etc/passwd	| grep -q "^$UserAccountName:"
									# Si il existe, la condition suivante devrait avoir 0 en entrée et donc on peut le désactiver
									if [ $? -eq 0 ]
									then
										# Désactivation du compte utilisateur. L'option -L le désactive. Option -U pour déverouiller			
										sudo usermod -L $UserAccountName
										# On vérifie que la désactivation a bien marché
										if [ $? -eq 0 ]
										then
											echo "Le compte $UserAccountName a bien été désactivé"
										# Sinon il n'a pas été désactivé. On averti et on sort du programme
										else
											echo "Error. Exit 1"
											exit 1
										fi
									# La commande renvoie 1, donc le compte n'existe pas
									else
										echo "Le compte n'existe pas. Le programme va fermer"
										exit 0
									fi

									# Si Utilisateur ne souhaite pas créer le compte il est prévenu et le programme ferme
								elif [[ $choice = "no" || $choice = "NO" ]]
								then
									echo -e "Vous ne souhaitez pas désactiver le compte ${YELLOW}$UserAccountName${NC}.\nLe programme va fermer"
									exit 0

									# Fermeture en cas d'erreur
								else
									echo "Error. Exit 1"
									exit 1
								fi ;;

							5)
								echo -e "[5] ${YELLOW}Ajouter un utilisateur à un groupe d'administration${NC}"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[5] Ajouter un utilisateur à un groupe d'administration" >> /var/log/log_evt.log


								# Fonction qui va mettre dans une liste les noms d'utilisateurs
								function list() {
									ls /home
								}

								echo "Liste des utilisateurs : "
								list
								read -p "Sur quel utilisateur voulez-vous agir ? " user

								if ! list | grep -qw "$user"; then
									echo "L'utilisateur '$user' n'existe pas."
									exit 0
								else
									read -p "Souhaitez-vous ajouter $user au groupe d'administration ? (y/n) " choix

								
									case $choix in
										y)
											sudo usermod -aG sudo "$user"
											echo "$user ajouté au groupe d'administration avec succès."
											;;
								
										n)
											echo "Fin du script"
											exit 0
											;;
									esac
								fi
								;;

							6) 
								echo -e "[6] ${YELLOW}Ajouter un utilisateur à un groupe local${NC}"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[6] Ajouter un utilisateur à un groupe local" >> /var/log/log_evt.log

								# Fonction qui va mettre dans une liste les noms d'utilisateurs
								function list() {
									ls /home
								}

								echo "Liste des utilisateurs : "
								list
								read -p "Sur quel utilisateur voulez-vous agir ? " user

								if ! list | grep -qw "$user";
								then
									echo "L'utilisateur '$user' n'existe pas."
									exit 0
								else
									echo "A quel groupe local voulez-vous ajouter $user ? "

									# Fonction qui va mettre dans une liste les noms des groupes d'utilisateur
									function groupList() {
									cut -d: -f1 /etc/group | sort | column
									}
													
									echo "Liste des groupes :"
									groupList
									read -p "À quel groupe voulez-vous ajouter $user : " group
									if ! groupList | grep -qw "$group";
									then
										echo "Le groupe '$group' n'existe pas."
									else
										sudo usermod -aG "$group" "$user"
										echo "$user ajouté au groupe $group avec succès."
									fi
								fi
								;;

							7)
								echo -e "[7] ${YELLOW}Retirer un utilisateur d'un groupe local${NC}"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[7] Retirer un utilisateur d'un groupe local" >> /var/log/log_evt.log

								
								# Fonction qui va mettre dans une liste les noms d'utilisateurs
								function list() {
									ls /home
								}

								echo "Liste des utilisateurs : "
								list
								read -p "Sur quel utilisateur voulez-vous agir ? " user

								if ! list | grep -qw "$user";
								then
									echo "L'utilisateur '$user' n'existe pas."
									exit 0
								else
									echo "Liste de(s) groupe(s) de $user : "

									# Fonction qui va mettre dans une liste les noms des groupes de l'utilisateur sélectionné
									function groupList() {
									groups "$user"
									}				

									groupList
									read -p "Quel groupe voulez-vous retirer à $user : " group
									if ! groupList | grep -qw "$group";
									then
										echo "Le groupe '$group' n'existe pas."
									else
										sudo gpasswd -d "$user" "$group"
										echo "$user retiré du groupe $group avec succès."
									fi
								fi
								;;
						
							8) 
								echo -e "\n[8] Date de dernière connexion de l'utilisateur "
								echo "Pour quel utilisateur voudriez vous connaître la dernière connexion ? "
								read target

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[8] Date de dernière connexion de l'utilisateur" >> /var/log/log_evt.log


								# On vérifie que la cible existe bien
								cat /etc/passwd | grep -q "^$target:"
								# Si elle existe on execute le script  

								
								if [ $? -eq 0 ]
								then                
									# On compte le nombre d'éléments dans le tableau
									# Si il n'y en a qu'un on l'affiche
									if [ ${#choice[@]} -eq 1 ]
									then
									# On affiche le résultat de la commande à l'écran.
									# Les backticks servent à executer la commande, pendant que les "" l'affichent.
									echo -e "\n* Date de dernière connexion de $target :\n`last $target`"
									fi
								# On copie dans le fichier info
								echo -e "\n* Date de dernière connexion de l'utilisateur $target\n`last $target`" >> ~/Documents/"info_"$target"_"$FORMATTED_DATE".txt"


								# Si elle n'existe pas on avertit et on quitte le programme
								else
									echo "La cible n'existe pas le programme va s'arrêter"
									exit 1
								fi
								;;
							
							9)
								echo -e "\n[9] Date de dernière modification du mot de passe"
								echo "Pour quel utilisateur voudriez vous connaître la date de dernière modification de mot de passe ? "
								read target

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[9] Date de dernière modification du mot de passe" >> /var/log/log_evt.log

								# On vérifie que la cible existe bien
								cat /etc/passwd | grep -q "^$target:"
								# Si elle existe on execute le script
								if [ $? -eq 0 ]
								then  
									
									# On rentre la date de dernière modification du MDP que l'on retravaille avec grep pour n'avoir que la date format MM/DD/YYYY
									PassWordDate=$(sudo passwd -S $target | grep -o "[0-9]*/[0-9]*/[0-9]*")

									# On compte le nombre d'éléments dans le tableau
									# Si il n'y en a qu'un on l'affiche
									if [ ${#choice[@]} -eq 1 ]
									then
									# On affiche le résultat de la commande à l'écran.
									echo -e "\n* La date de dernière modification du mot de passe de $target était le $PassWordDate\n"
									fi
									echo -e "\n* La date de dernière modification du mot de passe de $target était le $PassWordDate\n" >> ~/Documents/"info_"$target"_"$FORMATTED_DATE".txt"


								# Si la cible n'existe pas, on prévient et on ferme
								else
									echo "La cible n'existe pas, le programme va s'arrêter"
									exit 1
												
								fi
								;;

							10)
								echo -e "\n[10] Liste des sessions ouvertes par l'utilisateur"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[10] Liste des sessions ouvertes par l'utilisateur" >> /var/log/log_evt.log
								target=$(whoami)
									# On compte le nombre d'éléments dans le tableau
									# Si il n'y en a qu'un on l'affiche
									if [ ${#choice[@]} -eq 1 ]
									then
									# Affichage commande "w"
									echo -e "\n* Liste des sessions ouvertes par $target :\n`w`"
									fi
								# Si plusieurs choix dans le tableau, on enregistre directement
								
								echo -e "\n* Liste des sessions ouvertes par l'utilisateur $target :\n`w`" >> ~/Documents/"info_"$target"_"$FORMATTED_DATE".txt"
								;;

							11)
								echo -e "\n[11] Groupe d'appartenance d'un utilisateur"
								echo "Pour quel utilisateur voudriez vous connaître le groupe ? "
								read target

								# On copie dans le log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[11] Groupe d'appartenance d'un utilisateur" >> /var/log/log_evt.log

								# On vérifie que la cible existe bien
								cat /etc/passwd | grep -q "^$target:"
								# Si elle existe on execute le script  

								if [ $? -eq 0 ]
								then                
									
									# On compte le nombre d'éléments dans le tableau
									# Si il n'y en a qu'un on l'affiche
									if [ ${#choice[@]} -eq 1 ]
									then
									# On affiche le résultat de la commande à l'écran.
									# Les backticks servent à executer la commande, pendant que les "" l'affichent.
									echo -e "\n${YELLOW}* Voici les groupes d'appartenance de${NC} `groups $target`\n" 
									fi
								# On copie dans fichier info    
								echo -e "\n${YELLOW}* [11] Voici les groupes d'appartenance de${NC} `groups $target`\n" >> ~/Documents/"info_"$target"_"$FORMATTED_DATE".txt"
								# Si elle n'existe pas on avertit et on quitte le programme
								else
									echo -e "${RED}La cible n'existe pas le programme va s'arrêter${NC}"
									exit 1
								fi
								;;

							12)
								echo -e "\n[12] Historique des commandes exécutées par l'utilisateur"

								# On copie dans le log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[12] Historique des commandes exécutées par l'utilisateur" >> /var/log/log_evt.log

								# On redéfinit la cible pour pouvoir l'afficher dans le résultat avec plus de clarté
								target=$(whoami)

								# On compte le nombre d'éléments dans le tableau
								# Si il n'y en a qu'un on l'affiche
									if [ ${#choice[@]} -eq 1 ]
									then
									# On affiche les 10 dernières commandes de l'utilisateur courant
									HISTFILE=~/.bash_history
									set -o history
									echo -e "\n${YELLOW}* Historique des 10 dernières commandes exécutées par $target :${NC}\n`history 10`"
									
									fi
								# On copie dans fichier info
								echo -e "\n${YELLOW}* [12] Historique des 10 dernières commandes exécutées par l'utilisateur $target :${NC}\n`history 10`" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"
								;;

							13)
								echo -e "\n[13] Droits/permissions de l’utilisateur sur un dossier"
								echo "Pour quel dossier voudriez vous connaître les droits ? "
								read directory
								echo "Indiquez le chemin du dossier que vous recherchez :"
								read path

								# On copie dans le log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[13] Droits/permissions de l’utilisateur sur un dossier" >> /var/log/log_evt.log

									# On execute la commande find pour les dossiers et on renvoie avec un -ls.
									# On stock dans une variable et on envoie le résultat en sauvegarde.
									DirectoryRight=$(find $path -type d -name "$directory" -ls)
									
									# Si il trouve le dossier ou si le dossier n'existe pas il renvoie 0 mais la commande fonctionne
									if [ $? -eq 0 ]
									then
									# On envoie le résultat dans le fichier
									echo -e "\n${YELLOW}* [13] Voici les droits de `whoami` pour le dossier $directory :\n${NC} $DirectoryRight" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"

									# Si un seul choix dans le menu, on affiche le résultat
										if [ ${#choice[@]} -eq 1 ]
										then
										echo -e "\n${YELLOW}* Droits/permissions de `whoami` pour le dossier $directory :\n${NC} $DirectoryRight"
											if [ -z "$DirectoryRight" ]
											then
											echo -e "${RED}Il n'y a pas de dossier de ce nom${NC}"
											fi
										fi

										# On vérifie si la commande n'a rien renvoyé et on informe qu'il n'y a rien (pour éviter un espace vide)
										# On affiche en console et on enregistre dans le fichier.
										if [ -z "$DirectoryRight" ]
										then
										echo -e "${RED}Il n'y a pas de dossier de ce nom${NC}" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"
										fi    

									else
										# Si le chemin n'existe pas le programme fermer
										echo -e "${RED}Erreur le programme va fermer${NC}"
									fi
									;;
							14)

								echo -e "\n[14] Droits/permissions de l’utilisateur sur un fichier"
								echo "Pour quel fichier voudriez vous connaître les droits ? "
								read file
								echo "Indiquez le chemin du fichier que vous recherchez :"
								read path

								# On copie dans le log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[14] Droits/permissions de l’utilisateur sur un fichier" >> /var/log/log_evt.log


									# On execute la commande find pour les fichiers et on renvoie avec un -ls.
									# On stock dans une variable et on envoie le résultat en sauvegarde dans "Fileright"
									FileRight=$(find $path -type f -name "$file" -ls)


									# Si il trouve le fichier ou si le fichier n'existe pas il renvoie 0 mais la commande fonctionne
									if [ $? -eq 0 ]
									then
									# On envoie le résultat dans le fichier
									echo -e "\n${YELLOW}* [14] Droits/permissions de `whoami` pour le fichier $file :\n${NC} $FileRight" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"
									
										# Si un seul choix dans le menu on affiche le résultat
										if [ ${#choice[@]} -eq 1 ]
										then
										echo -e "\n${YELLOW}* Voici les droits de `whoami` pour le fichier $file :\n${NC} $FileRight" 
											if [ -z "$FileRight" ]
											then
											echo "Il n'y a pas de fichier de ce nom"
											fi
										
										fi

										# On vérifie si la commande n'a rien renvoyé et on informe qu'il n'y a rien (pour éviter un espace vide)
										# On affiche en console et on enregistre dans le fichier.
										if [ -z "$FileRight" ]
										then
										echo "Il n'y a pas de fichier de ce nom" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"
										fi    
									
									else
										# Si le chemin n'existe pas le programme fermer
										echo -e "${RED}Erreur le programme va fermer${NC}"
										exit 1
									fi
									;;
					
						esac

			done
		;;
					
				
		# Menu ORDINATEUR CLIENT / Choix entre ACTION ou INFORMATION
		2)
					echo "Menu principal : "
					echo -e "\n${YELLOW}Quelle action utilisateur souhaitez vous réaliser ?\nRentrez le chiffre correspondant :${NC}\n"
					echo "PARTIE ACTION"
					echo -e "[1] ${YELLOW}Marche/Arret${NC}"
					echo -e "[2] ${YELLOW}Mise à jour${NC}"
					echo -e "[3] ${YELLOW}Gestion des répertoires${NC}"
					echo -e "[4] ${YELLOW}Gestion Pare-feu${NC}"
					echo -e "[5] ${YELLOW}Gestion logiciel${NC}"
					
					echo "PARTIE INFORMATION"
					echo -e "[6] ${YELLOW}Version de l'OS${NC}"
					echo -e "[7] ${YELLOW}Nombre de disques${NC}"
					echo -e "[8] ${YELLOW}Partition par disque${NC}"
					echo -e "[9] ${YELLOW}Espace disque restant${NC}"
					echo -e "[10] ${YELLOW}Nom et espace disque d'un dossier${NC}"
					echo -e "[11] ${YELLOW}Liste des lecteurs montés${NC}"
					echo -e "[12] ${YELLOW}Liste des applications/paquets installés${NC}"
					echo -e "[13] ${YELLOW}Liste des services en cours d'execution${NC}"
					echo -e "[14] ${YELLOW}Liste des utilisateurs locaux${NC}"
					echo -e "[15] ${YELLOW}Mémoire RAM totale${NC}"
					echo -e "[16] ${YELLOW}Utilisation de la RAM${NC}"
					read -a choice

	
				for j in "${choice[@]}"
				do
					case $j in
							1)
								echo -e "[1] ${YELLOW}Marche/Arret${NC}"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[2] Gestion des repertoires" >> /var/log/log_evt.log

								while true
								do
									echo "Menu Marche/Arret:"
									echo "[1] Arrêter"
									echo "[2] Redémarer"
									echo "[3] Verrouiller"
									read choix

									case $choix in
										1)
												echo "Arrêt en cours..."
												sudo -S shutdown now
												;;
										2)
												echo "Redémarrage en cours..."
												reboot
												;;
										3)
												echo "Verrouillage de la session en cours..."
												sleep 3
												xdg-screensaver lock
												;;
										*)
												echo "Choix invalide. Veuillez entre 1, 2, ou 3"
												;;
									esac
									
								done
								;;

							2)
								echo -e "[2] ${YELLOW}Mise à jour${NC}"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[2] Gestion des repertoires" >> /var/log/log_evt.log

								while true;
								do
									clear
									echo "Menu Mise à jour :"
									echo "[1] Mettre à le système"
									echo "[2] Quitter"
									read choix

									case $choix in
											1)
													echo "Mise à jour du système en cours"
													sudo -S apt-get update -y
													sudo -S apt-get upgrade -y
													sudo -S apt-get autoremove -y
													sudo -S apt-get clean -y
													echo "Mise à jour effectuée avec succès."
													;;

											2)
													echo "Fin du script"
													exit 0
													;;

											*)		
													echo "Choix invalide. Veuillez entre 1 ou 2"
													;;
									esac
									
								done
								;;
							
							3)
								echo -e "[3] ${YELLOW}Gestion des répertoires${NC}"
								
								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[3] Gestion des repertoires" >> /var/log/log_evt.log


								while true;
								do
									clear
									echo "Menu Gestion des répertoires :"
									echo "[1] Créer un répertoire"
									echo "[2] Modifier un répertoire"
									echo "[3] Supprimer un répertoire"
									echo "[4] Quitter"
									read choix

									case $choix in
											1)
													echo -n "Entrez le nom du répertoire à créer : "
													read folder
													if [ -d "$folder" ];
													then
														echo "Le répertoire '$folder' existe deja"
													else
														mkdir "$folder"
														echo "Répertoire '$folder' créé avec succès."
													fi

													break
													;;

											2)
													echo "Liste des répertoires :"
													ls -d */
													echo -n "Entrez le nom du répertoire à renommer : "
													read folderName
													if [ ! -d "$folderName" ]
													then
														echo "Le répertoire '$folderName' n'existe pas."
													else
														echo -n "Entrez le nouveau nom du répertoire : "
														read newFolder
														mv "$folderName" "$newFolder"
														echo "Répertoire renommé en '$newFolder' avec succès."
													fi

													break
													;;
												
											3)
													echo "Liste des répertoires :"
													ls -d */
													echo -n "Entrez le nom du répertoire à supprimer : "
													read folderName
													if [ ! -d "$folderName" ]
													then
														echo "Le répertoire '$folderName' n'existe pas."
													else
														rm -r "$folderName"
														echo "Répertoire '$folderName' a été supprimé avec succes."
													fi

													break
													;;

											4)
													echo "Fin du script"
													exit 0
											;;

											*)		
													echo "Choix invalide. Veuillez entre 1, 2, ou 3"
													;;
									esac

								done
								;;

							4)
								echo -e "[4] ${YELLOW}Gestion Pare-feu${NC}"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[4] Gestion Parefeu" >> /var/log/log_evt.log
								
								echo -e "${YELLOW}**MENU**\n\n${NC}"
								echo -e "${GREEN}[1] Activer le pare feu\n${NC}"     
								echo -e "${GREEN}[2] Autoriser une adresse IP\n${NC}"    
								echo -e "${RED}[3] Bloquer une adresse IP\n${NC}"   
								echo -e "${BLUE}[4] Voir le Statut\n${NC}"    
								echo -e "[5] Sortie\n"
								echo -e "${YELLOW}Choisissez une option : ${NC}"
									
								read choix2

								case $choix2 in
									
									1)                                 
										sudo ufw enable
										;;
										
									2) 
										read -p "Quelle adresse voulez vous autoriser?" reponse1
										sudo ufw deny from $reponse1   
										;;
									3)
										read -p "Quelle adresse IP voulez vous bloquer?" reponse2
										sudo ufw allow from $reponse2
										;;
									4)                  
											
										sudo ufw status numbered
										;;
									5)
										exit
										;;
												
									*)
									echo -e "${RED}L'option est invalide, veuillez rentrer une option valide, merci. :${NC}"
									;;
								esac
								;;
							
							5)
								echo -e "[5] Gestion logiciel\n\n"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[5] Gestion logiciel" >> /var/log/log_evt.log
						
								echo -e "${GREEN}[1] Instaler un logiciel\n${NC}"
								echo -e "${RED}[2] Désintaler un Logiciel\n${NC}"

								read choix3

								case $choix3 in 

									1) 
										xdg-open https://fr.wikipedia.org/wiki/Cat%C3%A9gorie:Logiciel_pour_Linux 2>/dev/null
										read -p "Quel logiciel voulez-vous installer ? " logiciel1

										if [ ! -d "./$logiciel1" ]; then
											echo -e "Installation du logiciel $logiciel1"
											sudo apt install "$logiciel1"

				
											if [ $? -ne 0 ]; then
												echo -e "L'installation a échoué."
											else
												echo -e "L'installation est un succès."
											fi
										else
											echo -e "Le logiciel $logiciel1 est déjà installé ou n'est pas un dossier."
										fi
										;;                    
								
									2)
										gnome-terminal -- dpkg --list

										read -p "Quel logiciel voulez vous désinstaller?" logiciel2

										read -p "Etes vous sur de vouloir désinstaller $logiciel2 Y\N" reponse3

											if [[ $reponse3 == Y ]] || [[ $reponse3 == y ]];then

											sudo apt remove $logiciel2
												if [ $? = 0 ];then
												echo -e "le logiciel $logiciel2 à été désinstallé."
												fi
											elif [[ $reponse3 == N ]] || [[ $reponse3 == n ]];then

												echo -e "le logiciel $logiciel2, n'a pas été désinstallé"
												exit
											fi
											;;
								esac
								;;
	
					
							
							6)
								echo -e "\n[6] Version de l'OS"
								if [ ${#choice[@]} -eq 1 ]
								then
									# On affiche le résultat de la commande à l'écran.
									echo -e "\nLa version de cet OS est : $(cat /etc/os-release | grep -v "NAME" | grep -v "PRETTY_NAME" | grep -v "ID" | grep -v "ID_LIKE" | grep -v "HOME_URL" | grep -v "SUPPORT_URL" | grep -v "BUG_REPORT_URL" | grep -v "PRIVACY_POLICY_URL" | grep -v "UBUNTU_CODENAME")"
								fi
									# On enregistre dans fichier info
									echo -e "\n* [6] La version de cet OS est : $(cat /etc/os-release | grep -v "NAME" | grep -v "PRETTY_NAME" | grep -v "ID" | grep -v "ID_LIKE" | grep -v "HOME_URL" | grep -v "SUPPORT_URL" | grep -v "BUG_REPORT_URL" | grep -v "PRIVACY_POLICY_URL" | grep -v "UBUNTU_CODENAME")" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
									# On copie dans fichier log
									echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[6] Version de l'OS" >> /var/log/log_evt.log
									;;  

							7)
								echo -e "\n[7] Nombre de disques"
								# On copie dans fichier log
								echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[7] Nombre de disques" >> /var/log/log_evt.log
							
								# Liste uniquement les disques
								echo -e "\n* [7] Nombre de disques :\n`lsblk | grep -v "loop" | grep -v "sr0"`" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
								# Nombre de disques
								disk_count=$(lsblk -d -o NAME | grep -vE "loop|sr0" | wc -l)

								# Structure if pour ajouter ou enlever un "s" en fonction du nombre de disques
								if [ $disk_count -gt 1 ]; then
									echo "Nombre de disques de `whoami` : $disk_count" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
								else
									echo "Nombre de disque de `whoami` : $disk_count" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
								fi
								
								# Affichage si un seul choix
								if [ ${#choice[@]} -eq 1 ]
								then
									lsblk | grep -v "loop" | grep -v "sr0"  # Liste uniquement les disques
									disk_count=$(lsblk -d -o NAME | grep -vE "loop|sr0" | wc -l)  # Nombre de disques
										if [ $disk_count -gt 1 ]; then
											echo "Nombre de disques de `whoami` : $disk_count"
										else
											echo "Nombre de disque de `whoami` : $disk_count"
										fi
								fi
								;;
							
							8)
								echo -e "\n[8] Partition par disque"
								# On copie dans fichier log
								echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[8] Partition par disque" >> /var/log/log_evt.log

								# On copie dans fichier info
								echo -e "\n* [8] Partition par disque :\n $resultat1=$(df -h | grep -v "tmpfs" | grep -v " /dev/sr0")" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
								
								if [ ${#choice[@]} -eq 1 ]
									then
									echo -e "Voici les partitions sur cette machine :\n $resultat1=$(df -h | grep -v "tmpfs" | grep -v " /dev/sr0")" 
								fi
								;;
							
							9)
								echo -e "\n[9] Espace disque restant"
								# On copie dans fichier log
								echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[9] Espace disque restant" >> /var/log/log_evt.log
								
								# Enregistrement dans fichir info
								echo -e "\n* [9] Voici la place disponible sur chaque partition :\n $resultat2=$(df -h | grep -v "tmpfs" | grep -v "/dev/sr0" | awk 'BEGIN {OFS="       "} {print $1,$2, $3, $4}')" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"


								if [ ${#choice[@]} -eq 1 ]
								then
									echo -e "Voici la place disponible sur chaque partition :\n $resultat2=$(df -h | grep -v "tmpfs" | grep -v "/dev/sr0" | awk 'BEGIN {OFS="       "} {print $1,$2, $3, $4}')"
								fi                               
								;;

							10)
								echo -e "\n[10] Nom et espace disque d'un dossier"
								# On copie dans fichier log
								echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[10] Nom et espace disque d'un dossier" >> /var/log/log_evt.log

								echo "Sur quel dossier souhaitez-vous des indications ?" 
								read directory

								echo "Veuillez renseigner un chemin :" 
								read path


								# Vérifier si le chemin existe et est un répertoire
								if [ -d "$path" ]; then
									# Chercher le répertoire spécifié dans le chemin
									Total=$(find "$path" -type d -name "$directory")
									if [ -n "$Total" ]; then
										if [ ${#choice[@]} -eq 1 ]
										then
											echo -e "La taille du répertoire $directory est :\n $resultat3=$(sudo du -sh "$Total")"
										fi

									echo -e "\n* [10] Nom et espace disque d'un dossier\nLa taille du répertoire $directory est :\n $resultat3=$(sudo du -sh "$Total")" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"

									else
									echo "Le répertoire '$directory' n'a pas été trouvé dans le chemin spécifié." 
									fi
								else
									echo "Le chemin spécifié '$path' n'est pas un répertoire valide." 
								fi
								;;

							11)
								echo -e "\n[11] Liste des lecteurs montés"
								# On copie dans fichier log
								echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[11] Liste des lecteurs montés" >> /var/log/log_evt.log
								
								# On lance les commandes et on les rentre dans une variable
								resultat4=$(lsblk | grep -v "loop")
								
								#Si un seul choix, on affiche le résultat à l'écran
								if [ ${#choice[@]} -eq 1 ]
									then
									echo -e "Liste des lecteurs montés :\n$resultat4" 
								fi

								# On enregistre dans le fichier info
								echo -e "\n* [11] Liste des lecteurs montés :\n$resultat4" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
								;;

							12)
								echo -e "\n[12] Liste des applications paquets/installés"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[12] Liste des applications/paquets installées" >> /var/log/log_evt.log

								# Fonction qui va mettre dans une liste les applications/paquets installées
								function list() {
								apt list --installed
								}

								
								if [ $? -eq 0 ]
								then                
									# On compte le nombre d'éléments dans le tableau
									# Si il n'y en a qu'un on l'affiche
									if [ ${#choice[@]} -eq 1 ]
									then
									# On affiche le résultat de la commande à l'écran.
									echo -e "Voici les applications/paquets installées :"
									list
									fi
								echo -e "\n* [12] Voici les applications/paquets installés :\n `list`" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"

								fi
								;;

							13)
								echo -e "\n[13] Liste des services en cours d'execution"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[13] Liste des services en cours d'execution" >> /var/log/log_evt.log

								# Fonction qui va mettre dans une liste les services en cours d'execution
								function list() {
								systemctl --type=service --state=running --no-pager --quiet

								}

								
								if [ $? -eq 0 ]
								then                
									# On compte le nombre d'éléments dans le tableau
									# Si il n'y en a qu'un on l'affiche
									if [ ${#choice[@]} -eq 1 ]
									then
									# On affiche le résultat de la commande à l'écran.
									echo -e "Voici les services en cours d'execution :"
									list

									fi
									echo -e "\n* [13] Services en cours d'execution :\n `list`" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"
								fi
								;;

							14)
								echo -e "\n[14] Liste des utilisateurs locaux"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[14] Liste des utilisateurs locaux" >> /var/log/log_evt.log


								# Fonction qui va mettre dans une liste les services en cours d'execution
								function list() {
								cut -d: -f1 /etc/passwd
								}
							
								if [ $? -eq 0 ]
								then                
									# On compte le nombre d'éléments dans le tableau
									# Si il n'y en a qu'un on l'affiche
									if [ ${#choice[@]} -eq 1 ]
									then
									# On affiche le résultat de la commande à l'écran.
									echo "Voici la liste des utilisateur locaux :"
									list
														
									fi

								echo -e "\n* [14] Voici la liste des utilisateurs locaux :\n`list`" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"

								fi
								;;

							15)
								echo -e "\n[15] Mémoire RAM totale"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[15] Mémoire RAM totale" >> /var/log/log_evt.log
								
								# On enregistre dans le fichier information
								echo -e "\n* [15] Votre RAM totale est de $(free -h | grep "Mem:" | awk '{print$2}')" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"

								# Si un seul choix dans le menu
								if [ ${#choice[@]} -eq 1 ]
								then
									# Affichage de la RAM totale avec free et découpe avec awk et grep
									echo -e "Votre RAM totale est de $(free -h | grep "Mem:" | awk '{print$2}')"
								fi
								;;

							16)
								echo -e "\n[16] Utilisation de la RAM"

								# On copie dans fichier log
								echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-[16] Utilisation de la RAM" >> /var/log/log_evt.log

								# On enregistre dans le fichier information
								echo -e "\n* [16] Votre RAM utilisée est de $(free -h | grep "Mem:" | awk '{print$3}')" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"

								# Si un seul choix dans le menu
								if [ ${#choice[@]} -eq 1 ]
								then
									# Affichage de la RAM totale avec free et découpe avec awk et grep
									echo -e "Votre RAM utilisée est de $(free -h | grep "Mem:" | awk '{print$3}')"
								fi
								;;

							*)
								echo -e "${RED}Veuillez choisir une option dans la liste${NC}"
								;;
					esac
					
			
					# Si on tape une option hors liste
					# if [ $choice -ge 17 ]
					# then
					# echo -e "${RED}Veuillez choisir une option dans la liste${NC}"
					# fi
				done
				
		;;	
	esac

}


# Tant que l'utilisateur tape yes, le programme continue
while [[ $Continue = "yes" || $Continue = "YES" ]]
do
    menu
    echo -e "\n"
    echo -e "${GREEN}[yes]${NC} ${YELLOW}pour Continuer${NC}"
	echo -e "${RED}[no]${NC} ${YELLOW}pour Quitter${NC}"
    read Continue
done

echo -e "${PINK}
      _                         _       _ 
     /_\ _  _   _ _ _____ _____(_)_ _  | |
    / _ \ || | | '_/ -_) V / _ \ | '_| |_|
   /_/ \_\_,_| |_| \___|\_/\___/_|_|   (_)
${NC}"    

# On enregistre la fin du script dans le fichier log
echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-${RED}********EndScript********${NC}" >> /var/log/log_evt.log

