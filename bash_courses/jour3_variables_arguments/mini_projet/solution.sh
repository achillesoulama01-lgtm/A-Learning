#!/bin/bash
# =============================================================================
# Solution du mini-projet : Rapport système (sysinfo.sh)
# Jour 3 - Variables et arguments
# =============================================================================
# Affiche un rapport système formaté en utilisant la substitution de commandes.
# Usage : ./sysinfo.sh ou ./solution.sh
# =============================================================================

echo "========================================"
echo "       RAPPORT SYSTÈME"
echo "========================================"
echo

# --- Système d'exploitation ---
# Utilisation de /etc/os-release pour la compatibilité (Ubuntu, Debian, Fedora, etc.)
if [ -f /etc/os-release ]; then
    os_name=$(grep -E "^NAME=" /etc/os-release | cut -d'"' -f2)
    os_version=$(grep -E "^PRETTY_NAME=" /etc/os-release | cut -d'"' -f2)
else
    os_name=$(uname -s)
    os_version="N/A"
fi

echo "Système d'exploitation : $os_name"
echo "Version              : $os_version"
echo "Noyau (Kernel)       : $(uname -r)"
echo

# --- Temps de fonctionnement (uptime) ---
echo "--- Temps de fonctionnement ---"
# uptime -p donne un format lisible (up X days, Y hours) - peut ne pas exister sur tous les systèmes
if uptime -p &>/dev/null; then
    uptime_info=$(uptime -p)
else
    uptime_info=$(uptime | sed 's/.*up /up /' | cut -d',' -f1-3)
fi
echo "Uptime               : $uptime_info"
echo

# --- Mémoire ---
echo "--- Mémoire ---"
mem_total=$(free -h 2>/dev/null | awk '/^Mem:/ {print $2}')
mem_used=$(free -h 2>/dev/null | awk '/^Mem:/ {print $3}')
mem_free=$(free -h 2>/dev/null | awk '/^Mem:/ {print $4}')
echo "Mémoire totale       : ${mem_total:-N/A}"
echo "Mémoire utilisée     : ${mem_used:-N/A}"
echo "Mémoire libre        : ${mem_free:-N/A}"
echo

# --- Disque ---
echo "--- Disque ---"
# Partition racine ou répertoire courant
disk_used_pct=$(df -h / 2>/dev/null | tail -1 | awk '{print $5}')
disk_avail=$(df -h / 2>/dev/null | tail -1 | awk '{print $4}')
echo "Espace utilisé (/)   : ${disk_used_pct:-N/A}"
echo "Espace disponible    : ${disk_avail:-N/A}"
echo

# --- Utilisateur(s) connecté(s) ---
echo "--- Utilisateur(s) ---"
# who affiche les sessions, whoami affiche l'utilisateur courant
if command -v who &>/dev/null && [ -n "$(who 2>/dev/null)" ]; then
    users_info=$(who | awk '{print $1 " (" $2 ")"}' | head -5 | tr '\n' ', ' | sed 's/, $//')
else
    users_info=$(whoami)
fi
echo "Connecté(s)          : ${users_info:-$(whoami)}"
echo

echo "========================================"
echo "Rapport généré le : $(date)"
echo "========================================"
