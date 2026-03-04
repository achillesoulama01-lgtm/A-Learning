#!/bin/bash
# ============================================
# Solutions des exercices - Jour 4 : Conditions
# ============================================

# ============================================
# EXERCICE 1 : Fichier ou dossier ?
# ============================================
ex1_fichier_ou_dossier() {
    if [ -z "$1" ]; then
        echo "Erreur : veuillez fournir un chemin en argument"
        exit 1
    fi

    if [ -f "$1" ]; then
        echo "C'est un fichier"
    elif [ -d "$1" ]; then
        echo "C'est un dossier"
    else
        echo "N'existe pas ou type inconnu"
    fi
}

# ============================================
# EXERCICE 2 : Comparer deux nombres
# ============================================
ex2_comparer() {
    if [ $# -ne 2 ]; then
        echo "Usage : $0 nombre1 nombre2"
        exit 1
    fi

    # Bonus : vérifier que ce sont des nombres
    if [[ ! "$1" =~ ^[0-9]+$ ]] || [[ ! "$2" =~ ^[0-9]+$ ]]; then
        echo "Erreur : les deux arguments doivent être des nombres entiers"
        exit 1
    fi

    if [ "$1" -gt "$2" ]; then
        echo "$1 est supérieur à $2"
    elif [ "$1" -lt "$2" ]; then
        echo "$1 est inférieur à $2"
    else
        echo "$1 est égal à $2"
    fi
}

# ============================================
# EXERCICE 3 : Vérifier si l'utilisateur est root
# ============================================
ex3_est_root() {
    if [ "$UID" -eq 0 ]; then
        echo "Vous êtes root"
    else
        echo "Vous n'êtes pas root"
    fi
}

# ============================================
# EXERCICE 4 : Script de notation (noter.sh)
# ============================================
ex4_noter() {
    if [ -z "$1" ]; then
        echo "Usage : $0 note"
        exit 1
    fi

    note="$1"

    # Bonus : vérifier que la note est entre 0 et 20
    if [[ ! "$note" =~ ^[0-9]+$ ]] || [ "$note" -lt 0 ] || [ "$note" -gt 20 ]; then
        echo "Note invalide (doit être entre 0 et 20)"
        exit 1
    fi

    if [ "$note" -ge 16 ]; then
        echo "Excellent"
    elif [ "$note" -ge 12 ]; then
        echo "Bien"
    elif [ "$note" -ge 10 ]; then
        echo "Passable"
    else
        echo "Insuffisant"
    fi
}

# ============================================
# EXERCICE 5 : Jour ouvré ou week-end ? (case)
# ============================================
ex5_jour_semaine() {
    if [ -z "$1" ]; then
        echo "Usage : $0 jour"
        exit 1
    fi

    jour=$(echo "$1" | tr '[:upper:]' '[:lower:]')  # Gestion de la casse

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
}

# ============================================
# MENU : Exécuter un exercice
# ============================================
if [ $# -eq 0 ]; then
    echo "Usage : $0 <num_exercice> [arguments...]"
    echo "  Ex: $0 1 /etc/passwd"
    echo "  Ex: $0 2 5 10"
    echo "  Ex: $0 3"
    echo "  Ex: $0 4 18"
    echo "  Ex: $0 5 lundi"
    exit 1
fi

case $1 in
    1)
        ex1_fichier_ou_dossier "$2"
        ;;
    2)
        ex2_comparer "$2" "$3"
        ;;
    3)
        ex3_est_root
        ;;
    4)
        ex4_noter "$2"
        ;;
    5)
        ex5_jour_semaine "$2"
        ;;
    *)
        echo "Exercice inconnu. Utilisez 1, 2, 3, 4 ou 5."
        exit 1
        ;;
esac
