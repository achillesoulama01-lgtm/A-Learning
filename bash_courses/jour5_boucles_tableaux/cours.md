# Jour 5 — Boucles et tableaux

Ce jour est consacré aux **boucles** (répéter des actions) et aux **tableaux** (stocker des listes de données). Ces notions sont essentielles pour automatiser des tâches et manipuler des collections.

---

## 1. La boucle `for` classique

La boucle `for` parcourt une liste d'éléments, un par un.

### Syntaxe

```bash
for variable in liste; do
    # commandes à répéter
done
```

Ou sur une seule ligne :

```bash
for var in elem1 elem2 elem3; do echo "$var"; done
```

### Itérer sur des mots

```bash
for fruit in pomme poire banane; do
    echo "J'aime les $fruit"
done
```

### Itérer sur une plage numérique `{1..10}`

L'expansion par accolades génère une séquence :

```bash
for i in {1..5}; do
    echo "Numéro $i"
done
```

Avec un pas (Bash 4+) :

```bash
for i in {1..10..2}; do   # 1, 3, 5, 7, 9
    echo "$i"
done
```

### Itérer sur des fichiers

```bash
for fichier in *.txt; do
    echo "Fichier : $fichier"
done
```

> **Attention** : si aucun fichier ne correspond à `*.txt`, Bash laisse le motif littéral. Utilise `shopt -s nullglob` pour éviter cela.

### Itérer sur la sortie d'une commande

```bash
for user in $(cut -d: -f1 /etc/passwd); do
    echo "Utilisateur : $user"
done
```

> **Attention** : `$(commande)` découpe par espaces/tabulations/sauts de ligne. Pour des lignes entières, préfère `while read` (voir section 8).

---

## 2. La boucle `for` style C

Syntaxe familière aux programmeurs C/Java/JavaScript :

```bash
for (( initialisation; condition; incrément )); do
    # commandes
done
```

### Exemple

```bash
for (( i=0; i<10; i++ )); do
    echo "i = $i"
done
```

Autre exemple avec décrémentation :

```bash
for (( j=10; j>0; j-- )); do
    echo "Compte à rebours : $j"
done
```

---

## 3. La boucle `while`

La boucle `while` s'exécute **tant que** la condition est vraie.

### Syntaxe

```bash
while condition; do
    # commandes
done
```

### Exemple avec compteur

```bash
compteur=0
while [ $compteur -lt 5 ]; do
    echo "Compteur : $compteur"
    ((compteur++))   # ou : compteur=$((compteur + 1))
done
```

### Lire une entrée utilisateur

```bash
echo "Tape 'quit' pour quitter"
while read -r reponse; do
    [ "$reponse" = "quit" ] && break
    echo "Tu as tapé : $reponse"
done
```

---

## 4. La boucle `until`

`until` est l'**inverse** de `while` : elle s'exécute **jusqu'à ce que** la condition devienne vraie.

### Syntaxe

```bash
until condition; do
    # commandes
done
```

### Exemple

```bash
compteur=0
until [ $compteur -ge 5 ]; do
    echo "Compteur : $compteur"
    ((compteur++))
done
```

Équivalent à : « répète tant que compteur < 5 ».

---

## 5. `break` et `continue`

### `break` — sortir de la boucle

Interrompt la boucle immédiatement et passe à la suite du script.

```bash
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        echo "Arrêt à 5"
        break
    fi
    echo "$i"
done
# Affiche 1, 2, 3, 4, puis "Arrêt à 5"
```

### `continue` — passer à l'itération suivante

Saute le reste du corps de la boucle et passe à l'itération suivante.

```bash
for i in {1..5}; do
    if [ $i -eq 3 ]; then
        continue
    fi
    echo "$i"
done
# Affiche 1, 2, 4, 5 (3 est ignoré)
```

### `break n` — sortir de n niveaux de boucles

Dans des boucles imbriquées, `break 2` sort des deux boucles.

```bash
for i in 1 2; do
    for j in a b; do
        [ "$j" = "b" ] && break 2
        echo "$i $j"
    done
done
```

---

## 6. Tableaux indexés

Les tableaux indexés stockent une liste ordonnée d'éléments, accessibles par un indice numérique (à partir de 0).

### Déclaration et accès

```bash
# Déclaration
arr=(a b c d e)

# Accès par indice
echo "${arr[0]}"    # a
echo "${arr[2]}"    # c

# Tous les éléments
echo "${arr[@]}"    # a b c d e

# Nombre d'éléments
echo "${#arr[@]}"   # 5

# Indices utilisés
echo "${!arr[@]}"   # 0 1 2 3 4
```

