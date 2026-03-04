#!/usr/bin/env bash
# Exercice 1 : Créer une arborescence en une seule commande
mkdir -p ~/bash-learning/jour1/projets/{web,api,docs}

# Exercice 2 : Créer 5 fichiers
touch ~/bash-learning/jour1/projets/docs/fichier{1..5}.txt

# Exercice 3 : Copier les .txt vers web/
cp ~/bash-learning/jour1/projets/docs/*.txt ~/bash-learning/jour1/projets/web/

# Exercice 4 : Renommer fichier1.txt en index.txt
mv ~/bash-learning/jour1/projets/web/fichier1.txt ~/bash-learning/jour1/projets/web/index.txt

# Exercice 5 : Lister récursivement avec tailles lisibles
ls -lRh ~/bash-learning/jour1/

# Exercice 6 : Les 3 premières lignes de /etc/passwd
head -n 3 /etc/passwd
# Bonus : nombre total de lignes
wc -l /etc/passwd
# Bonus : 5 dernières lignes
tail -n 5 /etc/passwd

# Exercice 7 : Compter les éléments dans /etc/
ls /etc/ | wc -l
# Bonus : fichiers cachés dans ~
ls -a ~ | wc -l

# Exercice 8 : Explorer les commandes
type cd           # cd is a shell builtin
which bash        # /usr/bin/bash (ou /bin/bash)
# man mkdir       # (interactif — chercher /-p)
cp --help

# Exercice 9 : Nettoyage
rm ~/bash-learning/jour1/projets/docs/fichier5.txt
rmdir ~/bash-learning/jour1/projets/api
mkdir -p ~/bash-learning/jour1/projets/api/v1
rm -r ~/bash-learning/jour1/projets/api

# Exercice 10 : Défi combiné
mkdir -p ~/bash-learning/jour1/defi/alpha/beta
touch ~/bash-learning/jour1/defi/alpha/beta/{a,b,c}.txt
cp -r ~/bash-learning/jour1/defi/alpha/beta ~/bash-learning/jour1/defi/alpha/beta_backup
ls -R ~/bash-learning/jour1/defi/
rm -r ~/bash-learning/jour1/defi/
