# Mini-projet — Renommeur par lot (30 min)

## Objectif

Créer un script `batch_rename.sh` qui renomme en masse des fichiers selon un motif de recherche et un motif de remplacement, avec confirmation avant chaque renommage.

## Spécifications

### Arguments du script

Le script doit accepter **trois arguments** (dans cet ordre) :

1. **Répertoire** : le dossier contenant les fichiers à renommer
2. **Motif de recherche** : le texte ou le motif à rechercher dans les noms de fichiers (ex. `old`, `*.txt`)
3. **Motif de remplacement** : le texte par lequel remplacer (ex. `new`, `.bak`)

### Exemple d'utilisation

```bash
./batch_rename.sh /chemin/vers/dossier "old" "new"
```

Renomme `fichier_old.txt` → `fichier_new.txt`, etc.

### Comportement attendu

1. **Vérifications** :
   - Le répertoire existe et est accessible
   - Les trois arguments sont fournis
   - Au moins un fichier correspond au motif

2. **Pour chaque fichier correspondant** :
   - Afficher le nom actuel et le nom proposé
   - Demander confirmation : `Renommer ? (o/n) `
   - Si l'utilisateur tape `o` ou `O`, effectuer le renommage
   - Si l'utilisateur tape `n` ou `N`, passer au fichier suivant
   - Gérer toute autre touche (optionnel : considérer comme non)

3. **Cas particuliers à gérer** :
   - Le fichier cible existe déjà → avertir et ne pas écraser
   - Le nom de remplacement est identique au nom actuel → ignorer
   - Fichiers cachés (commençant par `.`) : à inclure ou exclure selon ton choix (documente-le)

### Indices

- Utilise une boucle `for` pour parcourir les fichiers
- Pour le motif, tu peux utiliser `*motif*` ou laisser l'utilisateur préciser (ex. `*old*`)
- `read -r reponse` pour la confirmation
- `mv` pour renommer
- `[ -e "$fichier" ]` pour vérifier qu'un fichier existe

### Bonus

- Afficher un résumé à la fin : « X fichiers renommés sur Y proposés »
- Gérer le motif avec des caractères spéciaurs (`*`, `?`) via `glob`

---

Bonne chance ! La solution est dans `solution.sh`.
