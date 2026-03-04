# Jour 5 — Exercices pratiques (50 min)

Travaille dans le terminal ou crée des scripts. Les solutions sont dans le dossier `solutions/ex_solutions.sh`.

---

## Exercice 1 — Boucle `for` : nombres de 1 à 20 (5 min)

Écris une boucle `for` qui affiche les nombres de 1 à 20, un par ligne.

**Indice** : utilise l'expansion `{1..20}`.

---

## Exercice 2 — Renommer les fichiers `.txt` en `.bak` (10 min)

Écris un script qui :
- Prend un chemin de dossier en argument (ou utilise le répertoire courant par défaut)
- Parcourt tous les fichiers `.txt` du dossier
- Renomme chaque fichier en remplaçant l'extension `.txt` par `.bak`

Exemple : `notes.txt` → `notes.bak`

**Indice** : utilise une boucle `for` sur `*.txt` et la commande `mv`.

---

## Exercice 3 — Boucle `while` : mot de passe (10 min)

Écris un script qui :
- Définit un mot de passe secret (ex. `secret123`)
- Demande à l'utilisateur de saisir le mot de passe (sans l'afficher à l'écran)
- Répète la demande tant que le mot de passe est incorrect
- Affiche « Accès autorisé » quand le mot de passe est correct

**Indice** : utilise `read -s` pour masquer la saisie, et une boucle `while`.

---

## Exercice 4 — Lire un fichier CSV ligne par ligne (10 min)

Utilise le fichier `mini_projet/sample.csv` fourni (ou crée un CSV avec colonnes `nom,prenom,age,ville`).

Écris un script qui :
- Lit le fichier CSV ligne par ligne
- Pour chaque ligne (en ignorant l'en-tête), affiche les champs de manière formatée

Exemple de sortie attendue :
```
Personne 1 : Dupont Jean, 28 ans, Paris
Personne 2 : Martin Marie, 34 ans, Lyon
...
```

**Indice** : `while IFS=',' read -r nom prenom age ville; do ...`

---

## Exercice 5 — Tableau des jours de la semaine (5 min)

Crée un tableau contenant les 7 jours de la semaine (lundi à dimanche).

Affiche chaque jour avec son index, au format :
```
[0] lundi
[1] mardi
...
[6] dimanche
```

**Indice** : utilise `jours=(lundi mardi ...)` et une boucle `for` avec `${!jours[@]}`.

---

## Exercice 6 — Table de multiplication (10 min)

Écris un script qui prend un nombre en argument et affiche sa table de multiplication (de 1 à 10).

Exemple : `./script.sh 7` affiche
```
Table de multiplication de 7 :
7 x 1 = 7
7 x 2 = 14
...
7 x 10 = 70
```

**Indice** : utilise `$1` pour l'argument et une boucle `for` sur `{1..10}`.

---

Bravo ! Passe maintenant au mini-projet dans `mini_projet/enonce.md`.
