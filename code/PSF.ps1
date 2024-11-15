# Afficher la bannière
Write-Host "   __      ___ _    _    ___         _         ___     _             _ " -ForegroundColor Magenta
Write-Host "   \ \    / (_) |__| |  / __|___  __| |_ ___  / __| __| |_  ___  ___| |" -ForegroundColor Magenta
Write-Host "    \ \/\/ /| | / _' | | (__/ _ \/ _`  | / -_) \__ \/ _| ' \/ _ \/ _ \ |" -ForegroundColor Magenta
Write-Host "     \_/\_/ |_|_\__,_|  \___\___/\__,_|_\___| |___/\__|_||_\___/\___/_|" -ForegroundColor Magenta
Write-Host "                                                                    " -ForegroundColor Magenta

while ($true) {
    # Menu principal    
    Write-Host "[1] Menu Marche/Arrêt:" -ForegroundColor Gray
    Write-Host "[2] MAJ" -ForegroundColor Gray
    Write-Host "[3] Menu répertoire :" -ForegroundColor Gray
    Write-Host "[4] Version OS" -ForegroundColor Gray
    Write-Host "[5] Quitter" -ForegroundColor Gray
    
    $choix = Read-Host "Veuillez entrer votre choix" 

    switch ($choix) {
        # On rentre dans le menu Marche/Arrêt       
        '1' {
            $MarcheArret = $true # Variable pour revenir en arrière
            
            while ($MarcheArret) {
                # Menu Marche et Arrêt de la machine distante                
                Write-Host "Menu Marche/Arrêt:" -ForegroundColor Green
                # Choix Multiple               
                Write-Host "[1] Arrêter" -ForegroundColor Yellow   
                Write-Host "[2] Redémarrer" -ForegroundColor Yellow
                Write-Host "[3] Verrouiller" -ForegroundColor Yellow
                Write-Host "[4] Retour au menu principal" -ForegroundColor Yellow

                $choixMarcheArrêt = Read-Host "Veuillez entrer votre choix"

                switch ($choixMarcheArrêt) {
                    '1' {
                        Write-Host "Arrêt en cours..." -ForegroundColor Green
                        ssh Administrator@172.16.10.20 "powershell Stop-Computer -Force" # La commande éteint le client distant
                    }
                    '2' {
                        Write-Host "Redémarrage en cours..." -ForegroundColor Green
                        ssh Administrator@172.16.10.20 "powershell Restart-Computer -Force" # La commande redémarre le client distant
                    }
                    '3' {
                        Write-Host "Verrouillage en cours..." -ForegroundColor Green # La commande verrouille le client distant
                        ssh Administrator@172.16.10.20 "powershell rundll32.exe user32.dll,LockWorkStation"
                    }
                    '4' {
                        $MarcheArret = $false # Retour au menu précédent
                    }
                    default {
                        Write-Host "Choix invalide. Veuillez entrer 1, 2, 3 ou 4." -ForegroundColor Red
                    }
                }
            }
        }
        
        '2' {
            $MenuMAJ = $true # Variable pour revenir en arrière
            
            while ($MenuMAJ) {
                Write-Host "MAJ" -ForegroundColor Gray
                # Menu MAJ
                Write-Host "[1] Mettre à jour le système" -ForegroundColor Yellow
                Write-Host "[2] Retour au menu principal" -ForegroundColor Yellow

                $choixMAJ = Read-Host "Veuillez entrer votre choix"

                switch ($choixMAJ) {
                    '1' {
                        # Si la/les MAJ effectuée(s) message de réussite sinon, échec.    
                        Write-Host "Mise à jour du système en cours..." -ForegroundColor Cyan
                        try {
                            ssh Administrator@172.16.10.20 "powershell Get-WindowsUpdate" # La commande met à jour le client distant
                            Write-Host "Mise à jour effectuée avec succès." -ForegroundColor Green
                        } catch {
                            Write-Host "Erreur lors de la mise à jour" -ForegroundColor Red
                        }
                    }
                    '2' {
                        $MenuMAJ = $false # Retour au menu précédent
                    }
                    default {
                        Write-Host "Choix invalide. Veuillez entrer 1 ou 2." -ForegroundColor Red # retour au menu précédent
                    }
                }
            }
        }
        
        '3' {
            # Menu répertoires                
            $MenuRépertoire = $true # Variable pour revenir en arrière
            
            while ($MenuRépertoire) {
                Write-Host "Menu répertoire :" -ForegroundColor Green    
                Write-Host "[1] Créer un répertoire" -ForegroundColor Yellow
                Write-Host "[2] Renommer un répertoire" -ForegroundColor Yellow
                Write-Host "[3] Supprimer un répertoire" -ForegroundColor Yellow
                Write-Host "[4] Retour au menu principal" -ForegroundColor Yellow

                $choixRépertoire = Read-Host "Veuillez entrer votre choix"

                switch ($choixRépertoire) {
                    
                    # Création de Répertoire                    
                    '1' {
                        # Demander à l'utilisateur d'entrer le nom du répertoire à créer
                        $folder = Read-Host -Prompt "Entrez le nom du répertoire à créer : "

                        # Vérifier si le répertoire existe
                        if (Test-Path -Path $folder) {
                            ssh Administrator@172.16.10.20 "powershell Write-Host 'Le répertoire ''$folder'' existe déjà.'" -ForegroundColor Red
                        } else {
                            # Créer le répertoire
                            ssh Administrator@172.16.10.20 "powershell New-Item -ItemType Directory -Path '$folder'"
                            Write-Host "Répertoire '$folder' créé avec succès." -ForegroundColor Green
                        }
                    }

                    # Renommer un répertoire                   
                    '2' {
                        Write-Host "En cours de construction" -ForegroundColor Red
                    }

                    # Supprimer un dossier                   
                    '3' {
                        Write-Host "En cours de construction" -ForegroundColor Red
                    }

                    '4' {
                        $MenuRépertoire = $false
                    }
                    default {
                        Write-Host "Choix invalide. Veuillez entrer 1, 2, 3 ou 4." -ForegroundColor Red
                    }
                }
            }
        }
        
        '4' {
            
            
            # Gestion du menu pour la version de l'OS
            
            $MenuRépertoire = $true
            
                while ($MenuRépertoire) {
                        Write-Host "[1] Version de l'OS" -ForegroundColor Yellow
                        Write-Host "[2] Retour au menu principal" -ForegroundColor Yellow

                        $choixOS = Read-Host "Veuillez entrer votre choix"

                switch ($choixOS) {
                    
                    '1' {
                        
                        Write-Host "La version de l'OS est :" -ForegroundColor Cyan
                        ssh Administrator@172.16.10.20 "powershell (Get-WmiObject -class Win32_OperatingSystem).Caption"
                        }
                    
                    '2' {
                        $MenuRépertoire = $false
                            }
                    
                            default {
                            Write-Host "Choix invalide. Veuillez entrer 1 ou 2." -ForegroundColor Red
                    }
                }
                }   
        }

        '5' {
            Write-Host "Merci d'avoir utilisé le programme." -ForegroundColor Green
            Write-Host "      _                         _       _ " -ForegroundColor Magenta
            Write-Host "     /_\ _  _   _ _ _____ _____(_)_ _  | |" -ForegroundColor Magenta
            Write-Host "    / _ \ || | | '_/ -_) V / _ \ | '_| |_|" -ForegroundColor Magenta
            Write-Host "   /_/ \_\_,_| |_| \___|\_/\___/_|_|   (_) " -ForegroundColor Magenta

            
            
            
            
            exit
        }
        default {
            Write-Host "Choix invalide. Veuillez entrer 1, 2, 3 ou 4." -ForegroundColor Red
        }
    }
    }

