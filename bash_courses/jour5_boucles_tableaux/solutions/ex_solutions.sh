#!/bin/bash
# =============================================================================
# Jour 5 — Solutions des exercices
# =============================================================================

# -----------------------------------------------------------------------------
# Exercice 1 — Boucle for : nombres de 1 à 20 (5 min)
# -----------------------------------------------------------------------------
ex1() {
    for i in {1..20}; do
        echo "$i"
    done
}

# -----------------------------------------------------------------------------
# Exercice 2 — Renommer les fichiers .txt en .bak (10 min)
# -----------------------------------------------------------------------------
ex2() {
    # Dossier : argument 1 ou répertoire courant
    dossier="${1:-.}"
    
    # Vérifier que le dossier existe
    if [ ! -d "$dossier" ]; then
        echo "Erreur : $dossier n'est pas un dossier valide."
        exit 1
    fi
    
    # Parcourir les fichiers .txt
    for fichier in "$dossier"/*.txt; do
        # nullglob : si aucun fichier ne correspond, ne pas garder le motif littéral
        [ -e "$fichier" ] || continue
        nouveau="${fichier%.txt}.bak"
        mv "$fichier" "$nouveau"
        echo "Renommé : $(basename "$fichier") -> $(basename "$nouveau")"
    done
}

# -----------------------------------------------------------------------------
# Exercice 3 — Boucle while : mot de passe (10 min)
# -----------------------------------------------------------------------------
ex3() {
    mot_de_passe="secret123"
    
    while true; do
        echo -n "Entrez le mot de passe : "
        read -s saisie
        echo  # Retour à la ligne après read -s
        
        if [ "$saisie" = "$mot_de_passe" ]; then
            echo "Accès autorisé"
            break
        else
            echo "Mot de passe incorrect. Réessayez."
        fi
    done
}

# -----------------------------------------------------------------------------
# Exercice 4 — Lire un fichier CSV ligne par ligne (10 min)
# -----------------------------------------------------------------------------
ex4() {
    # Chemin par défaut : sample.csv dans mini_projet (depuis jour5 ou solutions/)
    if [ -n "$1" ]; then
        fichier_csv="$1"
    elif [ -f "mini_projet/sample.csv" ]; then
        fichier_csv="mini_projet/sample.csv"
    elif [ -f "../mini_projet/sample.csv" ]; then
        fichier_csv="../mini_projet/sample.csv"
    else
        fichier_csv="mini_projet/sample.csv"
    fi
    
    if [ ! -f "$fichier_csv" ]; then
        echo "Erreur : fichier $fichier_csv introuvable."
        exit 1
    fi
    
    num_ligne=0
    while IFS=',' read -r nom prenom age ville; do
        num_ligne=$((num_ligne + 1))
        # Ignorer l'en-tête (première ligne)
        if [ $num_ligne -eq 1 ]; then
            continue
        fi
        # Ignorer les lignes vides
        [ -z "$nom" ] && continue
        echo "Personne $((num_ligne - 1)) : $nom $prenom, $age ans, $ville"
    done < "$fichier_csv"
}

# -----------------------------------------------------------------------------
# Exercice 5 — Tableau des jours de la semaine (5 min)
# -----------------------------------------------------------------------------
ex5() {
    jours=(lundi mardi mercredi jeudi vendredi samedi dimanche)
    
    for i in "${!jours[@]}"; do
        echo "[$i] ${jours[$i]}"
    done
}

# -----------------------------------------------------------------------------
# Exercice 6 — Table de multiplication (10 min)
# -----------------------------------------------------------------------------
ex6() {
    nombre="${1:-0}"
    
    # Vérifier qu'un argument a été fourni et qu'il est numérique
    if [ -z "$nombre" ] || ! [[ "$nombre" =~ ^[0-9]+$ ]]; then
        echo "Usage : $0 <nombre>"
        echo "Exemple : $0 7"
        exit 1
    fi
    
    echo "Table de multiplication de $nombre :"
    for i in {1..10}; do
        resultat=$((nombre * i))
        echo "$nombre x $i = $resultat"
    done
}

# -----------------------------------------------------------------------------
# Menu pour exécuter les exercices
# -----------------------------------------------------------------------------
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    case "${1:-}" in
        1) ex1 ;;
        2) ex2 "$2" ;;
        3) ex3 ;;
        4) ex4 "$2" ;;
        5) ex5 ;;
        6) ex6 "$2" ;;
        *)
            echo "Usage : $0 <1-6> [argument supplémentaire]"
            echo "  1 : Nombres 1 à 20"
            echo "  2 : Renommer .txt en .bak (argument : dossier)"
            echo "  3 : Mot de passe"
            echo "  4 : Lire CSV (argument : chemin du fichier)"
            echo "  5 : Jours de la semaine"
            echo "  6 : Table de multiplication (argument : nombre)"
            ;;
    esac
fi
