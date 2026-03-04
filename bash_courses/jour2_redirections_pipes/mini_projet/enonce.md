# Mini-projet : Analyseur de logs

**Durée estimée : 30 minutes**

## Contexte

Vous êtes administrateur système et devez analyser un fichier de logs d'accès web (format Apache/Nginx) pour extraire des statistiques utiles. Vous utiliserez uniquement des commandes Bash, des pipes et des redirections.

---

## Fichier de données

Le fichier `acces.log` dans ce dossier contient des lignes au format suivant :

```
IP - - [DATE] "METHODE URL PROTOCOLE" CODE_HTTP TAILLE "REFERER" "USER_AGENT"
```

Exemple :
```
192.168.1.10 - - [02/Mar/2025:10:15:30 +0100] "GET /index.html HTTP/1.1" 200 1234 "-" "Mozilla/5.0"
```

---

## Tâches à réaliser

### Tâche 1 : Compter les requêtes par code HTTP (10 min)

**Objectif :** Obtenir le nombre de requêtes pour chaque code HTTP (200, 301, 404, 500, etc.).

**Étapes :**
1. Identifiez la position du code HTTP dans chaque ligne (c'est un champ numérique)
2. Utilisez `awk` ou `cut` pour extraire ce champ
3. Triez et comptez avec `sort | uniq -c`
4. Triez par nombre décroissant avec `sort -rn`

**Indice :** Le code HTTP est généralement le 9ème champ quand on utilise l'espace comme délimiteur. Attention : les guillemets dans l'URL peuvent compliquer `cut`. Utilisez `awk '{print $9}'` pour plus de fiabilité.

**Résultat attendu :** Une liste du type :
```
  12 200
   3 404
   2 301
   1 500
```

---

### Tâche 2 : Trouver les adresses IP uniques (8 min)

**Objectif :** Lister toutes les adresses IP différentes qui ont accédé au serveur.

**Étapes :**
1. Le premier champ de chaque ligne est l'adresse IP
2. Extrayez ce champ avec `cut -d' ' -f1` ou `awk '{print $1}'`
3. Supprimez les doublons avec `sort | uniq`
4. Comptez le nombre total d'IPs uniques avec `wc -l`

**Résultat attendu :** Une liste d'IPs, puis un nombre total.

---

### Tâche 3 : Trouver les URLs les plus visitées (12 min)

**Objectif :** Identifier les URLs les plus demandées (par nombre de requêtes).

**Étapes :**
1. L'URL est dans le 7ème champ (entre guillemets, format "METHODE URL PROTOCOLE")
2. Extrayez l'URL avec `awk` : `awk '{print $7}' acces.log` (le 7ème champ est l'URL seule dans certains formats)
3. En format Apache classique, l'URL peut être extraite avec : `awk -F'"' '{print $2}' acces.log | awk '{print $2}'`
4. Ou plus simplement : `grep -oE '"[A-Z]+ [^ ]+' acces.log | awk '{print $2}'` 
5. Comptez avec `sort | uniq -c | sort -rn`
6. Affichez le top 5 avec `head -5`

**Indice :** Le format exact peut varier. Une approche : `awk '{print $7}' acces.log` si l'URL est au champ 7. Sinon, analysez une ligne pour repérer la position.

**Résultat attendu :** Les 5 URLs les plus visitées avec leur nombre de requêtes.

---

## Guide pas à pas

### Étape 1 : Explorer le fichier
```bash
head acces.log          # Voir les premières lignes
wc -l acces.log         # Nombre total de lignes
```

### Étape 2 : Comprendre la structure
Observez une ligne et repérez :
- Champ 1 : IP
- Champ 9 : Code HTTP (dans le format standard)
- Champ 7 : URL (dans le format standard Apache)

### Étape 3 : Tâche 1 — Codes HTTP
```bash
# À compléter avec la bonne extraction
awk '{print $9}' acces.log | sort | uniq -c | sort -rn
```

### Étape 4 : Tâche 2 — IPs uniques
```bash
cut -d' ' -f1 acces.log | sort | uniq
cut -d' ' -f1 acces.log | sort | uniq | wc -l
```

### Étape 5 : Tâche 3 — URLs les plus visitées
```bash
# Adapter selon le format exact du fichier
awk '{print $7}' acces.log | sort | uniq -c | sort -rn | head -5
```

---

## Vérification

Exécutez le script `solution.sh` pour comparer vos résultats :
```bash
bash solution.sh
```

---

## Défi bonus (optionnel)

Créez un script `analyseur.sh` qui :
1. Prend le fichier de log en argument
2. Affiche un rapport complet avec les 3 statistiques
3. Sauvegarde le rapport dans un fichier `rapport.txt` avec `tee`

Bonne analyse !
