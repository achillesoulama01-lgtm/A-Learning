#!/bin/bash
# =============================================================================
# Mini-projet Jour 5 — Renommeur par lot (batch_rename.sh)
# Usage : ./solution.sh <répertoire> <motif_recherche> <motif_remplacement>
# =============================================================================

# Vérification des arguments
if [ $# -lt 3 ]; then
    echo "Usage : $0 <répertoire> <motif_recherche> <motif_remplacement>"
    echo "Exemple : $0 ./documents 'old' 'new'"
    echo "  Renomme les fichiers contenant 'old' en remplaçant par 'new'"
    exit 1
fi

repertoire="$1"
motif_recherche="$2"
motif_remplacement="$3"

# Vérifier que le répertoire existe
if [ ! -d "$repertoire" ]; then
    echo "Erreur : le répertoire '$repertoire' n'existe pas ou n'est pas accessible."
    exit 1
fi

# Se placer dans le répertoire pour faciliter le glob
cd "$repertoire"

# Construire le motif de recherche : *motif* pour matcher les noms contenant le motif
# Si l'utilisateur fournit déjà un glob (ex. *.txt), on l'utilise tel quel
if [[ "$motif_recherche" == *"*"* ]] || [[ "$motif_recherche" == *"?"* ]]; then
    pattern="$motif_recherche"
else
    pattern="*${motif_recherche}*"
fi

# Compter les propositions et les renommages
total=0
renommes=0

# Parcourir les fichiers correspondant au motif (inclut les fichiers cachés)
for fichier in $pattern; do
    # Éviter le cas où aucun fichier ne correspond (le motif reste littéral)
    [ -e "$fichier" ] || [ -L "$fichier" ] || continue
    
    # Ignorer les répertoires
    [ -d "$fichier" ] && continue
    
    # Construire le nouveau nom : remplacer le motif de recherche par le remplacement
    nouveau_nom="${fichier//$motif_recherche/$motif_remplacement}"
    
    # Cas : le nom ne change pas
    if [ "$fichier" = "$nouveau_nom" ]; then
        echo "(ignoré) $fichier — nom identique"
        continue
    fi
    
    total=$((total + 1))
    
    # Cas : le fichier cible existe déjà
    if [ -e "$nouveau_nom" ]; then
        echo "ATTENTION : $nouveau_nom existe déjà. Écrasement refusé pour $fichier"
        continue
    fi
    
    # Demander confirmation
    echo -n "Renommer '$fichier' -> '$nouveau_nom' ? (o/n) "
    read -r reponse
    
    case "$reponse" in
        o|O|oui|Oui|OUI)
            mv "$fichier" "$nouveau_nom"
            echo "  -> Renommé."
            renommes=$((renommes + 1))
            ;;
        *)
            echo "  -> Ignoré."
            ;;
    esac
done

# Résumé
if [ $total -eq 0 ]; then
    echo "Aucun fichier ne correspond au motif '$pattern'."
else
    echo ""
    echo "Résumé : $renommes fichier(s) renommé(s) sur $total proposé(s)."
fi
