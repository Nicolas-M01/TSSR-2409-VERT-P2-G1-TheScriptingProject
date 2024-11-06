#!/bin/bash

# Initialisation des variables target et FORMATTED_DATE
target=$(whoami)
FORMATTED_DATE=$(date +%Y-%m-%d_%H-%M-%S)


while true; do
    # Menu principal
    echo -e "GESTIONNAIRE DE DISQUES :\n"
    echo -e "1) Nombre de disques"
    echo -e "2) Partition par disque"
    echo -e "3) Espace disque restant"
    echo -e "4) Nom et espace disque d'un dossier"
    echo -e "5) Liste des lecteurs montés"
    echo -e "Entrez votre choix : "
    
    read menu

    case $menu in
        # Nombre de disques
        1)
            lsblk | grep -v "loop" | grep -v "sr0"  # Liste uniquement les disques
            disk_count=$(lsblk -d -o NAME | grep -vE "loop|sr0" | wc -l)  # Nombre de disques

            # Structure if pour ajouter ou enlever un "s" en fonction du nombre de disques
            if [ $disk_count -gt 1 ]; then
                echo "Nombre de disques de $target : $disk_count" >> ~/Documents/"info_$target_$FORMATTED_DATE.txt"
            else
                echo "Nombre de disque de $target : $disk_count" >> ~/Documents/"info_$target_$FORMATTED_DATE.txt"
            fi
            ;;
        
        # Partition du disque
        2)
            echo "Voici les partitions sur cette machine :" 
            df -h | grep -v "tmpfs" | grep -v " /dev/sr0" >> ~/Documents/"info_$target_$FORMATTED_DATE.txt"
            ;;
        
        # Espace disque restant
        3)
            echo "Voici la place disponible sur chaque partition :" 
            df -h | grep -v "tmpfs" | grep -v "/dev/sr0" | awk 'BEGIN {OFS="       "} {print $1,$2, $3, $4}' ~/Documents/"info_$target_$FORMATTED_DATE.txt"
            ;;
        
        # Nom et espace disque d'un dossier
        4)
            echo "Sur quel dossier souhaitez-vous des indications ?" ~/Documents/"info_$target_$FORMATTED_DATE.txt"
            read directory

            echo "Veuillez renseigner un chemin :" ~/Documents/"info_$target_$FORMATTED_DATE.txt"
            read path

            # Vérifier si le chemin existe et est un répertoire
            if [ -d "$path" ]; then
                # Chercher le répertoire spécifié dans le chemin
                Total=$(find "$path" -type d -name "$directory")

                if [ -n "$Total" ]; then
                    echo "La taille du répertoire $directory est :" >> "$output_file"
                    sudo du -sh "$Total" >> "$output_file"
                else
                    echo "Le répertoire '$directory' n'a pas été trouvé dans le chemin spécifié." >> "$output_file"
                fi
            else
                echo "Le chemin spécifié '$path' n'est pas un répertoire valide." >> "$output_file"
            fi
            ;;
        
        # Liste des lecteurs montés
        5)
            echo "Liste des lecteurs montés :" >> "$output_file"
            lsblk | grep -v "loop" >> "$output_file"
            ;;
        
        # Choix invalide
        *)
            echo "Veuillez rentrer un choix correct." >> "$output_file"
            ;;
    esac
done
