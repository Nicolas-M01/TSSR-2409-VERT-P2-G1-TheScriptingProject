# Documentation générale

## Présentation du projet, objectifs finaux
  - Objectif principal :
    - Depuis une machine Windows Server, on exécute un script PowerShell qui cible des ordinateurs Windows
    - Depuis une machine Debian, on exécute un script shell qui cible des ordinateurs Ubuntu

  - Objectif secondaire :
    - Depuis un serveur, cibler une machine cliente avec un type d’OS différent


## Introduction : mise en contexte
Pour ce projet nous devons réaliser un script d'actions et d'informations, sur une machine distante.

En effet ce script est partagé en deux partie actions et informations, la première partie aura pour effet d'influer directement sur l'OS ciblé, tandis que la deuxième recueillera des informations sur ce même OS.
Le choix à été fait de réaliser le script en 4 partie, une pour chacun des menbres du groupe.

## Membres du groupe de projet (rôles par sprint)
  
|   | Sprint S1 | Sprint S2 |  Sprint S3 | Sprint S4 |  
| :--: | :-------: | :-------: | :-------: | :-------: |  
| SCRUM MASTER | Martin | Martin | Igor  | xxx |  
| PRODUCT OWNER | Igor | Nicolas | Martin | xxx |  
| TECHNICIANS | Elsa & Nicolas | Elsa & Igor | Elsa & Nicolas | xxx & xxx |  

## Choix techniques : quel OS, quelle version, etc.

### 2 CLIENTS
      
  - **Client Windows 10** :
    - Nom : CLIWIN01
    - Compte utilisateur : wilder (dans le groupe des admins locaux)
    - Mot de passe : Azerty1*
    - Adresse IP fixe : 172.16.10.20/24

  - **Client Ubuntu 22.04/24.04 LTS** :
    - Nom : CLILIN01
    - Compte utilisateur : wilder (dans le groupe sudo)
    - Mot de passe : Azerty1*
    - Adresse IP fixe : 172.16.10.30/24

### 2 SERVEURS

  - **Serveur Windows Server 2022** :
    - Nom : SRVWIN01
    - Compte : Administrator (dans le groupe des admins locaux)
    - Mot de passe : Azerty1*
    - Adresse IP fixe : 172.16.10.5/24

  - **Serveur Debian 12** :
    - Nom : SRVLX01
    - Compte : root
    - Mot de passe : Azerty1*
    - Adresse IP fixe : 172.16.10.10/24


**- Difficultés rencontrées : problèmes techniques rencontrés**

1) Notre première difficultée à été de comprendre les besoins de ce script, et donc les solution que nous allions devoir trouver.
2)  La recherche et la compréhention des copmmandes pour les actions demandées.
3)  La compréhention de ce que représente, ainsi que la création de la partie information.
4) La dernière partie du script sur les fichier log_evt.log
5) 
6)

**- Solutions trouvées : Solutions et alternatives trouvées**
 1) => Beaucoup de temps passer à se documenter 

**- Améliorations possibles : suggestions d’améliorations futures**




****
# Installation d'une Machine Virtuelle (VM) sur VirtualBox

## Prérequis Techniques

### 1. Configuration Matérielle de Base
- **Processeur (CPU)** : Le processeur de l'ordinateur hôte doit être compatible avec la virtualisation matérielle. Les processeurs modernes Intel (Intel VT-x) et AMD (AMD-V) supportent cette fonctionnalité, mais elle doit être activée dans le BIOS ou l'UEFI de votre machine.
- **Mémoire vive (RAM)** : Il est recommandé d'avoir au moins 4 Go de RAM ou plus sur la machine hôte. La RAM doit être allouée à la VM (généralement 2 à 4 Go pour un système d'exploitation invité moderne). Veillez à ne pas allouer toute la mémoire RAM disponible :
  - Vérifiez la mémoire RAM disponible : `free -h`
  - Vérifiez l'espace disque disponible : `df -h`
- **Espace de stockage** : Un espace libre suffisant sur votre disque dur (SSD ou HDD) est nécessaire pour stocker les fichiers de la machine virtuelle. Prévoyez plusieurs gigaoctets, selon la taille du système d'exploitation invité et des applications que vous souhaitez y installer.

