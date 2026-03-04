# Jour 2 : Redirections et Pipes en Bash

## Introduction

Aujourd'hui, nous allons découvrir comment contrôler le flux des données entre les commandes et les fichiers. Ces concepts sont fondamentaux pour exploiter toute la puissance du shell Linux.

---

## 1. Les flux standard (Standard Streams)

Chaque programme en Linux possède **trois flux de communication** par défaut :

| FD | Nom | Numéro | Description | Par défaut |
|----|-----|--------|-------------|------------|
| stdin | Entrée standard | 0 | Données lues par le programme | Clavier |
| stdout | Sortie standard | 1 | Résultats normaux du programme | Terminal |
| stderr | Erreur standard | 2 | Messages d'erreur | Terminal |

### Schéma des flux standard

```
                    ┌─────────────────┐
                    │   Programme     │
   Clavier ────────►│   (commande)    │
   (stdin 0)        │                 │
                    │  stdout (1) ────┼────────► Terminal (résultats)
                    │  stderr (2) ────┼────────► Terminal (erreurs)
                    └─────────────────┘
```

### Exemple pratique

```bash
# La commande ls affiche sur stdout
ls

# La commande cat lit depuis stdin (clavier) si aucun fichier n'est donné
cat
# Tapez du texte puis Ctrl+D pour terminer
```

---

## 2. Les redirections

Les redirections permettent de **changer la destination** des flux (fichier au lieu du terminal, etc.).

### Redirection de la sortie standard (stdout)

| Opérateur | Effet | Exemple |
|-----------|-------|---------|
| `>` | Écraser un fichier | `echo "texte" > fichier.txt` |
| `>>` | Ajouter à la fin d'un fichier | `echo "ligne 2" >> fichier.txt` |

```bash
# Créer ou écraser un fichier
echo "Bonjour le monde" > message.txt

# Ajouter sans écraser
echo "Deuxième ligne" >> message.txt
cat message.txt
# Bonjour le monde
# Deuxième ligne
```

### Redirection de l'entrée standard (stdin)

| Opérateur | Effet | Exemple |
|-----------|-------|---------|
| `<` | Lire depuis un fichier | `wc -l < fichier.txt` |

```bash
# Compter les lignes en lisant depuis un fichier
wc -l < /etc/passwd

# cat peut lire depuis un fichier
cat < /etc/hostname
```

### Redirection des erreurs (stderr)

| Opérateur | Effet | Exemple |
|-----------|-------|---------|
| `2>` | Rediriger stderr vers un fichier | `ls /inexistant 2> erreurs.txt` |
| `2>>` | Ajouter stderr à un fichier | `commande 2>> log_erreurs.txt` |

```bash
# Les erreurs vont dans erreurs.txt, pas à l'écran
ls /dossier_inexistant 2> erreurs.txt

# Rediriger les erreurs vers "nulle part" (les supprimer)
ls /etc/ 2> /dev/null
```

### Redirections combinées

| Opérateur | Effet | Exemple |
|-----------|-------|---------|
| `2>&1` | Rediriger stderr vers stdout | `commande > tout.txt 2>&1` |
| `&>` | Rediriger stdout ET stderr | `commande &> tout.txt` |
| `>&` | Équivalent à `&>` | `commande > tout.txt 2>&1` |

```bash
# Capturer tout (sortie + erreurs) dans un fichier
ls /etc /inexistant &> resultat.txt

# Ordre important : 2>&1 doit venir APRÈS >
ls /etc /inexistant > resultat.txt 2>&1
```

### Tableau récapitulatif des redirections

```
> fichier      → stdout vers fichier (écrase)
>> fichier     → stdout vers fichier (ajoute)
< fichier      → stdin depuis fichier
2> fichier     → stderr vers fichier (écrase)
2>> fichier    → stderr vers fichier (ajoute)
2>&1           → stderr vers stdout
&> fichier     → stdout et stderr vers fichier
```

---

## 3. Le pipe (tuyau) `|`

