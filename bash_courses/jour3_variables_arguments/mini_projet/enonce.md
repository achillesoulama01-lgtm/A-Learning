# Mini-projet : Rapport système (sysinfo.sh)

**Durée estimée : 30 minutes**

## Objectif

Créer un script Bash nommé `sysinfo.sh` qui affiche un **rapport système formaté**. Ce mini-projet vous permet de mettre en pratique la substitution de commandes `$(...)` et le formatage de sortie.

---

## Spécifications

Le script doit afficher les informations suivantes, de manière claire et structurée :

| Information | Commande à utiliser | Description |
|-------------|---------------------|-------------|
| **Système d'exploitation** | `uname -o` ou `/etc/os-release` | Nom de l'OS |
| **Version de l'OS** | `cat /etc/os-release` ou `lsb_release` | Version détaillée |
| **Noyau (Kernel)** | `uname -r` | Version du noyau Linux |
| **Temps de fonctionnement** | `uptime -p` ou `uptime` | Durée depuis le dernier démarrage |
| **Mémoire** | `free -h` | Total / utilisée / libre |
| **Espace disque** | `df -h /` ou `df -h .` | Utilisation du disque |
| **Utilisateur connecté** | `who` ou `whoami` | Utilisateur(s) connecté(s) |

---

## Format de sortie attendu

Le rapport doit être **formaté** avec des séparateurs et des labels clairs. Exemple :

```
========================================
       RAPPORT SYSTÈME
========================================

Système d'exploitation : GNU/Linux
Version              : Ubuntu 22.04.3 LTS
Noyau (Kernel)       : 5.15.0-91-generic

--- Temps de fonctionnement ---
Uptime               : up 2 days, 5 hours, 30 minutes

--- Mémoire ---
Mémoire totale       : 15 Gi
Mémoire utilisée     : 8.2 Gi
Mémoire libre        : 4.1 Gi

--- Disque ---
Espace utilisé (/)   : 45%
Espace disponible    : 120G

--- Utilisateur(s) ---
Connecté(s)          : csakande (pts/0)

========================================
```

*Note : Les valeurs exactes dépendront de votre machine. Adaptez le formatage selon les sorties des commandes.*

---

## Contraintes techniques

1. **Substitution de commandes** : Utilisez exclusivement `$(commande)` pour récupérer les informations. Aucune valeur en dur.

2. **Compatibilité** : Certaines commandes peuvent varier selon la distribution Linux :
   - `uname -o` : peut ne pas exister sur tous les systèmes (utilisez `uname -s` en alternative)
   - `/etc/os-release` : présent sur la plupart des distributions modernes
   - `free -h` : format lisible (human-readable)
   - `df -h` : espace disque en Go, Mo, etc.

3. **Extraction des données** : Pour parser des sorties complexes (ex. `free`, `df`), vous pouvez utiliser :
   - `awk` : `free -h | awk '/^Mem:/ {print $2}'`
   - `grep` + `cut` : selon la structure de la sortie

---

## Indices

### Mémoire avec `free -h`
```bash
# Sortie typique :
#               total        used        free      shared  buff/cache   available
# Mem:           15Gi       8.2Gi       4.1Gi       1.2Gi       2.7Gi       5.4Gi

# Pour extraire total : free -h | awk '/^Mem:/ {print $2}'
# Pour extraire used  : free -h | awk '/^Mem:/ {print $3}'
# Pour extraire free  : free -h | awk '/^Mem:/ {print $4}'
```

### Espace disque avec `df -h`
```bash
# Pour la partition racine : df -h / | tail -1 | awk '{print $5}'  # pourcentage
#                             df -h / | tail -1 | awk '{print $4}'  # disponible
```

### OS et version
```bash
# Source : /etc/os-release
# PRETTY_NAME="Ubuntu 22.04.3 LTS"
source /etc/os-release 2>/dev/null && echo "$PRETTY_NAME"
# ou : grep PRETTY_NAME /etc/os-release | cut -d'"' -f2
```

---

## Critères d'évaluation

- [ ] Le script s'exécute sans erreur
- [ ] Toutes les informations demandées sont affichées
- [ ] La substitution de commandes `$()` est utilisée partout
- [ ] La sortie est lisible et bien structurée
- [ ] Le script gère les cas où une commande peut échouer (optionnel : `2>/dev/null`)

---

## Bonus (optionnel)

- Ajouter la **date et l'heure** du rapport
- Afficher le **nom de la machine** (hostname)
- Colorer les titres avec des codes ANSI (ex. `\033[1;32m` pour vert gras)

---

**Bonne chance !**
