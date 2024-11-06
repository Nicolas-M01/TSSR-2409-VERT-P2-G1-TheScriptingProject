!#/bin/bash

# Demande d'ip pour la  connection
read -p "Sur quelle machine souhaitez-vous vou connecter? Veuillez rentrer une adresse IP." 

#fonction vérifie si l'adresse IP est valide	
function is_valid_ip() {
	local ip="$1"

#vérifie le format de l'adresse IP
	if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then		
		IFS= '.' read -r i1 i2 i3 i4 <<< "$ip"
#Vérifie que chaque octet est compris entre 0 et 255
		if [[ $i1 -le 255 && $i2 -le 255 && $i3 -le 255 && $i4 -le 255 ]]; then
			return 0 #IP valide

#Connection en ssh si retour de 0		

			if [ $? -eq 0 ]; then
#Demande sur quel Utilisateur
			echo "sur quel utilisateur voulait vous vous connecter?\n"
				
			
			read -p "veuillez rentrer un utilisateur" user

#Connection
				
				scp logiciel.ch "$user@$ip:/computer/tmp
				ssh "$user@$ip"
				ssh "$user@$ip" chmod 744 NOMDUSCRIPT
    				ssh "$user@$ip" ./NOMDUSCRIPT

			fi
		fi
	fi
	return 1
	echo " veuillez rentrer un ip au format valide"
}




