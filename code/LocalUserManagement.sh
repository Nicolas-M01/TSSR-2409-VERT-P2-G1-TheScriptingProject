#!/bin/bash

# Définir les couleurs dans les variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # Aucune couleur

UserAccount=0
UserAccountName=""

# Menu intéractif Action Utilisateur Compte utilisateur


echo -e "\n${YELLOW}Quelle action utilisateur souhaitez vous réaliser ?\nRentrez le chiffre correspondant :${NC}\n"
echo -e "[1] ${YELLOW}Créer un compte utilisateur local${NC}"
echo -e "[2] ${YELLOW}Changer de mot de passe${NC}"
echo -e "[3] ${YELLOW}Supprimer le compte utilisateur${NC}"
echo -e "[4] ${YELLOW}Désactiver le compte utilisateur${NC}"
read UserAccount

case $UserAccount in
    # Utilisateur souhaite créer un nouveau compte utilisateur
    1 )
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
        			exit 1
				fi
			# La commande renvoie 0, donc le compte existe
			else
				echo "Le compte existe déjà. Le programme va fermer"
				exit 0
			fi


        # Si Utilisateur ne souhaite pas créer le compte il est prévenu et le programme ferme
		elif [[ $choice = "no" || $choice = "NO" ]]
		then
			echo -e "Vous ne souhaitez pas créer le nouveau compte $UserAccountName.\nLe programme va fermer"
    		exit 0

		# Fermeture en cas d'erreur
        else
        	echo "Error. Exit 1"
        	exit 1
        fi ;;

	# Utilisateur souhaite changer son mot de passe
	2 )
		echo "Changement de mot de passe d'un compte utilisateur"
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
		echo "Suppression de compte utilisateur"
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
		echo "Désactivation de compte utilisateur"
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

















esac

