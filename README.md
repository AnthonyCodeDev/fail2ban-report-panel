# Fail2ban Monitor

:gb: English


A modern, sleek terminal dashboard for monitoring Fail2ban's SSH jail status. This repository contains a Bash script that displays a comprehensive Fail2ban report, including a summary table of banned IPs, attempt counts, and detailed log entries—all styled in a clean, uniform blue theme reminiscent of high-end panels.

## Features

- **Real-Time Monitoring:** Displays current banned IPs and total bans from Fail2ban.
- **Detailed Reporting:** Shows a summary table with each IP's attempt count, first and last failed attempt dates.
- **Log Insights:** Provides additional details by listing the 5 most recent log entries for each banned IP.
- **Modern Aesthetics:** Clean blue-themed output for a professional and user-friendly terminal experience.
- **Easy Integration:** Automatically runs on login when placed in `/etc/profile.d/` for quick monitoring.

## Usage

1. Copy the script into `/etc/profile.d/fail2ban_status.sh`.
2. Make it executable:
   ```bash
   sudo chmod +x /etc/profile.d/fail2ban_status.sh

## Additional Usage Options

For those who prefer an automatic display at every login, placing the script in `/etc/profile.d/` is recommended. However, the choice of execution is entirely flexible: you may run it manually, integrate it into another startup mechanism, or execute it in any context that best suits your workflow. This adaptability allows you to tailor the script's behavior to your specific needs.




# :fr: Français

Un tableau de bord moderne et épuré pour surveiller l'état du jail SSH de Fail2ban directement depuis le terminal. Ce dépôt contient un script Bash permettant d'afficher un rapport complet sur Fail2ban, incluant un tableau récapitulatif des IP bannies, le nombre de tentatives et des entrées détaillées des logs—le tout présenté avec un thème bleu uniforme, rappelant les panneaux de contrôle haut de gamme.

## Fonctionnalités

- **Surveillance en temps réel :** Affiche les IP actuellement bannies et le nombre total de bannissements par Fail2ban.
- **Rapports détaillés :** Présente un tableau récapitulatif indiquant le nombre de tentatives par IP, ainsi que les dates de la première et de la dernière tentative échouée.
- **Analyse des logs :** Fournit des détails supplémentaires en listant les 5 entrées de log les plus récentes pour chaque IP bannie.
- **Esthétique moderne :** Sortie propre et stylisée avec un thème bleu pour une expérience terminal professionnelle et agréable.
- **Intégration facile :** Peut être exécuté automatiquement à chaque connexion en le plaçant dans `/etc/profile.d/` pour un suivi instantané.

## Utilisation

1. Copier le script dans `/etc/profile.d/fail2ban_status.sh`.
2. Rendre le script exécutable :
   ```bash
   sudo chmod +x /etc/profile.d/fail2ban_status.sh

## Options d'utilisation supplémentaires

Pour un affichage automatique à chaque connexion, il est recommandé de placer le script dans /etc/profile.d/. Toutefois, son exécution reste totalement flexible : vous pouvez le lancer manuellement, l’intégrer à un autre mécanisme de démarrage ou l'exécuter dans n'importe quel contexte adapté à votre flux de travail. Cette souplesse vous permet d’adapter le comportement du script selon vos besoins spécifiques.
