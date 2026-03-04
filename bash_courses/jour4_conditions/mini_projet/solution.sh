#!/bin/bash
# ============================================
# Mini-projet : Vérificateur de site web
# ============================================

# Vérifier qu'un argument (URL) est fourni
if [ -z "$1" ]; then
    echo "Erreur : veuillez fournir une URL en argument"
    echo "Usage : $0 <url>"
    echo "Exemple : $0 https://google.com"
    exit 1
fi

url="$1"

# Récupérer le code HTTP (curl ne suit pas les redirections par défaut)
code=$(curl -s -o /dev/null -w "%{http_code}" "$url")

# Afficher le message selon le code
case $code in
    200)
        echo "Site accessible (OK)"
        ;;
    301|302)
        echo "Redirection détectée"
        ;;
    404)
        echo "Page non trouvée (404)"
        ;;
    500)
        echo "Erreur serveur (500)"
        ;;
    *)
        echo "Code HTTP : $code"
        ;;
esac
