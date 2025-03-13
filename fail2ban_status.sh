#!/bin/bash
# Ce script affiche un rapport Fail2ban pour la jail sshd en se basant sur /var/log/auth.log.
# Il génère aussi un tableau combiné avec les 5 ports et les 5 utilisateurs les plus sollicités
# et affiche la configuration de la jail (après combien d'essais, durée du ban, etc).
# Adaptez le chemin LOGFILE si nécessaire.

LOGFILE="/var/log/auth.log"

# Récupération du statut de la jail sshd via fail2ban-client
status=$(fail2ban-client status sshd 2>/dev/null)
if [ -z "$status" ]; then
    echo "⚠️  Fail2ban ou la jail 'sshd' ne semble pas être configurée."
    exit 1
fi

# Extraction des informations de base
currently=$(echo "$status" | grep "Currently banned:" | awk -F':' '{print $2}' | xargs)
total=$(echo "$status" | grep "Total banned:" | awk -F':' '{print $2}' | xargs)
banned_list=$(echo "$status" | grep "Banned IP list:" | cut -d':' -f2- | xargs)

# Fichier temporaire pour les détails par IP
temp_file=$(mktemp)
for ip in $banned_list; do
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

sorted_ips=$(sort -t"|" -nr "$temp_file" | head -n 10)

# Codes de formatage et séparateur simplifié
BOLD=$(tput bold)
RESET=$(tput sgr0)
YELLOW=$(tput setaf 3)
sep="----------------------------------------"

# Rapport Fail2ban
echo ""
echo "${YELLOW}${BOLD}${sep}${RESET}"
echo "${YELLOW}${BOLD}FAIL2BAN REPORT - SSHD${RESET}"
echo "${YELLOW}${BOLD}${sep}${RESET}"
printf "IPs Banned: %s\n" "$currently"
printf "Total Bans: %s\n" "$total"
echo "${YELLOW}${BOLD}${sep}${RESET}"
printf "%-15s %-10s %-15s %-15s\n" "IP Address" "Attempts" "First Attempt" "Last Attempt"
echo "$sep"
while IFS="|" read -r attempts ip first_attempt last_attempt; do
    printf "%-15s %-10s %-15s %-15s\n" "$ip" "$attempts" "$first_attempt" "$last_attempt"
done <<< "$sorted_ips"
echo "${YELLOW}${BOLD}${sep}${RESET}"
echo ""

rm "$temp_file"

# Extraction des Top 5 Ports et Users (format: "valeur tentative")
ports_file=$(mktemp)
users_file=$(mktemp)

# Pour les ports, récupérer le numéro suivant "port", compter, trier et formater
grep "Failed password" "$LOGFILE" | awk '{for(i=1;i<=NF;i++){if($i=="port"){print $(i+1)}}}' \
  | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2" "$1}' > "$ports_file"

# Pour les users, gérer "invalid user" : si le mot après "for" est "invalid", le user est le 3ème token après.
grep "Failed password" "$LOGFILE" | awk '{
  for(i=1;i<=NF;i++){
    if($i=="for"){
      if($(i+1)=="invalid"){
        print $(i+3)
      } else {
        print $(i+1)
      }
    }
  }
}' | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2" "$1}' > "$users_file"

# Affichage du tableau combiné
echo "${YELLOW}${BOLD}Top 5 Ports and Users${RESET}"
echo "${YELLOW}${BOLD}${sep}${RESET}"
printf "%-20s %-20s\n" "Port (Attempts)" "User (Attempts)"
echo "$sep"
paste "$ports_file" "$users_file" | while IFS=$'\t' read -r port_line user_line; do
    printf "%-20s %-20s\n" "$port_line" "$user_line"
done
echo ""

rm "$ports_file" "$users_file"

# Affichage de la configuration Fail2ban pour la jail sshd
config_bantime=$(fail2ban-client get sshd bantime 2>/dev/null)
config_findtime=$(fail2ban-client get sshd findtime 2>/dev/null)
config_maxretry=$(fail2ban-client get sshd maxretry 2>/dev/null)

echo "${YELLOW}${BOLD}Configuration Fail2ban (jail sshd)${RESET}"
echo "${YELLOW}${BOLD}${sep}${RESET}"
printf "Bantime  : %s sec\n" "$config_bantime"
printf "Findtime : %s sec\n" "$config_findtime"
printf "Maxretry : %s tentatives\n" "$config_maxretry"
echo "${YELLOW}${BOLD}${sep}${RESET}"
echo ""
