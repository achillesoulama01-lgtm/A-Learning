#!/bin/bash
# ============================================
# Solution du mini-projet : Analyseur de logs
# ============================================
# Ce script analyse le fichier acces.log et affiche :
# 1. Nombre de requêtes par code HTTP
# 2. Liste des adresses IP uniques
# 3. Les 5 URLs les plus visitées
# ============================================

# Répertoire du script (pour trouver acces.log)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/acces.log"

# Vérifier que le fichier existe
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Erreur : Le fichier acces.log n'existe pas dans $SCRIPT_DIR"
    exit 1
fi

echo "============================================"
echo "   ANALYSEUR DE LOGS - Rapport"
echo "   Fichier : $LOG_FILE"
echo "============================================"
echo ""

# --------------------------------------------
# Tâche 1 : Requêtes par code HTTP
# Le code HTTP est le 9ème champ (awk '{print $9}')
# --------------------------------------------
echo "--- 1. Requêtes par code HTTP ---"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn
echo ""

# --------------------------------------------
# Tâche 2 : Adresses IP uniques
# L'IP est le 1er champ
# --------------------------------------------
echo "--- 2. Adresses IP uniques ---"
echo "Liste des IPs :"
cut -d' ' -f1 "$LOG_FILE" | sort | uniq
echo ""
echo "Nombre total d'IPs uniques :"
cut -d' ' -f1 "$LOG_FILE" | sort | uniq | wc -l
echo ""

# --------------------------------------------
# Tâche 3 : URLs les plus visitées (top 5)
# L'URL est le 7ème champ dans le format Apache
# --------------------------------------------
echo "--- 3. Top 5 des URLs les plus visitées ---"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5
echo ""

echo "============================================"
echo "   Fin du rapport"
echo "============================================"
