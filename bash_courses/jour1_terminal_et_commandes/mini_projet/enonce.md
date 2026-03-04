# Mini-projet Jour 1 — Organisateur de projet (30 min)

## Objectif

Créer un script `init_projet.sh` qui automatise la création d'une structure de projet standard.

## Cahier des charges

Le script doit :

1. Créer l'arborescence suivante dans un dossier `mon_projet/` situé dans `~/bash-learning/jour1/` :

```
mon_projet/
├── src/
│   ├── main.sh
│   └── utils.sh
├── tests/
│   └── test_main.sh
├── docs/
│   └── README.md
└── config/
    └── config.env
```

2. Ajouter du contenu dans certains fichiers :
   - `README.md` : le nom du projet et la date de création
   - `main.sh` : le shebang `#!/usr/bin/env bash` et un `echo "Hello World"`
   - `config.env` : quelques variables comme `APP_NAME=mon_projet` et `VERSION=1.0`

3. Rendre les fichiers `.sh` exécutables avec `chmod +x`

4. Afficher un résumé de la structure créée avec `ls -R`

## Étapes suggérées

1. Commence par écrire les commandes une par une dans le terminal pour vérifier qu'elles fonctionnent
2. Ensuite, regroupe-les dans un fichier `init_projet.sh`
3. Rends le script exécutable : `chmod +x init_projet.sh`
4. Exécute-le : `./init_projet.sh`

## Bonus

- Modifie le script pour accepter un nom de projet en paramètre (tu apprendras `$1` au Jour 3, mais tu peux déjà essayer)
- Ajoute un message d'erreur si le dossier existe déjà

La solution est dans `solution.sh`.