Le **pipe** permet de **chaîner des commandes** : la sortie d'une commande devient l'entrée de la suivante.

### Schéma du pipe

```
Commande A          Commande B          Commande C
    │                    │                    │
    │  stdout            │  stdin              │
    └──────────────────►│                    │
                         │  stdout            │  stdin
                         └──────────────────►│
                                              │  stdout
                                              └────────► Terminal
```

### Exemples

```bash
# Lister les processus et filtrer ceux contenant "bash"
ps aux | grep bash

# Compter le nombre de lignes d'un fichier
cat fichier.txt | wc -l

# Chaîner plusieurs commandes
cat /etc/passwd | cut -d: -f1 | sort
```

---

## 4. Filtres essentiels

### grep — Rechercher des motifs

Filtre les lignes contenant un motif (texte ou expression régulière).

| Option | Description | Exemple |
|--------|-------------|---------|
| `-i` | Insensible à la casse | `grep -i "error" fichier` |
| `-v` | Inverser (lignes qui NE contiennent PAS) | `grep -v "^#" fichier` |
| `-n` | Afficher le numéro de ligne | `grep -n "motif" fichier` |
| `-c` | Compter les occurrences | `grep -c "motif" fichier` |
| `-r` | Recherche récursive dans les dossiers | `grep -r "texte" ./dossier` |

```bash
# Recherche simple
grep "root" /etc/passwd

# Insensible à la casse
grep -i "ERROR" /var/log/syslog

# Exclure les commentaires
grep -v "^#" /etc/fstab

# Avec numéros de ligne
grep -n "bash" /etc/passwd

# Compter les lignes contenant "root"
grep -c "root" /etc/passwd
```

### sort — Trier les lignes

| Option | Description | Exemple |
|--------|-------------|---------|
| `-n` | Tri numérique | `sort -n nombres.txt` |
| `-r` | Ordre inverse | `sort -r fichier` |
| `-k` | Trier par champ | `sort -k2 fichier` |
| `-t` | Délimiteur de champs | `sort -t: -k3 -n /etc/passwd` |

```bash
# Tri alphabétique par défaut
sort fichier.txt

# Tri numérique
echo -e "10\n2\n20\n1" | sort -n
# 1 2 10 20

# Tri inverse
sort -r fichier.txt

# Tri par 3ème champ (UID) dans /etc/passwd
sort -t: -k3 -n /etc/passwd
```

### uniq — Supprimer les doublons consécutifs

**Important** : `uniq` ne supprime que les lignes **consécutives** identiques. Utilisez `sort` avant pour regrouper les doublons.

| Option | Description | Exemple |
|--------|-------------|---------|
| `-c` | Compter les occurrences | `uniq -c fichier` |
| `-d` | Afficher uniquement les doublons | `uniq -d fichier` |

```bash
# Avec sort pour regrouper les doublons
cut -d: -f7 /etc/passwd | sort | uniq

# Compter les occurrences
cut -d: -f7 /etc/passwd | sort | uniq -c

# Afficher seulement les lignes en double
sort fichier | uniq -d
```

### cut — Extraire des colonnes

| Option | Description | Exemple |
|--------|-------------|---------|
| `-d` | Délimiteur | `cut -d: -f1 fichier` |
| `-f` | Numéro(s) de champ | `cut -d: -f1,3 fichier` |

```bash
# Extraire le premier champ (noms d'utilisateurs)
cut -d: -f1 /etc/passwd

# Extraire les champs 1 et 3
cut -d: -f1,3 /etc/passwd

# Avec délimiteur espace
echo "a b c" | cut -d' ' -f2
# b
```

### tr — Translittérer/transformer les caractères

| Usage | Description | Exemple |
|-------|-------------|---------|
| `tr 'a-z' 'A-Z'` | Minuscules → Majuscules | `echo "hello" \| tr 'a-z' 'A-Z'` |
| `tr -d 'x'` | Supprimer des caractères | `echo "hello" \| tr -d 'l'` |
| `tr -s ' '` | Réduire les espaces multiples | `echo "a  b" \| tr -s ' '` |