### 2. Système d'Exploitation Hôte
- VirtualBox fonctionne sur plusieurs systèmes d'exploitation hôtes :
  - Windows (7, 8, 10, 11)
  - Linux (Ubuntu, Fedora, CentOS, etc.)
  - macOS (macOS 10.12 ou plus récent)
- Assurez-vous que votre système d'exploitation hôte est compatible avec la version de VirtualBox que vous souhaitez installer.

### 3. Virtualisation Matérielle (VT-x/AMD-V)
- **Intel VT-x (Intel Virtualization Technology)** ou **AMD-V (AMD Virtualization)** : Ces technologies doivent être activées dans le BIOS/UEFI de l'ordinateur. Cela permet à VirtualBox de créer des environnements virtualisés avec des performances optimales.
  - Pour vérifier si ces fonctionnalités sont activées, vous pouvez entrer dans le BIOS/UEFI au démarrage de l'ordinateur et vérifier les paramètres de virtualisation.
  - Si cette option n'est pas activée ou non disponible, la VM pourrait ne pas démarrer correctement ou rencontrer des problèmes de performance.

### 4. Accès à Internet et Téléchargement des Ressources
- Si vous souhaitez installer un système d'exploitation dans la VM via un fichier ISO téléchargé ou une image disque, il est nécessaire d'avoir une connexion Internet pour récupérer le fichier ISO à partir du site web officiel de l'OS.
- **VirtualBox Extension Pack** : Certains périphériques ou fonctionnalités avancées (comme l’USB 2.0/3.0, le RDP, l’UEFI, etc.) nécessitent l'installation du "VirtualBox Extension Pack", qui peut être téléchargé sur le site officiel de VirtualBox.

