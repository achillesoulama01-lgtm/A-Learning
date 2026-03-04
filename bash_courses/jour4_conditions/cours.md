# Jour 4 : Les conditions en Bash

Bienvenue dans cette leçon sur les structures conditionnelles en Bash. Les conditions permettent d'exécuter du code différemment selon des situations données.

---

## 1. La structure `if / elif / else / fi`

### Syntaxe de base

```bash
if condition
then
    # commandes si la condition est vraie
fi
```

### Syntaxe complète avec `elif` et `else`

```bash
if condition1
then
    # commandes si condition1 est vraie
elif condition2
then
    # commandes si condition2 est vraie (et condition1 fausse)
else
    # commandes si toutes les conditions sont fausses
fi
```

### Indentation

L'indentation n'est **pas obligatoire** en Bash (contrairement à Python), mais elle améliore grandement la lisibilité :

```bash
# Bonne pratique
if [ -f "$fichier" ]; then
    echo "Le fichier existe"
else
    echo "Le fichier n'existe pas"
fi
```

### Exemple pratique

```bash
#!/bin/bash
age=18

if [ "$age" -ge 18 ]; then
    echo "Vous êtes majeur"
elif [ "$age" -ge 16 ]; then
    echo "Vous êtes presque majeur"
else
    echo "Vous êtes mineur"
fi
```

---

## 2. Tests : `[ ]` vs `[[ ]]`

### La commande `test` et son alias `[ ]`

- `[` est une **commande** (alias de `test`)
- Elle nécessite un `]` final comme argument
- **Espaces obligatoires** : `[ condition ]` (espaces autour des crochets et de la condition)

```bash
# Correct
[ -f fichier.txt ]

# Incorrect - erreur de syntaxe
[-f fichier.txt]   # pas d'espace après [
[ -f fichier.txt]  # pas d'espace avant ]
```

### Le mot-clé `[[ ]]` (Bash uniquement)

- `[[` est un **mot-clé** Bash (pas une commande)
- Plus puissant et plus sûr que `[ ]`
- Supporte les expressions régulières avec `=~`
- Gère mieux les variables non initialisées

```bash
# Avec [[ ]], les variables non initialisées ne posent pas de problème
[[ $var = "valeur" ]]  # Pas besoin de guillemets autour de $var

# Avec [ ], toujours mettre des guillemets !
[ "$var" = "valeur" ]
```

### Quand utiliser lequel ?

| Situation | Recommandation |
|-----------|----------------|
| Scripts Bash uniquement | Préférer `[[ ]]` |
| Portabilité POSIX (sh, dash) | Utiliser `[ ]` |
| Expressions régulières | `[[ ]]` avec `=~` |
| Variables potentiellement vides | `[[ ]]` ou guillemets avec `[ ]` |

---

## 3. Comparaisons de nombres

Pour comparer des **nombres entiers**, utilisez les opérateurs suivants (et **jamais** `=`, `<`, `>` pour les nombres) :

| Opérateur | Signification | Exemple |
|-----------|---------------|---------|
| `-eq` | Égal (equal) | `[ 5 -eq 5 ]` |
| `-ne` | Différent (not equal) | `[ 3 -ne 5 ]` |
| `-lt` | Inférieur (less than) | `[ 2 -lt 5 ]` |
| `-gt` | Supérieur (greater than) | `[ 8 -gt 5 ]` |
| `-le` | Inférieur ou égal | `[ 5 -le 5 ]` |
| `-ge` | Supérieur ou égal | `[ 6 -ge 5 ]` |

### Exemples

```bash
#!/bin/bash
nombre=10

if [ "$nombre" -eq 10 ]; then
    echo "Le nombre vaut 10"
fi

if [ "$nombre" -gt 5 ]; then
    echo "Le nombre est supérieur à 5"
fi

if [ "$nombre" -le 20 ]; then
    echo "Le nombre est inférieur ou égal à 20"
fi
```

---

## 4. Comparaisons de chaînes

| Opérateur | Signification | Exemple |
|-----------|---------------|---------|
| `=` | Égal | `[ "$a" = "$b" ]` |
| `!=` | Différent | `[ "$a" != "$b" ]` |
| `-z` | Chaîne vide | `[ -z "$var" ]` |
| `-n` | Chaîne non vide | `[ -n "$var" ]` |

### ⚠️ Guillemets obligatoires pour les variables !

Sans guillemets, une variable vide peut provoquer une erreur de syntaxe :

```bash
nom=""  # variable vide

# DANGEREUX - peut provoquer une erreur
[ $nom = "Pierre" ]   # Devient [ = "Pierre" ] → erreur !

# CORRECT
[ "$nom" = "Pierre" ]  # Devient [ "" = "Pierre" ] → OK
```

### Exemples

```bash
#!/bin/bash
prenom="Marie"
nom=""

if [ "$prenom" = "Marie" ]; then
    echo "Bonjour Marie !"
fi

if [ -z "$nom" ]; then
    echo "Le nom est vide"
fi

if [ -n "$prenom" ]; then
    echo "Le prénom n'est pas vide : $prenom"
fi
```

---

## 5. Tests sur les fichiers

