#!/bin/bash
# =============================================================================
# Solutions des exercices - Jour 3 : Variables et arguments
# =============================================================================
# Ce fichier contient les solutions de tous les exercices du jour 3.
# Chaque solution est commentée et peut être exécutée séparément.
# Pour tester une solution, décommentez le bloc correspondant et exécutez.
# =============================================================================

# =============================================================================
# EXERCICE 1 : Script salut.sh - Salutation avec argument
# =============================================================================
# Usage : ./salut.sh [nom]
# Affiche "Bonjour, [nom] !" ou un message d'erreur si aucun argument.

ex1_salut() {
    if [ $# -eq 0 ]; then
        echo "Erreur : veuillez fournir un nom en argument."
        exit 1
    fi
    echo "Bonjour, $1 !"
}

# Décommentez pour tester :
# ex1_salut "$@"

# =============================================================================
# EXERCICE 2 : Liste des arguments
# =============================================================================
# Usage : ./liste_args.sh [arg1] [arg2] ...
# Affiche le nombre d'arguments et les liste tous avec une boucle.

ex2_liste_args() {
    echo "Nombre d'arguments : $#"
    echo
    i=1
    for arg in "$@"; do
        echo "Argument $i : $arg"
        ((i++))
    done
}

# Décommentez pour tester :
# ex2_liste_args "$@"

# =============================================================================
# EXERCICE 3 : Interaction avec read - Prénom et âge
# =============================================================================
# Demande le prénom et l'âge via read -p, affiche un message personnalisé.

ex3_profil() {
    read -p "Entrez votre prénom : " prenom
    read -p "Entrez votre âge : " age
    echo "Bonjour $prenom, vous avez $age ans. Bienvenue !"
}

# Décommentez pour tester :
# ex3_profil

# =============================================================================
# EXERCICE 4 : Calculatrice simple
# =============================================================================
# Usage : ./calculatrice.sh nombre1 opérateur nombre2
# Opérateurs : +, -, *, /, %

ex4_calculatrice() {
    if [ $# -ne 3 ]; then
        echo "Usage : $0 nombre1 opérateur nombre2"
        exit 1
    fi

    nombre1=$1
    op=$2
    nombre2=$3
    resultat=0

    case $op in
        +)
            resultat=$((nombre1 + nombre2))
            ;;
        -)
            resultat=$((nombre1 - nombre2))
            ;;
        \*|"*")
            resultat=$((nombre1 * nombre2))
            ;;
        /)
            resultat=$((nombre1 / nombre2))
            ;;
        %)
            resultat=$((nombre1 % nombre2))
            ;;
        *)
            echo "Opérateur non reconnu : $op"
            echo "Opérateurs valides : +, -, *, /, %"
            exit 1
            ;;
    esac

    echo "Résultat : $resultat"
}

# Décommentez pour tester :
# ex4_calculatrice "$@"

# =============================================================================
# EXERCICE 5 : Informations système
# =============================================================================
# Affiche date, utilisateur, répertoire courant et hostname via $(commande).

ex5_infos() {
    echo "Date et heure    : $(date)"
    echo "Utilisateur      : $(whoami)"
    echo "Répertoire       : $(pwd)"
    echo "Machine          : $(hostname)"
}

# Décommentez pour tester :
# ex5_infos

# =============================================================================
# MENU : Décommentez la ligne correspondante pour exécuter une solution
# =============================================================================

# ex1_salut "$@"
# ex2_liste_args "$@"
# ex3_profil
# ex4_calculatrice "$@"
# ex5_infos

# Par défaut, affiche l'aide
echo "Solutions Jour 3 - Décommentez l'appel de fonction souhaité dans le script."
echo "Fonctions disponibles : ex1_salut, ex2_liste_args, ex3_profil, ex4_calculatrice, ex5_infos"
