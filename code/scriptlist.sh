#!/bin/bash

FORMATTED_DATE=$(date +'%Y%m%d') # Formatage de la date en YYYYMMDD
choice=0
target="" # Cible pour les informations. Elle peut être un utilisateur ou un ordinateur


menu()
{
    # Menu selection multiple
    echo -e "\n"
    echo -e "7) Liste des applications/paquets installées"
    echo -e "8) Liste des services en cours d'execution"
    echo -e "9) Liste des utilisateurs locaux"

    # Lecture à choix multiple
    echo -e "\nRentrez votre choix et tapez [Entrée]\nOu un choix multiple en espaçant chaque choix (Ex: [1 2 4 9]) et tapez [Entrée]\n"
    # L'utilisateur rentre toutes les informations qu'il a besoin dans le tableau "choice"
    read -a choice


    # boucle sur chaque choix utilisateur qui peuvent être multiples. 
    for i in "${choice[@]}"
    do
         
        case $i in
            7)
                
                # Fonction qui va mettre dans une liste les applications/paquets installées
                function list() {
                apt list --installed
                }

                user=$(whoami)

                if [ $? -eq 0 ]
                then                
                    # On compte le nombre d'éléments dans le tableau
                    # Si il n'y en a qu'un on l'affiche
                    if [ ${#choice[@]} -eq 1 ]
                    then
                    # On affiche le résultat de la commande à l'écran.
                    list
                    echo "Voici les applications/paquets installées"
                    fi
                    list >> ~/Documents/info-$user-$FORMATTED_DATE.txt

                fi
                ;;
            
            8)

                # Fonction qui va mettre dans une liste les services en cours d'execution
                function list() {
                systemctl --type=service --state=running --no-pager --quiet

                }

                user=$(whoami)

                if [ $? -eq 0 ]
                then                
                    # On compte le nombre d'éléments dans le tableau
                    # Si il n'y en a qu'un on l'affiche
                    if [ ${#choice[@]} -eq 1 ]
                    then
                    # On affiche le résultat de la commande à l'écran.
                    list
                    echo
                    echo "Voici les services en cours d'execution"
                    fi
                    list >> ~/Documents/info-$user-$FORMATTED_DATE.txt

                fi
                ;;

            9) 

                # Fonction qui va mettre dans une liste les services en cours d'execution
                function list() {
                cut -d: -f1 /etc/passwd

                }

                user=$(whoami)

                if [ $? -eq 0 ]
                then                
                    # On compte le nombre d'éléments dans le tableau
                    # Si il n'y en a qu'un on l'affiche
                    if [ ${#choice[@]} -eq 1 ]
                    then
                    # On affiche le résultat de la commande à l'écran.
                    list
                    echo
                    echo "Voici la liste des utilisateur locaux"
                    fi
                    list >> ~/Documents/info-$user-$FORMATTED_DATE.txt

                fi
                ;;

        esac
    done
}
menu
