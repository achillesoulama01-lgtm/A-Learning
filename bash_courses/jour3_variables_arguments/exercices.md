# Exercices — Jour 3 : Variables et arguments

**Durée estimée : 50 minutes**

Ces exercices sont progressifs. Complétez-les dans l'ordre pour consolider vos connaissances sur les variables, les arguments et les entrées utilisateur en Bash.

---

## Exercice 1 : Script de salutation (10 min)

### Objectif
Créer un script qui accueille une personne par son nom, passé en argument.

### Instructions
1. Créez un script nommé `salut.sh`
2. Le script doit accepter **un argument** : le nom de la personne
3. Affichez : `Bonjour, [nom] !`
4. **Gestion d'erreur** : si aucun argument n'est fourni, affichez un message d'erreur et quittez avec le code 1

### Indices
- Utilisez `$1` pour le premier argument
- Utilisez `$#` pour vérifier le nombre d'arguments
- La structure conditionnelle : `if [ $# -eq 0 ]; then ... fi`

### Exemple d'exécution

```bash
$ ./salut.sh Marie
Bonjour, Marie !

$ ./salut.sh
Erreur : veuillez fournir un nom en argument.
```

### Critères de réussite
- [ ] Le script affiche le bon message avec le nom
- [ ] Le script gère le cas sans argument
- [ ] Le script est exécutable (`chmod +x salut.sh`)

---

## Exercice 2 : Liste des arguments (10 min)

### Objectif
Créer un script qui affiche le nombre d'arguments reçus et les liste tous à l'aide d'une boucle.

### Instructions
1. Créez un script (nom au choix, ex. `liste_args.sh`)
2. Affichez : `Nombre d'arguments : X` (où X est le nombre réel)
3. Affichez une ligne vide
4. À l'aide d'une boucle `for`, parcourez tous les arguments et affichez chacun sur une ligne avec un numéro : `Argument 1 : [valeur]`

### Indices
- `$#` donne le nombre d'arguments
- Utilisez `for arg in "$@"; do ... done` pour parcourir les arguments
- Vous aurez besoin d'un compteur pour numéroter (ou utilisez une variable incrémentée)

### Exemple d'exécution

```bash
$ ./liste_args.sh pomme banane cerise
Nombre d'arguments : 3

Argument 1 : pomme
Argument 2 : banane
Argument 3 : cerise

$ ./liste_args.sh
Nombre d'arguments : 0

```

### Critères de réussite
- [ ] Le nombre d'arguments est correct
- [ ] Tous les arguments sont listés avec leur numéro
- [ ] Le script fonctionne avec 0, 1 ou plusieurs arguments

---

## Exercice 3 : Interaction avec `read` (10 min)

### Objectif
Créer un script qui demande à l'utilisateur son prénom et son âge via la commande `read`, puis affiche un message personnalisé.

### Instructions
1. Créez un script (ex. `profil.sh`)
2. Demandez le prénom avec un prompt : `Entrez votre prénom : `
3. Demandez l'âge avec un prompt : `Entrez votre âge : `
4. Affichez un message du type : `Bonjour [prénom], vous avez [âge] ans. Bienvenue !`

### Indices
- Utilisez `read -p "texte" variable` pour afficher un prompt et lire la saisie
- Les variables lues sont des chaînes ; pas besoin de conversion pour cet exercice

### Exemple d'exécution

```bash
$ ./profil.sh
Entrez votre prénom : Sophie
Entrez votre âge : 28
Bonjour Sophie, vous avez 28 ans. Bienvenue !
```

### Critères de réussite
- [ ] Les deux questions sont posées avec des prompts clairs
- [ ] Le message final utilise correctement les valeurs saisies
- [ ] Le script fonctionne avec des prénoms composés (ex. "Jean-Pierre")

---

## Exercice 4 : Calculatrice simple (10 min)

### Objectif
Créer une calculatrice en ligne de commande qui prend deux nombres et un opérateur en arguments.

### Instructions
1. Créez un script nommé `calculatrice.sh`
2. Le script doit accepter **3 arguments** : `nombre1 opérateur nombre2`
3. Opérateurs supportés : `+`, `-`, `*`, `/`, `%`
4. Utilisez l'arithmétique Bash `$(( ))` pour effectuer le calcul
5. Affichez : `Résultat : [valeur]`
6. **Gestion d'erreur** : si le nombre d'arguments n'est pas 3, affichez un message d'usage

### Indices
- Vérifiez `$# -eq 3` avant de continuer
- Utilisez `$1`, `$2`, `$3` pour les trois arguments
- Pour l'opérateur, utilisez un `case` ou des `if` : `case $2 in +) resultat=$(( $1 + $3 )) ;; ... esac`

### Exemple d'exécution

```bash
$ ./calculatrice.sh 10 + 5
Résultat : 15

$ ./calculatrice.sh 20 - 7
Résultat : 13

$ ./calculatrice.sh 6 "*" 4
Résultat : 24

$ ./calculatrice.sh 15 / 4
Résultat : 3

$ ./calculatrice.sh 10 % 3
Résultat : 1

$ ./calculatrice.sh 5 3
Usage : ./calculatrice.sh nombre1 opérateur nombre2
```

### Critères de réussite
- [ ] Les 5 opérations fonctionnent correctement
- [ ] Le script gère les arguments manquants ou en trop
- [ ] Pour `*`, pensez à mettre des guillemets : `"*"` (sinon le shell l'interprète)

---

## Exercice 5 : Informations système (10 min)

### Objectif
Créer un script qui affiche des informations sur le système en utilisant la **substitution de commandes** `$(commande)`.

### Instructions
1. Créez un script (ex. `infos.sh`)
2. Affichez les informations suivantes, chacune sur une ligne formatée :
   - **Date et heure** : utilisez `date`
   - **Utilisateur courant** : utilisez `whoami`
   - **Répertoire courant** : utilisez `pwd`
   - **Nom de la machine (hostname)** : utilisez `hostname`

3. Format de sortie souhaité :
   ```
   Date et heure    : [résultat de date]
   Utilisateur      : [résultat de whoami]
   Répertoire       : [résultat de pwd]
   Machine          : [résultat de hostname]
   ```

### Indices
- La substitution se fait avec `$(commande)` : `echo "Date : $(date)"`
- Alignez les deux-points pour une sortie propre (espaces ou tabulations)

### Exemple d'exécution

```bash
$ ./infos.sh
Date et heure    : lun. 02 mars 2025 14:30:00 CET
Utilisateur      : csakande
Répertoire       : /home/csakande-ext/bash_courses
Machine          : mon-ordinateur
```

### Critères de réussite
- [ ] Les 4 informations sont affichées via substitution de commandes
- [ ] Aucune commande n'est exécutée "à la main" — tout passe par `$()`
- [ ] La sortie est lisible et bien formatée

---

## Récapitulatif des compétences évaluées

| Exercice | Compétences |
|----------|-------------|
| 1 | Arguments positionnels (`$1`), `$#`, gestion d'erreur |
| 2 | `$#`, `$@`, boucle `for` |
| 3 | Commande `read -p` |
| 4 | `$(( ))` arithmétique, `case`/`if`, 3 arguments |
| 5 | Substitution de commandes `$(...)` |

---

**Bon courage !** Pensez à tester vos scripts avec différents cas (arguments vides, nombreux arguments, etc.).
