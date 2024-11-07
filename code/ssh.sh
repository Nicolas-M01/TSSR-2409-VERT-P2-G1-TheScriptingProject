#!/bin/bash

# Demande d'IP pour la connexion
read -p "Sur quelle machine souhaitez-vous vous connecter ? Veuillez entrer une adresse IP : " ip 

# Fonction pour vérifier si l'adresse IP est valide
function validate_ip() {
    local ip="$1"
   
    # Vérifie le format de l'adresse IP
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then		
        IFS='.' read -r i1 i2 i3 i4 <<< "$ip"
        
        # Vérifie que chaque octet est compris entre 0 et 255
        if [[ $i1 -le 255 && $i2 -le 255 && $i3 -le 255 && $i4 -le 255 ]]; then
            return 0  # IP valide
        fi
    fi
    return 1  # IP invalide
}

# Vérifie si l'IP est valide
if validate_ip "$ip"; then

    # Demande sur quel utilisateur se connecter
    read -p "Veuillez entrer un utilisateur : " user

    # Tentative de connexion et transfert du fichier
    echo "Tentative de connexion à $ip avec l'utilisateur $user..."
    
    # Copie du fichier sur la machine distante
    scp Bashtotal.sh "$user@$ip:/tmp" 
    
    # Exécution des commandes SSH
    ssh "$user@$ip" 


    

else
    echo "L'adresse IP fournie n'est pas valide. Veuillez entrer une IP valide."
fi