| Opérateur | Signification | Exemple |
|-----------|---------------|---------|
| `-f` | Fichier régulier (existe et n'est pas un dossier) | `[ -f fichier.txt ]` |
| `-d` | Répertoire (directory) | `[ -d /tmp ]` |
| `-e` | Existe (fichier ou dossier) | `[ -e chemin ]` |
| `-r` | Lisible (readable) | `[ -r fichier ]` |
| `-w` | Modifiable (writable) | `[ -w fichier ]` |
| `-x` | Exécutable | `[ -x script.sh ]` |
| `-s` | Non vide (size > 0) | `[ -s fichier ]` |

### Exemples

```bash
#!/bin/bash

# Vérifier si c'est un fichier
if [ -f "rapport.pdf" ]; then
    echo "C'est un fichier"
fi

# Vérifier si c'est un répertoire
if [ -d "/home/user" ]; then
    echo "C'est un répertoire"
fi

# Vérifier si le fichier existe (quel que soit le type)
if [ -e "donnees.txt" ]; then
    echo "Le chemin existe"
fi

# Vérifier les permissions
if [ -r "config.conf" ]; then
    echo "Le fichier est lisible"
fi

if [ -w "log.txt" ]; then
    echo "On peut écrire dans le fichier"
fi

if [ -x "mon_script.sh" ]; then
    echo "Le script est exécutable"
fi

# Vérifier si le fichier n'est pas vide
if [ -s "donnees.txt" ]; then
    echo "Le fichier contient des données"
fi
```

---

## 6. Opérateurs logiques

### À l'intérieur des crochets `[ ]` ou `[[ ]]`

| Opérateur | Signification |
|-----------|---------------|
| `-a` ou `&&` | ET logique |
| `-o` ou `\|\|` | OU logique |
| `!` | NON logique |

```bash
# ET : les deux conditions doivent être vraies
[ -f fichier.txt -a -r fichier.txt ]
[[ -f fichier.txt && -r fichier.txt ]]

# OU : au moins une condition doit être vraie
[ -d /tmp -o -d /var ]
[[ -d /tmp || -d /var ]]

# NON : inverse la condition
[ ! -z "$var" ]
[[ ! -f fichier.txt ]]
```

### À l'extérieur des crochets (entre commandes)

Les opérateurs `&&` et `||` peuvent aussi enchaîner des commandes :

```bash
# Exécute cmd2 seulement si cmd1 réussit (code de sortie 0)
cmd1 && cmd2

# Exécute cmd2 seulement si cmd1 échoue (code de sortie ≠ 0)
cmd1 || cmd2

# Exemple pratique
[ -f fichier.txt ] && echo "Fichier trouvé" || echo "Fichier absent"
```

---

## 7. La structure `case / esac`

Alternative à une longue série de `if/elif`, idéale pour tester une variable contre plusieurs valeurs.

### Syntaxe

```bash
case variable in
    motif1)
        commandes
        ;;
    motif2|motif3)   # Plusieurs motifs avec |
        commandes
        ;;
    *)
        # Cas par défaut (comme else)
        commandes
        ;;
esac
```

### Exemple

```bash
#!/bin/bash
jour="lundi"

case $jour in
    lundi|mardi|mercredi|jeudi|vendredi)
        echo "Jour ouvré"
        ;;
    samedi|dimanche)
        echo "Week-end"
        ;;
    *)
        echo "Jour inconnu"
        ;;
esac
```

### Points importants

- Chaque bloc se termine par `;;` (double point-virgule)
- `|` permet de regrouper plusieurs motifs
- `*)` est le cas par défaut (équivalent de `else`)
- Les motifs peuvent utiliser des wildcards : `[0-9]*`, `*.txt`

---

## 8. Pièges et bonnes pratiques

### Pièges courants

| Erreur | Problème | Solution |
|--------|----------|----------|
| `[ $var = "x" ]` | Variable vide → erreur | `[ "$var" = "x" ]` |
| `[ -f $fichier ]` | Espaces dans le nom → erreur | `[ -f "$fichier" ]` |
| `[ 5 > 3 ]` | `>` redirige ! | `[ 5 -gt 3 ]` |
| `[ -f fichier.txt]` | Pas d'espace avant `]` | `[ -f fichier.txt ]` |
| `if [$x -eq 5]` | Pas d'espace après `[` | `if [ $x -eq 5 ]` |

### Bonnes pratiques

1. **Toujours mettre des guillemets** autour des variables : `"$var"`
2. **Espaces obligatoires** : `[ condition ]` et `[[ condition ]]`
3. **Utiliser `[[ ]]`** dans les scripts Bash pour plus de sécurité
4. **Préférer `case`** pour tester une variable contre plusieurs valeurs fixes
5. **Tester les arguments** avant de les utiliser : `[ -z "$1" ]`

---

## 9. Résumé

| Élément | Syntaxe |
|---------|---------|
| Condition simple | `if condition; then ... fi` |
| Condition multiple | `if ... elif ... else ... fi` |
| Test | `[ condition ]` ou `[[ condition ]]` |
| Nombres | `-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge` |
| Chaînes | `=`, `!=`, `-z`, `-n` |
| Fichiers | `-f`, `-d`, `-e`, `-r`, `-w`, `-x`, `-s` |
| Logique | `&&`, `\|\|`, `!` |
| Choix multiple | `case ... in ... esac` |

**Règle d'or** : Guillemets autour des variables, espaces dans les crochets !
