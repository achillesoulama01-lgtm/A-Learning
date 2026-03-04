# Jour 4 : Exercices sur les conditions

**Durée estimée : 50 minutes**

---

## Exercice 1 : Fichier ou dossier ? (8 min)

Écrivez un script `fichier_ou_dossier.sh` qui :
- Prend **un argument** en paramètre (un chemin)
- Affiche « C'est un fichier » si l'argument est un fichier régulier (`-f`)
- Affiche « C'est un dossier » si l'argument est un répertoire (`-d`)
- Affiche « N'existe pas ou type inconnu » dans les autres cas

**Exemples d'utilisation :**
```bash
./fichier_ou_dossier.sh /etc/passwd    # → C'est un fichier
./fichier_ou_dossier.sh /tmp           # → C'est un dossier
./fichier_ou_dossier.sh /inexistant    # → N'existe pas ou type inconnu
```

**Bonus :** Gérer le cas où aucun argument n'est fourni (afficher un message d'erreur).

---

## Exercice 2 : Comparer deux nombres (10 min)

Écrivez un script `comparer.sh` qui :
- Prend **deux arguments numériques**
- Affiche si le premier est plus grand, plus petit ou égal au second
- Utilise les opérateurs `-gt`, `-lt`, `-eq`

**Exemples d'utilisation :**
```bash
./comparer.sh 5 10    # → 5 est inférieur à 10
./comparer.sh 20 15   # → 20 est supérieur à 15
./comparer.sh 7 7     # → 7 est égal à 7
```

**Bonus :** Vérifier que les deux arguments sont bien des nombres (utiliser une expression régulière ou `[[ $1 =~ ^[0-9]+$ ]]`).

---

## Exercice 3 : Vérifier si l'utilisateur est root (8 min)

Écrivez un script `est_root.sh` qui :
- Vérifie si le script est exécuté par l'utilisateur **root**
- Utilise la variable `$UID` (User ID : 0 = root)
- Affiche « Vous êtes root » ou « Vous n'êtes pas root »

**Rappel :** Sous Linux, l'utilisateur root a toujours l'UID 0.

**Exemple :**
```bash
# En tant que root
sudo ./est_root.sh    # → Vous êtes root

# En tant qu'utilisateur normal
./est_root.sh         # → Vous n'êtes pas root
```

---

## Exercice 4 : Script de notation (12 min)

Écrivez un script `noter.sh` qui :
- Prend une **note sur 20** en argument
- Affiche la mention correspondante :
  - **Excellent** : note ≥ 16
  - **Bien** : note ≥ 12 et < 16
  - **Passable** : note ≥ 10 et < 12
  - **Insuffisant** : note < 10

**Exemples d'utilisation :**
```bash
./noter.sh 18    # → Excellent
./noter.sh 14    # → Bien
./noter.sh 10    # → Passable
./noter.sh 5     # → Insuffisant
```

**Bonus :** Vérifier que la note est entre 0 et 20, sinon afficher « Note invalide ».

---

## Exercice 5 : Jour ouvré ou week-end ? (12 min)

Écrivez un script `jour_semaine.sh` qui :
- Prend un **jour de la semaine** en argument (lundi, mardi, mercredi, etc.)
- Utilise une structure **`case`**
- Affiche « Jour ouvré » pour lundi à vendredi
- Affiche « Week-end » pour samedi et dimanche
- Affiche « Jour inconnu » pour toute autre valeur

**Exemples d'utilisation :**
```bash
./jour_semaine.sh lundi      # → Jour ouvré
./jour_semaine.sh samedi     # → Week-end
./jour_semaine.sh mardi      # → Jour ouvré
./jour_semaine.sh inconnu    # → Jour inconnu
```

**Conseil :** Utilisez `|` pour regrouper les jours : `lundi|mardi|mercredi|jeudi|vendredi`

---

## Récapitulatif des compétences testées

| Exercice | Compétences |
|----------|-------------|
| 1 | Tests fichiers (`-f`, `-d`), arguments |
| 2 | Comparaisons numériques (`-gt`, `-lt`, `-eq`) |
| 3 | Variable `$UID`, condition simple |
| 4 | `if/elif/else`, comparaisons multiples |
| 5 | Structure `case`, motifs avec `\|` |

Bonne chance ! 🚀
