#!/bin/bash

# Définir les couleurs dans les variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # Aucune couleur
Continue="yes"

FORMATTED_DATE=$(date +'%Y%m%d') # Formatage de la date en YYYYMMDD
FORMATTED_TIME=$(date +'%T') # Formatage de l'heure en HH:MM:SS
choice=0
target="" # Cible pour les informations. Elle peut être un utilisateur ou un ordinateur


# Lancement du script, on envoie l'information dans le fichier log
echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-********StartScript********" >> /var/log/log_evt.log



menu()
{
    # Menu selection multiple
    echo -e "\n"
    echo -e "1) Date de dernière connexion de l'utilisateur"
    echo -e "2) Date de dernière modification du mot de passe"
    echo -e "3) Liste des sessions ouvertes par l'utilisateur"
    echo -e "4) Groupe d'appartenance d'un utilisateur"
    echo -e "5) Historique des commandes exécutées par l'utilisateur"
    echo -e "6) Droits/permissions de l’utilisateur sur un dossier"
    echo -e "7) Droits/permissions de l’utilisateur sur un fichier"
    echo -e "8) Version de l'OS"
    echo -e "9) Nombre de disques"
    echo -e "10) Partition par disque"
    echo -e "11) Espace disque restant"
    echo -e "12) Nom et espace disque d'un dossier"
    echo -e "13) Liste des lecteurs montés"
    echo -e "14) Liste des applications/paquets installés"
    echo -e "15) Liste des services en cours d'execution"
    echo -e "16) Liste des utilisateurs locaux"
    echo -e "17) Mémoire RAM totale"
    echo -e "18) Utilisation de la RAM"
    


    # Lecture à choix multiple
    echo -e "\nRentrez votre choix et tapez [Entrée]\nOu un choix multiple en espaçant chaque choix (Ex: [1 2 4 9]) et tapez [Entrée]\n"
    # L'utilisateur rentre toutes les informations qu'il a besoin dans le tableau "choice"
    read -a choice


    # boucle sur chaque choix utilisateur qui peuvent être multiples. 
    for i in "${choice[@]}"
    do
         
        case $i in
            # Date de dernière connexion de l'utilisateur
            1)
                echo -e "\n1) Date de dernière connexion de l'utilisateur "
                echo "Pour quel utilisateur voudriez vous connaître la dernière connexion ? "
                read target

                # On copie dans fichier log
                echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-1) Date de dernière connexion de l'utilisateur" >> /var/log/log_evt.log


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
                echo -e "\n* 1) Date de dernière connexion de l'utilisateur $target\n`last $target`" >> ~/Documents/"info_"$target"_"$FORMATTED_DATE".txt"


                # Si elle n'existe pas on avertit et on quitte le programme
                else
                    echo "La cible n'existe pas le programme va s'arrêter"
                    exit 1
                fi
                ;;
            
            # Date de dernière modification du mot de passe
            2)
                echo -e "\n2) Date de dernière modification du mot de passe"
                echo "Pour quel utilisateur voudriez vous connaître la date de dernière modification de mot de passe ? "
                read target

                # On copie dans fichier log
                echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-2) Date de dernière modification du mot de passe" >> /var/log/log_evt.log

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
                    echo -e "\n* 2) La date de dernière modification du mot de passe de $target était le $PassWordDate\n" >> ~/Documents/"info_"$target"_"$FORMATTED_DATE".txt"


                # Si la cible n'existe pas, on prévient et on ferme
                else
                    echo "La cible n'existe pas, le programme va s'arrêter"
                    exit 1
                                
                fi
                ;;

            # Liste des sessions ouvertes par l'utilisateur
            3)
                echo -e "\n3) Liste des sessions ouvertes par l'utilisateur"

                # On copie dans fichier log
                echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-3) Liste des sessions ouvertes par l'utilisateur" >> /var/log/log_evt.log
                target=$(whoami)
                    # On compte le nombre d'éléments dans le tableau
                    # Si il n'y en a qu'un on l'affiche
                    if [ ${#choice[@]} -eq 1 ]
                    then
                    # Affichage commande "w"
                    echo -e "\n* Liste des sessions ouvertes par $target :\n`w`"
                    fi
                # Si plusieurs choix dans le tableau, on enregistre directement
                
                echo -e "\n* 3) Liste des sessions ouvertes par l'utilisateur $target :\n`w`" >> ~/Documents/"info_"$target"_"$FORMATTED_DATE".txt"

                ;;

            # Groupe d'appartenance d'un utilisateur
            4)
                echo -e "\n4) Groupe d'appartenance d'un utilisateur"
                echo "Pour quel utilisateur voudriez vous connaître le groupe ? "
                read target

                # On copie dans le log
                echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-4) Groupe d'appartenance d'un utilisateur" >> /var/log/log_evt.log

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
                echo -e "\n${YELLOW}* 4) Voici les groupes d'appartenance de${NC} `groups $target`\n" >> ~/Documents/"info_"$target"_"$FORMATTED_DATE".txt"
                # Si elle n'existe pas on avertit et on quitte le programme
                else
                    echo -e "${RED}La cible n'existe pas le programme va s'arrêter${NC}"
                    exit 1
                fi
                ;;

            # Historique des commandes exécutées par l'utilisateur
            5)
                echo -e "5) Historique des commandes exécutées par l'utilisateur"

                # On copie dans le log
                echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-5) Historique des commandes exécutées par l'utilisateur" >> /var/log/log_evt.log

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
                echo -e "\n${YELLOW}* 5) Historique des 10 dernières commandes exécutées par l'utilisateur $target :${NC}\n`history 10`" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"
                
                
                ;;


            # Droits/permissions de l’utilisateur sur un dossier
            6)
                echo -e "\n6) Droits/permissions de l’utilisateur sur un dossier"
                echo "Pour quel dossier voudriez vous connaître les droits ? "
                read directory
                echo "Indiquez le chemin du dossier que vous recherchez :"
                read path

                # On copie dans le log
                echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-6) Droits/permissions de l’utilisateur sur un dossier" >> /var/log/log_evt.log

                    # On execute la commande find pour les dossiers et on renvoie avec un -ls.
                    # On stock dans une variable et on envoie le résultat en sauvegarde.
                    DirectoryRight=$(find $path -type d -name "$directory" -ls)
                    
                    # Si il trouve le dossier ou si le dossier n'existe pas il renvoie 0 mais la commande fonctionne
                    if [ $? -eq 0 ]
                    then
                    # On envoie le résultat dans le fichier
                    echo -e "\n${YELLOW}* 6) Voici les droits de `whoami` pour le dossier $directory :\n${NC} $DirectoryRight" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"

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

                        
            # Droits/permissions de l’utilisateur sur un fichier
            7)
                echo -e "\n7) Droits/permissions de l’utilisateur sur un fichier"
                echo "Pour quel fichier voudriez vous connaître les droits ? "
                read file
                echo "Indiquez le chemin du fichier que vous recherchez :"
                read path

                # On copie dans le log
                echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-7) Droits/permissions de l’utilisateur sur un fichier" >> /var/log/log_evt.log


                    # On execute la commande find pour les fichiers et on renvoie avec un -ls.
                    # On stock dans une variable et on envoie le résultat en sauvegarde dans "Fileright"
                    FileRight=$(find $path -type f -name "$file" -ls)


                    # Si il trouve le fichier ou si le fichier n'existe pas il renvoie 0 mais la commande fonctionne
                    if [ $? -eq 0 ]
                    then
                    # On envoie le résultat dans le fichier
                    echo -e "\n${YELLOW}* 7) Droits/permissions de `whoami` pour le fichier $file :\n${NC} $FileRight" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"
                       
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
            # Version de l'OS
            8)
                echo -e "\n8) Version de l'OS"
                if [ ${#choice[@]} -eq 1 ]
                    then
                    # On affiche le résultat de la commande à l'écran.
                    echo -e "\nLa version de cet OS est : $(cat /etc/os-release | grep -v "NAME" | grep -v "PRETTY_NAME" | grep -v "ID" | grep -v "ID_LIKE" | grep -v "HOME_URL" | grep -v "SUPPORT_URL" | grep -v "BUG_REPORT_URL" | grep -v "PRIVACY_POLICY_URL" | grep -v "UBUNTU_CODENAME")"
                    fi
                # On enregistre dans fichier info
                echo -e "\n* 8) La version de cet OS est : $(cat /etc/os-release | grep -v "NAME" | grep -v "PRETTY_NAME" | grep -v "ID" | grep -v "ID_LIKE" | grep -v "HOME_URL" | grep -v "SUPPORT_URL" | grep -v "BUG_REPORT_URL" | grep -v "PRIVACY_POLICY_URL" | grep -v "UBUNTU_CODENAME")" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
                # On copie dans fichier log
                echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-8) Version de l'OS" >> /var/log/log_evt.log
                ;;

            # Nombre de disques
            9)
                echo -e "\n9) Nombre de disques"
                # On copie dans fichier log
                echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-9) Nombre de disques" >> /var/log/log_evt.log
                
                # Liste uniquement les disques
                echo -e "\n* 9) Nombre de disques :\n`lsblk | grep -v "loop" | grep -v "sr0"`" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
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

            # Partition par disque
            10)
                echo -e "\n10) Partition par disque"
                # On copie dans fichier log
                echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-10) Partition par disque" >> /var/log/log_evt.log

                # On copie dans fichier info
                echo -e "\n* 10) Partition par disque :\n $resultat1=$(df -h | grep -v "tmpfs" | grep -v " /dev/sr0")" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
                
                if [ ${#choice[@]} -eq 1 ]
                    then
                    echo -e "Voici les partitions sur cette machine :\n $resultat1=$(df -h | grep -v "tmpfs" | grep -v " /dev/sr0")" 
                fi
                ;;

            # Espace disque restant
            11)
                echo -e "\n11) Espace disque restant"
                # On copie dans fichier log
                echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-11) Espace disque restant" >> /var/log/log_evt.log
                
                # Enregistrement dans fichir info
                echo -e "\n* 11) Voici la place disponible sur chaque partition :\n $resultat2=$(df -h | grep -v "tmpfs" | grep -v "/dev/sr0" | awk 'BEGIN {OFS="       "} {print $1,$2, $3, $4}')" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"


                if [ ${#choice[@]} -eq 1 ]
                then
                    echo -e "Voici la place disponible sur chaque partition :\n $resultat2=$(df -h | grep -v "tmpfs" | grep -v "/dev/sr0" | awk 'BEGIN {OFS="       "} {print $1,$2, $3, $4}')"
                fi                               
                ;;

            # Nom et espace disque d'un dossier
            12)
                echo -e "\n12) Nom et espace disque d'un dossier"
                # On copie dans fichier log
                echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-12) Nom et espace disque d'un dossier" >> /var/log/log_evt.log

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

                    echo -e "\n* 12) Nom et espace disque d'un dossier\nLa taille du répertoire $directory est :\n $resultat3=$(sudo du -sh "$Total")" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"

                    else
                    echo "Le répertoire '$directory' n'a pas été trouvé dans le chemin spécifié." 
                    fi
                else
                    echo "Le chemin spécifié '$path' n'est pas un répertoire valide." 
                fi
                ;;


            # Liste des lecteurs montés
            13)
                echo -e "\n13) Liste des lecteurs montés"
                # On copie dans fichier log
                echo -e "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-13) Liste des lecteurs montés" >> /var/log/log_evt.log
                
                # On lance les commandes et on les rentre dans une variable
                resultat4=$(lsblk | grep -v "loop")
                
                #Si un seul choix, on affiche le résultat à l'écran
                if [ ${#choice[@]} -eq 1 ]
                    then
                    echo -e "Liste des lecteurs montés :\n$resultat4" 
                fi

                # On enregistre dans le fichier info
                echo -e "\n* 13) Liste des lecteurs montés :\n$resultat4" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"

                ;;

            # Liste des applications/paquets installées
            14)
                echo -e "\n14) Liste des applications paquets/installés"

                # On copie dans fichier log
                echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-14) Liste des applications/paquets installées" >> /var/log/log_evt.log

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
                echo -e "\n* 14) Voici les applications/paquets installés :\n `list`" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"

                fi
                ;;
            # Liste des services en cours d'execution
            15)
                echo -e "\n15) Liste des services en cours d'execution"

                # On copie dans fichier log
                echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-15) Liste des services en cours d'execution" >> /var/log/log_evt.log

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
                    echo -e "\n* 15) Services en cours d'execution :\n `list`" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"

                fi
                ;;
            # Liste des utilisateurs locaux
            16)
                echo -e "\n16) Liste des utilisateurs locaux"

                # On copie dans fichier log
                echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-16) Liste des utilisateurs locaux" >> /var/log/log_evt.log


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

                echo -e "\n* 16) Voici la liste des utilisateurs locaux :\n`list`" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"

                fi
                ;;

            # Mémoire RAM totale"
            17)
                echo -e "\n17) Mémoire RAM totale"

                # On copie dans fichier log
                echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-17) Mémoire RAM totale" >> /var/log/log_evt.log
                
                # On enregistre dans le fichier information
                echo -e "\n* 17) Votre RAM totale est de $(free -h | grep "Mem:" | awk '{print$2}')" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"

                # Si un seul choix dans le menu
                if [ ${#choice[@]} -eq 1 ]
                then
                    # Affichage de la RAM totale avec free et découpe avec awk et grep
                    echo -e "Votre RAM totale est de $(free -h | grep "Mem:" | awk '{print$2}')"
                fi
                ;;

            # Utilisation de la RAM
            18)
                echo -e "\n18) Utilisation de la RAM"

                # On copie dans fichier log
                echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-18) Utilisation de la RAM" >> /var/log/log_evt.log

                # On enregistre dans le fichier information
                echo -e "\n* 18) Votre RAM utilisée est de $(free -h | grep "Mem:" | awk '{print$3}')" >> ~/Documents/"info_`whoami`""_"$FORMATTED_DATE".txt"

                # Si un seul choix dans le menu
                if [ ${#choice[@]} -eq 1 ]
                then
                    # Affichage de la RAM totale avec free et découpe avec awk et grep
                    echo -e "Votre RAM utilisée est de $(free -h | grep "Mem:" | awk '{print$3}')"
                fi

                ;;

  
            
            
            
            *)
                echo -e "${RED}[Erreur] Le programme va fermer.${NC}"
                exit 1
                ;;
        esac
    done
}


# Tant que l'utilisateur tape yes, le programme continue
while [[ $Continue = "yes" || $Continue = "YES" ]]
do
    menu
    echo -e "\n"
    read -p "Tapez [yes] pour continuer : " Continue
    echo -e "\n"
done


# On enregistre la fin du script dans le fichier log
echo "$FORMATTED_DATE-$FORMATTED_TIME-`whoami`-********EndScript********" >> /var/log/log_evt.log

