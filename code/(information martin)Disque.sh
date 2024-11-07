

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
                echo "Nombre de disques de `whoami` : $disk_count" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
            else
                echo "Nombre de disque de `whoami` : $disk_count" >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
            fi
            ;;
        
        # Partition du disque
        2)
            echo "Voici les partitions sur cette machine :" 
            resultat1=$(df -h | grep -v "tmpfs" | grep -v " /dev/sr0") 
            echo -e $resultat1 >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
            ;;
        
        # Espace disque restant
        3)
            echo "Voici la place disponible sur chaque partition :" 
            resultat2=(df -h | grep -v "tmpfs" | grep -v "/dev/sr0" | awk 'BEGIN {OFS="       "} {print $1,$2, $3, $4}' 
            echo -e $resultat2 >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
            ;;
        
        # Nom et espace disque d'un dossier
        4)
            echo "Sur quel dossier souhaitez-vous des indications ?" 
            read directory

            echo "Veuillez renseigner un chemin :" 
            read path

            # Vérifier si le chemin existe et est un répertoire
            if [ -d "$path" ]; then
                # Chercher le répertoire spécifié dans le chemin
                Total=$(find "$path" -type d -name "$directory")
                
                
                if [ -n "$Total" ]; then
                    echo "La taille du répertoire $directory est :" 
                    resultat3=(sudo du -sh "$Total") 
                    echo -e $resultat3 >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"

                else
                    echo "Le répertoire '$directory' n'a pas été trouvé dans le chemin spécifié." 
                fi
            else
                echo "Le chemin spécifié '$path' n'est pas un répertoire valide." 
            fi
            ;;
        
        # Liste des lecteurs montés
        5)
            echo "Liste des lecteurs montés :" 
            resultat4=(lsblk | grep -v "loop") 
            echo -e $resultat4 >> ~/Documents/"info_`whoami`_$FORMATTED_DATE.txt"
            ;;
        
        # Choix invalide
        *)
            echo "Veuillez rentrer un choix correct." 
            ;;
    esac
done
