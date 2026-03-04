# Jour 1 — Exercices pratiques (50 min)

Travaille dans le terminal. Chaque exercice t'indique la commande ou l'approche attendue.
Les solutions sont dans le dossier `solutions/`.

---

## Exercice 1 — Créer une arborescence (5 min)

Crée l'arborescence suivante **en une seule commande** :

```
~/bash-learning/jour1/projets/
├── web/
├── api/
└── docs/
```

**Indice** : utilise `mkdir -p` et l'expansion par accolades `{...}`.

Vérifie avec :
```bash
ls -R ~/bash-learning/jour1/
```

---

## Exercice 2 — Créer plusieurs fichiers (5 min)

Dans `~/bash-learning/jour1/projets/docs/`, crée 5 fichiers :
`fichier1.txt`, `fichier2.txt`, `fichier3.txt`, `fichier4.txt`, `fichier5.txt`

**Indice** : utilise `touch` avec l'expansion `{1..5}`.

Vérifie avec :
```bash
ls ~/bash-learning/jour1/projets/docs/
```

---

## Exercice 3 — Copier des fichiers (5 min)

Copie **tous les fichiers `.txt`** de `projets/docs/` vers `projets/web/`.

**Indice** : utilise `cp` avec le glob `*.txt`.

Vérifie avec :
```bash
ls ~/bash-learning/jour1/projets/web/
```

---

## Exercice 4 — Renommer un fichier (5 min)

Dans `projets/web/`, renomme `fichier1.txt` en `index.txt`.

**Indice** : `mv` sert aussi à renommer.

Vérifie avec :
```bash
ls ~/bash-learning/jour1/projets/web/
# Tu devrais voir : fichier2.txt  fichier3.txt  fichier4.txt  fichier5.txt  index.txt
```

---

## Exercice 5 — Lister récursivement (5 min)

Affiche le contenu complet de `~/bash-learning/jour1/` de manière récursive, avec les tailles en format lisible.

**Indice** : combine les options `-l`, `-R` et `-h` de `ls`.

---

## Exercice 6 — Afficher le début d'un fichier (5 min)

Affiche les **3 premières lignes** de `/etc/passwd`.

**Indice** : `head -n`.

Questions bonus :
- Combien de lignes contient ce fichier au total ? (utilise `wc`)
- Affiche les 5 dernières lignes (utilise `tail`)

---

## Exercice 7 — Compter des éléments (5 min)

Compte le nombre d'éléments (fichiers et dossiers) dans `/etc/`.

**Indice** : combine `ls` et `wc -l` avec un pipe `|`.

Questions bonus :
- Combien de **fichiers cachés** y a-t-il dans ton répertoire personnel ? (`ls -a ~ | wc -l`)

---

## Exercice 8 — Explorer les commandes (5 min)

1. Utilise `type` pour déterminer si `cd` est un programme ou un builtin
2. Utilise `which` pour trouver le chemin de `bash`
3. Ouvre le manuel de `mkdir` avec `man mkdir`, cherche l'option `-p` (tape `/\-p` dans man)
4. Affiche l'aide rapide de `cp` avec `cp --help`

---

## Exercice 9 — Nettoyage (5 min)

1. Supprime uniquement `fichier5.txt` dans `projets/docs/`
2. Supprime le dossier `projets/api/` (il est vide, utilise `rmdir`)
3. Crée un dossier `projets/api/v1/` avec `mkdir -p`, puis supprime tout `api/` récursivement avec `rm -r`

---

## Exercice 10 — Défi combiné (5 min)

En **maximum 5 commandes**, réalise tout ceci :
1. Crée le dossier `~/bash-learning/jour1/defi/alpha/beta/`
2. Crée 3 fichiers `a.txt`, `b.txt`, `c.txt` dans `beta/`
3. Copie tout le dossier `beta/` en `beta_backup/` dans `alpha/`
4. Vérifie le résultat avec `ls -R`
5. Supprime tout le dossier `defi/`

---

Bravo ! Passe maintenant au mini-projet dans `mini_projet/enonce.md`.
