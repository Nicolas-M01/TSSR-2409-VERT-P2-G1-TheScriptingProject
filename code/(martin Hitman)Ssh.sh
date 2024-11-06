#!/bin/bash

FORMATTED_DATE=$(date +'%Y%m%d') # Formatage de la date en YYYYMMDD
choice=0
target="" # Cible pour les informations. Elle peut être un utilisateur ou un ordinateur


menu()
{
    # Menu selection multiple
    echo -e "\n"
    echo -e "1) Date de dernière connexion de l'utilisateur "
    echo -e "2) Date de dernière modification du mot de passe"
    echo -e "3) Liste des sessions ouvertes par l'utilisateur"

    # Lecture à choix multiple
    echo -e "\nRentrez votre choix et tapez [Entrée]\nOu un choix multiple en espaçant chaque choix (Ex: [1 2 4 9]) et tapez [Entrée]\n"
    # L'utilisateur rentre toutes les informations qu'il a besoin dans le tableau "choice"
    read -a choice


    # boucle sur chaque choix utilisateur qui peuvent être multiples. 
    for i in "${choice[@]}"
    do
         
        case $i in
            1)
                echo "1) Date de dernière connexion de l'utilisateur "
                echo "Pour quel utilisateur voudriez vous connaître la dernière connexion ? "
                read target

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
                    echo "`last $target`"
                    fi
                    last $target >> ~/Documents/"info_<$target>_<$FORMATTED_DATE>.txt"

                # Si elle n'existe pas on avertit et on quitte le programme
                else
                    echo "La cible n'existe pas le programme va s'arrêter"
                    exit 1
                fi
                ;;

            2)
                echo "2) Date de dernière modification du mot de passe"
                echo "Pour quel utilisateur voudriez vous connaître la date de dernière modification de mot de passe ? "
                read target

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
                    PassWordDate=$(sudo passwd -S $target | grep -o "[0-9]*/[0-9]*/[0-9]*")
                    echo "La date de dernière modification du mot de passe de $target était le $PassWordDate "
                    fi
                    echo "La date de dernière modification du mot de passe de $target était le $PassWordDate " >> ~/Documents/"info_<$target>_<$FORMATTED_DATE>.txt"

                # Si la cilbe n'existe pas, on prévient et on ferme
                else
                    echo "La cible n'existe pas le programme va s'arrêter"
                    exit 1
                                
                fi
                ;;

            3)
                echo "choix 3";;

            *)
                echo "Erreur";;
        esac
    done
}
menu


