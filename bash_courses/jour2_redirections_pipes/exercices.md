# Exercices — Jour 2 : Redirections et Pipes

**Durée estimée : 50 minutes**

Ces exercices vous permettent de pratiquer les concepts vus dans le cours. Travaillez dans l'ordre et vérifiez chaque résultat avant de passer au suivant.

---

## Exercice 1 — Redirections de base (5 min)

**Objectif :** Utiliser `>` et `>>` pour écrire dans un fichier.

**Instructions :**
1. Créez un fichier nommé `message.txt` contenant exactement le texte : `Bonjour Bash`
2. Ajoutez une deuxième ligne `Ligne 2` au fichier **sans écraser** le contenu existant
3. Affichez le contenu du fichier pour vérifier

**Indice :** Utilisez `echo` avec `>` pour créer, puis `>>` pour ajouter.

**Vérification :**
```bash
cat message.txt
# Vous devez voir :
# Bonjour Bash
# Ligne 2
```

---

## Exercice 2 — Redirection des erreurs (5 min)

**Objectif :** Rediriger stderr pour masquer les messages d'erreur.

**Instructions :**
1. Listez le contenu du répertoire `/etc/` avec `ls`
2. Refaites la même commande en redirigeant les erreurs (s'il y en a) vers `/dev/null`
3. Comparez : la commande `ls /dossier_inexistant` affiche une erreur. Refaites-la en envoyant l'erreur vers `/dev/null`

**Indice :** Utilisez `2>` pour rediriger le flux d'erreur (stderr).

**Vérification :**
```bash
ls /etc/ 2> /dev/null
# Aucune erreur ne doit s'afficher à l'écran

ls /dossier_inexistant 2> /dev/null
# Rien ne s'affiche (ni sortie, ni erreur)
```

---

## Exercice 3 — Compter les lignes (5 min)

**Objectif :** Utiliser une redirection d'entrée et le pipe.

**Instructions :**
1. Comptez le nombre de lignes du fichier `/etc/passwd` en utilisant `wc -l`
2. Faites-le de deux manières :
   - Avec redirection : `wc -l < /etc/passwd`
   - Avec pipe : `cat /etc/passwd | wc -l`

**Indice :** `wc -l` compte les lignes. La redirection `<` envoie le contenu du fichier vers stdin de `wc`.

**Vérification :**
```bash
wc -l < /etc/passwd
cat /etc/passwd | wc -l
# Les deux commandes doivent donner le même résultat (un nombre)
```

---

## Exercice 4 — Extraire des colonnes avec cut (5 min)

**Objectif :** Utiliser `cut` pour extraire le premier champ.

**Instructions :**
1. Le fichier `/etc/passwd` utilise `:` comme séparateur
2. Extrayez uniquement les noms d'utilisateurs (premier champ) avec `cut -d: -f1`
3. Affichez les 5 premiers noms d'utilisateurs

**Indice :** `-d:` définit le délimiteur, `-f1` sélectionne le premier champ.

**Vérification :**
```bash
cut -d: -f1 /etc/passwd | head -5
# Vous devez voir : root, daemon, bin, sys, sync (ou équivalent)
```

---

## Exercice 5 — Shells uniques (7 min)

**Objectif :** Chaîner `cut`, `sort` et `uniq`.

**Instructions :**
1. Extrayez le 7ème champ de `/etc/passwd` (le shell de chaque utilisateur)
2. Triez le résultat avec `sort`
3. Supprimez les doublons avec `uniq`
4. Combinez le tout en une seule commande avec des pipes

**Indice :** `cut -d: -f7` pour le 7ème champ. L'ordre est important : `sort` avant `uniq` !

**Vérification :**
```bash
cut -d: -f7 /etc/passwd | sort | uniq
# Vous devez voir une liste de shells uniques (/bin/bash, /usr/sbin/nologin, etc.)
```

---

## Exercice 6 — Recherche avec grep (6 min)

**Objectif :** Utiliser `grep` pour filtrer des lignes.

**Instructions :**
1. Cherchez toutes les lignes contenant `root` dans `/etc/passwd`
2. Refaites avec l'option `-n` pour afficher les numéros de ligne
3. Comptez combien de lignes contiennent `root` avec l'option `-c`

**Indice :** `grep "root" /etc/passwd` — le motif est entre guillemets.

**Vérification :**
```bash
grep "root" /etc/passwd
grep -n "root" /etc/passwd
grep -c "root" /etc/passwd
# La dernière commande doit afficher un nombre (souvent 1 ou 2)
```

---

## Exercice 7 — Transformation avec tr (5 min)

**Objectif :** Convertir du texte en majuscules avec `tr`.

**Instructions :**
1. Créez une variable ou utilisez `echo` pour avoir le texte : `bonjour le monde`
2. Passez ce texte dans un pipe vers `tr` pour le convertir en majuscules
3. Le résultat doit être : `BONJOUR LE MONDE`

**Indice :** `tr 'a-z' 'A-Z'` ou `tr '[:lower:]' '[:upper:]'`

**Vérification :**
```bash
echo "bonjour le monde" | tr 'a-z' 'A-Z'
# BONJOUR LE MONDE
```

---

## Exercice 8 — Combiner grep, sort et uniq (12 min)

**Objectif :** Analyser un fichier de logs avec une chaîne de commandes.

**Instructions :**
1. Créez un fichier `mini_log.txt` avec le contenu suivant :

```
[INFO] Utilisateur admin connecté
[ERROR] Échec de connexion
[INFO] Page accueil chargée
[WARN] Mémoire faible
[ERROR] Timeout serveur
[INFO] Utilisateur admin connecté
[ERROR] Échec de connexion
[INFO] Sauvegarde effectuée
```

2. Comptez combien de fois chaque type de message apparaît (INFO, ERROR, WARN)
3. Affichez le résultat trié par nombre d'occurrences (du plus fréquent au moins fréquent)

**Indice :**
- Extrayez le type entre crochets : `grep -oE '\[(INFO|ERROR|WARN)\]'` ou utilisez `cut`
- Ou plus simple : `grep -oE '\[.*\]'` pour extraire [INFO], [ERROR], etc.
- `sort | uniq -c` pour compter
- `sort -rn` pour trier par nombre (reverse, numeric)

**Vérification :**
```bash
# Une solution possible :
grep -oE '\[(INFO|ERROR|WARN)\]' mini_log.txt | sort | uniq -c | sort -rn
# Vous devez voir quelque chose comme :
#       2 [INFO] Utilisateur admin connecté  (ou selon votre extraction)
# En fait, avec grep -oE '\[...\]' on obtient [INFO], [ERROR], [WARN]
# Puis uniq -c compte : 4 [INFO], 3 [ERROR], 1 [WARN]
```

*Note :* Une approche plus simple pour extraire le type :
```bash
grep -oE '\[[A-Z]+\]' mini_log.txt | sort | uniq -c | sort -rn
```

---

## Récapitulatif des compétences

| Exercice | Compétences |
|----------|-------------|
| 1 | `>`, `>>`, `echo` |
| 2 | `2>`, `/dev/null` |
| 3 | `<`, `\|`, `wc -l` |
| 4 | `cut -d -f` |
| 5 | `cut`, `sort`, `uniq`, pipes |
| 6 | `grep`, `-n`, `-c` |
| 7 | `tr`, pipes |
| 8 | `grep -oE`, `sort`, `uniq -c`, `sort -rn` |

Bravo ! Vous êtes prêt pour le mini-projet « Analyseur de logs ».
