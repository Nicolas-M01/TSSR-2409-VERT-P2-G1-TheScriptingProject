#Martin avec Nico, Elsa, Igor
#Pour le projet Numéro 2, de la wcs.
#29/10/2024
#==============================================================
#Script pour :  1) La gestion du Pare-Feu.
#               2) La gestion logiciel.
#               3) L'éxecution d'un script à distance.

#!bin/bash

#COULEURS:
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # Aucune couleur


#Menu à choix multiple, pour la gestion du Pare-Feu

while true; do
  
  echo -e "${YELLOW}**MENU**\n\n${NC}"
  echo -e "1) Gestion Pare-feu"
  echo -e "2) Gestion logiciel"
  echo -e "3) execution du Script sur la machine distante"
  echo -e "${YELLOW}Choisissez une option : ${NC}"
    
    read menu

    case $menu in 

        1)
            echo -e "1) Gestion Pare-feu"
             

            echo -e "${YELLOW}**MENU**\n\n${NC}"
            echo -e "${GREEN}1) Activation/Gestion du Pare-Feu\n${NC}"
            echo -e "${RED}2) Désactivation du Pare-Feu\n${NC}"
            echo -e "3) Sortie\n"
            echo -e "${YELLOW}Choisissez une option : ${NC}"
    
            read choix
# Menu à choix multiple de la gestion ou de l'activation du Pare-Feu
                case $choix in 

                    1)
            
                    
                        
                                echo -e "${YELLOW}**MENU**\n\n${NC}"
                                echo -e "${GREEN}1) Activer le pare feu\n${NC}"     
                                echo -e "${GREEN}2) Autoriser une adresse IP\n${NC}"    
                                echo -e "${RED}3) Bloquer une adresse IP\n${NC}"   
                                echo -e "${BLUE}4) Voir le Statut\n${NC}"    
                                echo -e "5) Sortie\n"   
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
            
                    2)
                        sudo ufw disable
                        ;;
        
                    3)
                        exit
                        ;;           
                
                    *)
                        echo -e "${RED}L'option est invalide, veuillez rentrer une option valide : ${NC}\n"       
                        ;;
        
                esac
                ;;  
        2) 
            echo -e "2) Gestion logiciel\n\n"
            
                echo -e "${GREEN}1) Instaler un logiciel\n${NC}"
                echo -e "${RED}2) Désintaler un Logiciel\n${NC}"

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

                    esac
                    ;;  
    esac
    
done                          
                           