### Ajouter des éléments

```bash
arr=(a b c)
arr+=(d e)
echo "${arr[@]}"   # a b c d e
```

### Tranche (slice) — Bash 4+

```bash
arr=(a b c d e f)
echo "${arr[@]:2:3}"   # éléments de l'indice 2, longueur 3 → c d e
echo "${arr[@]:3}"     # à partir de l'indice 3 jusqu'à la fin → d e f
```

### Parcourir un tableau

```bash
fruits=(pomme poire banane)
for f in "${fruits[@]}"; do
    echo "$f"
done
```

Avec les indices :

```bash
for i in "${!fruits[@]}"; do
    echo "Indice $i : ${fruits[$i]}"
done
```

---

## 7. Tableaux associatifs

Les tableaux associatifs (dictionnaires) utilisent des **clés** au lieu d'indices numériques. Disponibles à partir de Bash 4.

### Déclaration

```bash
declare -A capitales
capitales[France]="Paris"
capitales[Allemagne]="Berlin"
capitales[Japon]="Tokyo"
```

### Accès

```bash
echo "${capitales[France]}"    # Paris
echo "${capitales[Italie]}"    # (vide si non défini)
```

### Parcourir les clés

```bash
for pays in "${!capitales[@]}"; do
    echo "$pays : ${capitales[$pays]}"
done
```

### Parcourir les valeurs

```bash
for ville in "${capitales[@]}"; do
    echo "Ville : $ville"
done
```

---

## 8. Lecture ligne par ligne

Pour traiter un fichier ligne par ligne sans découper les espaces :

```bash
while IFS= read -r line; do
    echo "Ligne : $line"
done < fichier.txt
```

### Explication des options : IFS et `-r`

| Élément | Rôle |
|---------|------|
| **IFS** (Internal Field Separator) | Variable qui définit les caractères utilisés pour découper une ligne en champs. Par défaut : espace, tabulation, saut de ligne. Avec `IFS=`, on vide le séparateur : la ligne entière est lue sans découpage (espaces préservés). |
| **`read -r`** | L'option `-r` désactive l'interprétation des backslashes `\`. Sans `-r`, `\n` serait interprété comme saut de ligne. Avec `-r`, les backslashes sont lus littéralement — indispensable pour des données brutes. |
| `done < fichier` | Redirige le fichier vers l'entrée standard de la boucle. |

### Lire un CSV (séparateur virgule)

```bash
while IFS=',' read -r nom prenom age; do
    echo "Personne : $prenom $nom, $age ans"
done < donnees.csv
```

### Lire depuis un pipe

```bash
cat fichier.txt | while IFS= read -r line; do
    echo "$line"
done
```

> **Attention** : dans un pipe, la boucle s'exécute dans un sous-shell. Les variables modifiées à l'intérieur ne sont pas visibles après la boucle.

---

## 9. Patterns courants

### Boucle infinie

```bash
while true; do
    echo "Appuyez sur Ctrl+C pour arrêter"
    sleep 1
done
```

Ou avec `:` (commande nulle, toujours vraie) :

```bash
while :; do
    # ...
done
```

### Lire depuis un pipe

```bash
ls -1 | while read -r f; do
    echo "Fichier : $f"
done
```

### Boucles imbriquées

```bash
for i in 1 2 3; do
    for j in A B; do
        echo "$i-$j"
    done
done
# 1-A, 1-B, 2-A, 2-B, 3-A, 3-B
```

### Table de multiplication

```bash
for i in {1..10}; do
    for j in {1..10}; do
        printf "%4d" $((i * j))
    done
    echo
done
```

---

## Résumé du jour

| Notion | Syntaxe ou exemple |
|--------|---------------------|
| `for` classique | `for x in a b c; do ...; done` |
| `for` style C | `for ((i=0; i<10; i++)); do ...; done` |
| `while` | `while condition; do ...; done` |
| `until` | `until condition; do ...; done` |
| `break` / `continue` | Sortie ou passage à l'itération suivante |
| Tableau indexé | `arr=(a b c)`, `${arr[0]}`, `${arr[@]}`, `${#arr[@]}` |
| Tableau associatif | `declare -A`, `${!arr[@]}` pour les clés |
| Lecture ligne par ligne | `while IFS= read -r line; do ...; done < fichier` |

Passe aux exercices dans `exercices.md` !