```bash
# Minuscules vers majuscules
echo "bonjour bash" | tr 'a-z' 'A-Z'
# BONJOUR BASH

# Supprimer les espaces
echo "a b c" | tr -d ' '

# Remplacer des caractères
echo "hello" | tr 'el' 'EL'
# HELLo
```

### tee — Dupliquer le flux

Envoie la sortie **à la fois** vers un fichier ET vers stdout (terminal).

```bash
# Sauvegarder ET afficher
ls -la | tee sauvegarde.txt

# Ajouter à un fichier (-a)
echo "nouvelle ligne" | tee -a log.txt

# Utile pour déboguer un pipe
cat fichier | grep "motif" | tee resultat.txt | wc -l
```

---

## 5. Globbing (caractères génériques)

Le globbing permet de **sélectionner plusieurs fichiers** par motif. C'est le shell qui développe les motifs avant d'exécuter la commande.

### Les métacaractères

| Caractère | Signification | Exemple | Correspond à |
|-----------|---------------|---------|---------------|
| `*` | Zéro ou plusieurs caractères | `*.txt` | fichier.txt, a.txt, .txt |
| `?` | Un seul caractère | `fichier?.txt` | fichier1.txt, fichierA.txt |
| `[...]` | Un caractère parmi la liste | `fichier[123].txt` | fichier1.txt, fichier2.txt, fichier3.txt |
| `[!...]` | Un caractère NON dans la liste | `fichier[!0-9].txt` | fichierA.txt (pas fichier1.txt) |
| `{...}` | Expansion d'accolades | `fichier{1,2,3}.txt` | fichier1.txt, fichier2.txt, fichier3.txt |

### Exemples détaillés

```bash
# Tous les fichiers .txt
ls *.txt

# Fichiers commençant par "test"
ls test*

# Un seul caractère à la place du ?
ls fichier?.txt
# Correspond : fichier1.txt, fichierA.txt
# Ne correspond pas : fichier10.txt, fichier.txt

# Plage de caractères
ls fichier[0-9].txt      # fichier0.txt à fichier9.txt
ls fichier[a-z].txt      # fichiera.txt à fichierz.txt

# Plusieurs possibilités avec {}
echo fichier{1,2,3}.txt
# fichier1.txt fichier2.txt fichier3.txt

# Combinaison
echo backup-{2023,2024}-{01,02}.log
# backup-2023-01.log backup-2023-02.log backup-2024-01.log backup-2024-02.log
```

### Attention

- Le globbing est fait par le **shell**, pas par la commande
- Si aucun fichier ne correspond, Bash peut passer le motif littéral (selon la configuration)
- Utilisez `*` avec prudence : `rm *` supprime tout !

---

## 6. Résumé du jour

### Flux et redirections

| Concept | Rôle |
|---------|------|
| stdin (0) | Entrée des données |
| stdout (1) | Sortie normale |
| stderr (2) | Sortie des erreurs |
| `>`, `>>` | Rediriger stdout |
| `<` | Rediriger stdin |
| `2>`, `2>>` | Rediriger stderr |
| `2>&1`, `&>` | Combiner stdout et stderr |

### Pipes et filtres

| Commande | Usage principal |
|----------|-----------------|
| `\|` | Chaîner des commandes |
| `grep` | Filtrer les lignes par motif |
| `sort` | Trier les lignes |
| `uniq` | Supprimer doublons consécutifs |
| `cut` | Extraire des colonnes |
| `tr` | Transformer des caractères |
| `tee` | Dupliquer le flux |

### Globbing

| Motif | Signification |
|-------|---------------|
| `*` | N'importe quels caractères |
| `?` | Un seul caractère |
| `[...]` | Un caractère parmi une liste |
| `{a,b,c}` | Expansion d'accolades |

---

**Prochaine étape** : Passez aux exercices pour mettre en pratique ces concepts !