### 5. Logiciels et Ressources Supplémentaires
- **ISO ou CD/DVD de l'OS invité** : Vous aurez besoin du fichier ISO ou du support d'installation pour le système d'exploitation que vous voulez installer dans la VM.
- **VirtualBox (logiciel principal)** : Téléchargez la dernière version stable de VirtualBox à partir du site officiel ([https://www.virtualbox.org/](https://www.virtualbox.org/)).
- **VirtualBox Extension Pack (optionnel)** : Il permet d’ajouter des fonctionnalités comme le support des périphériques USB, le démarrage UEFI, etc.

### 6. Compatibilité avec l'OS Invité
- Assurez-vous que le système d'exploitation que vous souhaitez installer est compatible avec VirtualBox. Les versions récentes des systèmes d'exploitation populaires, comme Windows 10/11, Ubuntu, Debian, CentOS, macOS et d'autres, sont généralement supportées sans problème.

### 7. Autres Exigences selon l'OS Invité
- **Drivers** : Certains systèmes d'exploitation invités (comme Windows) nécessitent des drivers spécifiques (par exemple, les additions invitées de VirtualBox, également appelées "Guest Additions") pour améliorer la performance et la gestion des périphériques virtuels.

## Étapes pour l'Installation
1. Téléchargez et installez VirtualBox sur votre machine hôte.
2. Créez une nouvelle VM en sélectionnant l'OS invité souhaité.
3. Ajustez la configuration de la VM (allocation de CPU, RAM, espace disque, etc.).
4. Montez l'ISO de l'OS invité dans la VM.
5. Lancez la machine virtuelle et procédez à l'installation du système d'exploitation.

## En Résumé
- Un processeur avec support de la virtualisation (VT-x ou AMD-V).
- Un système d'exploitation hôte compatible avec VirtualBox.
- De l'espace disque et de la RAM suffisants pour exécuter à la fois l'hôte et la machine virtuelle.
- Accès à Internet pour télécharger des images ISO ou le VirtualBox Extension Pack (optionnel).

# Les Différents OS

Les systèmes d'exploitation (OS, ou « Operating Systems » en anglais) sont des logiciels fondamentaux qui permettent de gérer les ressources matérielles d'un ordinateur et de fournir une interface entre les applications et le matériel. Il existe une grande variété de systèmes d'exploitation, chacun ayant ses propres caractéristiques, avantages et inconvénients. Voici un aperçu des catégories d'OS que nous avons utilisé et de quelques exemples populaires dans chaque catégorie.

## 1. Systèmes d'Exploitation de Bureau
Ces systèmes sont utilisés sur des ordinateurs personnels (PC, portables) et sont conçus pour offrir une interface utilisateur graphique et une large compatibilité avec des logiciels tiers.

### a. Windows
- **Propriétaire** : Microsoft
- **Exemples** : Windows 10, Windows 11
- **Caractéristiques** : 
  - Interface graphique conviviale avec le menu Démarrer, la barre des tâches, etc.
  - Très large compatibilité logicielle et matérielle.
  - Supporte une grande variété de périphériques et d'applications professionnelles.
  - Utilisé massivement dans les environnements d'entreprise et domestiques.
  - Système de mises à jour régulières via Windows Update.
  - Forte compatibilité avec les jeux vidéo.
- **Inconvénients** : 
  - Logiciel propriétaire, coûte généralement cher (licence payante).
  - Plus vulnérable aux virus et malwares.
  - Gestion des ressources parfois inefficace.

### b. Linux (et ses distributions)
- **Open-source** : Communauté de développeurs
- **Exemples** : Ubuntu, Fedora, Debian, Linux Mint, etc.
- **Caractéristiques** : 
  - OS libre et open-source, ce qui permet aux utilisateurs d’y apporter des modifications.
  - Large éventail de distributions (distro) adaptées à différents types d’utilisateurs (facile d'utilisation avec Ubuntu, plus technique avec Arch, etc.).
  - Sécurisé et performant, souvent utilisé pour les serveurs et les environnements de développement.
  - Grande flexibilité (personnalisation, choix des logiciels).
  - Peut être plus léger que Windows ou macOS et donc adapté aux machines avec des ressources limitées.
- **Inconvénients** : 
  - Moins de compatibilité avec certains logiciels commerciaux (comme certains jeux, Microsoft Office, etc.).
  - Courbe d'apprentissage plus élevée pour les débutants.

## 2. Systèmes d'Exploitation Serveur
Les systèmes d'exploitation serveurs sont utilisés pour gérer des serveurs et des infrastructures informatiques.

### a. Windows Server
- **Propriétaire** : Microsoft
- **Exemples** : Windows Server 2022, Windows Server 2019, Windows Server 2016
- **Caractéristiques** : 
  - Conçu pour gérer des environnements serveurs, avec des outils d'administration avancés.
  - Prise en charge des applications d'entreprise, du réseau, des bases de données, etc.
  - Intégration avec Active Directory, SQL Server et d'autres technologies Microsoft.
  - Sécurisé avec des fonctionnalités comme Windows Defender et le chiffrement des données.
- **Inconvénients** : 
  - Coût de licence élevé.
  - Nécessite des ressources matérielles importantes.

### b. Linux Server (ex : Ubuntu Server, Debian)
- **Open-source** : Communauté de développeurs ou entreprise
- **Exemples** : Ubuntu Server, CentOS, etc.
- **Caractéristiques** : 
  - Très populaire dans le monde des serveurs, notamment pour les serveurs web (Apache, Nginx) et les bases de données (MySQL, PostgreSQL).
  - Léger, flexible, et hautement personnalisable.
  - Support de la virtualisation, des containers, et de l'automatisation des tâches avec des outils.
  - Très sécurisé et stable, avec des mises à jour régulières et une communauté active.
- **Inconvénients** : 
  - Courbe d'apprentissage plus prononcée pour les nouveaux utilisateurs.
  - Nécessite une gestion manuelle (mais des outils comme Webmin peuvent faciliter la tâche).

## Conclusion
Les systèmes d'exploitation peuvent être classés selon leur domaine d'application, leur accessibilité (open-source vs propriétaire), et leurs caractéristiques spécifiques. Choisir un système d'exploitation dépend de vos besoins spécifiques en termes de matériel, d'applications, de sécurité, et de budget.


