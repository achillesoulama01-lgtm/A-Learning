# Jour 1 — Le terminal et les commandes de base

## 1. Qu'est-ce que Bash ?

Bash (**B**ourne **A**gain **Sh**ell) est un interpréteur de commandes. Quand tu ouvres un terminal, c'est Bash qui attend tes instructions, les interprète et les exécute.

```
Utilisateur  -->  Terminal  -->  Bash  -->  Système d'exploitation
                                  ^
                          (interprète tes commandes)
```

Pour vérifier quel shell tu utilises :

```bash
echo $SHELL       # Affiche le shell par défaut
bash --version    # Affiche la version de Bash
```

### Anatomie d'une commande

```
commande  -options  argument1  argument2
│         │         │
│         │         └── Sur quoi la commande agit
│         └── Modifie le comportement (commence par -)
└── Le programme à exécuter
```

Exemple : `ls -la /home` → commande `ls`, options `-l` et `-a`, argument `/home`.

---

## 2. Naviguer dans le système de fichiers

Le système de fichiers Linux est un arbre. Tout part de la racine `/`.

```
/
├── home/
│   └── ton_user/     ← ton répertoire personnel (~)
├── etc/              ← fichiers de configuration
├── var/              ← logs, données variables
├── tmp/              ← fichiers temporaires
├── usr/              ← programmes installés
└── bin/              ← commandes essentielles
```

### Commandes de navigation

| Commande | Description | Exemple |
|----------|-------------|---------|
| `pwd` | Affiche le répertoire courant | `pwd` → `/home/user` |
| `cd chemin` | Change de répertoire | `cd /etc` |
| `cd ~` ou `cd` | Retourne au répertoire personnel | `cd ~` |
| `cd ..` | Remonte d'un niveau | `cd ..` |
| `cd -` | Retourne au répertoire précédent | `cd -` |

### La commande `ls` — Lister le contenu

```bash
ls              # Liste simple
ls -l           # Format long (permissions, taille, date)
ls -a           # Affiche les fichiers cachés (commençant par .)
ls -h           # Tailles lisibles (Ko, Mo, Go) — à combiner avec -l
ls -R           # Liste récursivement les sous-dossiers
ls -lah         # Combinaison courante : long + caché + lisible
ls -lt          # Trié par date de modification (plus récent en premier)
```

Décrypter la sortie de `ls -l` :

```
-rw-r--r-- 1 user group 4096 Mar  1 10:00 fichier.txt
│          │ │    │     │    │             │
│          │ │    │     │    │             └── Nom du fichier
│          │ │    │     │    └── Date de modification
│          │ │    │     └── Taille en octets
│          │ │    └── Groupe propriétaire
│          │ └── Utilisateur propriétaire
│          └── Nombre de liens
└── Type et permissions (r=lecture, w=écriture, x=exécution)
```

---

## 3. Manipuler fichiers et dossiers

### Créer

| Commande | Description | Exemple |
|----------|-------------|---------|
| `touch fichier` | Crée un fichier vide (ou met à jour sa date) | `touch notes.txt` |
| `mkdir dossier` | Crée un dossier | `mkdir projets` |
| `mkdir -p a/b/c` | Crée toute l'arborescence d'un coup | `mkdir -p src/lib/utils` |

L'expansion par accolades `{}` permet de créer plusieurs éléments :

```bash
mkdir -p projet/{src,tests,docs,config}
# Crée 4 sous-dossiers en une seule commande

touch fichier{1,2,3}.txt
# Crée fichier1.txt, fichier2.txt, fichier3.txt
```

### Copier, déplacer, renommer

| Commande | Description | Exemple |
|----------|-------------|---------|
| `cp source destination` | Copie un fichier | `cp a.txt b.txt` |
| `cp -r dossier/ copie/` | Copie un dossier (récursif) | `cp -r src/ backup/` |
| `mv source destination` | Déplace ou renomme | `mv ancien.txt nouveau.txt` |

### Supprimer

| Commande | Description | Exemple |
|----------|-------------|---------|
| `rm fichier` | Supprime un fichier | `rm temp.txt` |
| `rm -r dossier/` | Supprime un dossier et son contenu | `rm -r old_backup/` |
| `rm -i fichier` | Demande confirmation avant suppression | `rm -i important.txt` |
| `rmdir dossier` | Supprime un dossier vide uniquement | `rmdir empty_dir/` |

> **Attention** : `rm` ne met pas à la corbeille, la suppression est définitive !

---

## 4. Afficher le contenu des fichiers

| Commande | Description | Exemple |
|----------|-------------|---------|
| `cat fichier` | Affiche tout le contenu | `cat notes.txt` |
| `head fichier` | Affiche les 10 premières lignes | `head /etc/passwd` |
| `head -n 5 fichier` | Affiche les 5 premières lignes | `head -n 5 log.txt` |
| `tail fichier` | Affiche les 10 dernières lignes | `tail /var/log/syslog` |
| `tail -n 3 fichier` | Affiche les 3 dernières lignes | `tail -n 3 log.txt` |
| `tail -f fichier` | Suit le fichier en temps réel | `tail -f /var/log/syslog` |
| `less fichier` | Naviguer dans un fichier (q pour quitter) | `less /etc/passwd` |
| `wc fichier` | Compte lignes, mots, caractères | `wc notes.txt` |
| `wc -l fichier` | Compte uniquement les lignes | `wc -l /etc/passwd` |

---

## 5. Obtenir de l'aide

| Commande | Description | Exemple |
|----------|-------------|---------|
| `man commande` | Manuel complet (naviguer avec flèches, q pour quitter) | `man ls` |
| `commande --help` | Aide rapide | `ls --help` |
| `type commande` | Indique si c'est un builtin, alias ou programme | `type cd` |
| `which commande` | Chemin du programme | `which bash` |

Astuce : dans `man`, tape `/motcherché` pour rechercher, `n` pour résultat suivant.

---

## 6. Raccourcis clavier essentiels

| Raccourci | Action |
|-----------|--------|
| `Tab` | Auto-complétion (le plus utile !) |
| `Tab Tab` | Affiche toutes les possibilités |
| `Ctrl+C` | Interrompt la commande en cours |
| `Ctrl+L` | Efface l'écran (équivalent de `clear`) |
| `Ctrl+A` | Début de ligne |
| `Ctrl+E` | Fin de ligne |
| `Ctrl+R` | Recherche dans l'historique |
| `↑ / ↓` | Naviguer dans l'historique |
| `!!` | Répète la dernière commande |
| `!$` | Dernier argument de la commande précédente |

---

## Résumé du jour

Tu sais maintenant :
- Ce qu'est Bash et comment il fonctionne
- Naviguer dans l'arborescence (`pwd`, `cd`, `ls`)
- Créer, copier, déplacer et supprimer des fichiers et dossiers
- Afficher le contenu de fichiers (`cat`, `head`, `tail`, `less`, `wc`)
- Trouver de l'aide (`man`, `--help`, `type`, `which`)
- Utiliser les raccourcis clavier pour gagner du temps

Passe maintenant aux exercices pratiques dans `exercices.md` !
