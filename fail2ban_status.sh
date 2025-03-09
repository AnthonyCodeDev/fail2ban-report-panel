#!/bin/bash
# Ce script affiche un rapport complet et moderne pour la jail sshd de Fail2ban.
# Il se base sur /var/log/auth.log pour extraire les données des tentatives "Failed password".
# Adaptez le chemin LOGFILE si nécessaire.

LOGFILE="/var/log/auth.log"

# Récupérer le statut de la jail sshd via fail2ban-client
status=$(fail2ban-client status sshd 2>/dev/null)
if [ -z "$status" ]; then
    echo "⚠️  Fail2ban ou la jail 'sshd' ne semble pas être configurée."
    exit 1
fi

# Extraction des informations de base
currently=$(echo "$status" | grep "Currently banned:" | awk -F':' '{print $2}' | xargs)
total=$(echo "$status" | grep "Total banned:" | awk -F':' '{print $2}' | xargs)
banned_list=$(echo "$status" | grep "Banned IP list:" | cut -d':' -f2- | xargs)

# Création d'un fichier temporaire pour stocker les infos détaillées par IP
temp_file=$(mktemp)

# Pour chaque IP bannie, extraire les infos dans le log
for ip in $banned_list; do
    # Filtrer les lignes contenant "Failed password" pour l'IP dans le fichier de log
    lines=$(grep -E "Failed password.*$ip" "$LOGFILE")
    fail_count=$(echo "$lines" | wc -l | xargs)
    if [ "$fail_count" -gt 0 ]; then
        first_date=$(echo "$lines" | head -n 1 | awk '{print $1" "$2" "$3}')
        last_date=$(echo "$lines" | tail -n 1 | awk '{print $1" "$2" "$3}')
    else
        fail_count=0
        first_date="N/A"
        last_date="N/A"
    fi
    echo "$fail_count|$ip|$first_date|$last_date" >> "$temp_file"
done

# Trier les IP par nombre d'échecs décroissant et limiter à 10 entrées
sorted_ips=$(sort -t"|" -nr "$temp_file" | head -n 10)

# Préparation des codes couleur et style
BOLD=$(tput bold)
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 3)

# Définir un séparateur moderne
separator="────────────────────────────────────────────────────────────"

# Affichage du rapport formaté
echo ""
echo "${BLUE}${BOLD}${separator}${RESET}"
echo "${BLUE}${BOLD}               FAIL2BAN REPORT - SSHD               ${RESET}"
echo "${BLUE}${BOLD}${separator}${RESET}"
printf "${BLUE}%-25s: ${RESET}%s\n" "IPs Currently Banned" "$currently"
printf "${BLUE}%-25s: ${RESET}%s\n" "Total Bans" "$total"
echo "${BLUE}${BOLD}${separator}${RESET}"
echo ""
# En-tête du tableau en vert
printf "${GREEN}${BOLD}%-20s %-10s %-20s %-20s${RESET}\n" "IP Address" "Attempts" "First Attempt" "Last Attempt"
echo "${GREEN}${separator}${RESET}"
# Affichage de chaque ligne en bleu
while IFS="|" read -r attempts ip first_attempt last_attempt; do
    printf "${BLUE}%-20s %-10s %-20s %-20s${RESET}\n" "$ip" "$attempts" "$first_attempt" "$last_attempt"
done <<< "$sorted_ips"
echo "${BLUE}${BOLD}${separator}${RESET}"
echo ""

rm "$temp_file"
