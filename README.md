# Fail2ban Monitor

### ![English](https://flagcdn.com/20x15/gb.png) English



A modern, sleek terminal dashboard for monitoring Fail2ban's SSH jail status. This repository contains a Bash script that displays a comprehensive Fail2ban report, including a summary table of banned IPs, attempt counts, and detailed log entries—all styled in a clean, uniform blue theme reminiscent of high-end panels.

## Features

- **Real-Time Monitoring:** Displays current banned IPs and total bans from Fail2ban.
- **Detailed Reporting:** Shows a summary table with each IP's attempt count, first and last failed attempt dates.
- **Log Insights:** Provides additional details by listing the 5 most recent log entries for each banned IP.
- **Modern Aesthetics:** Clean blue-themed output for a professional and user-friendly terminal experience.
- **Easy Integration:** Automatically runs on login when placed in `/etc/profile.d/` for quick monitoring.

## Usage

1. Copy the script to `/root/fail2ban_status.sh`.
2. Make it executable:
   ```bash
   sudo chmod +x /root/fail2ban_status.sh
   ```
3. Edit `/root/.bashrc` and add the following line at the end:
   ```bash
   if [[ $- == *i* ]]; then
       /root/fail2ban_status.sh || echo "⚠️ Erreur lors de l'exécution du script Fail2ban."
   fi
   ```
4. Apply the changes by running:
   ```bash
   source /root/.bashrc
   ```
5. Run the script manually if needed:
   ```bash
   /root/fail2ban_status.sh
   ```

## Additional Usage Options

By adding the execution command to `/root/.bashrc`, the script will run automatically each time the root user logs in via SSH. This method ensures that the script is executed only in interactive sessions, preventing unintended execution in non-interactive environments.

If you prefer manual execution, simply run the script when needed without modifying `.bashrc`. This flexibility allows you to tailor the script's behavior to your specific needs.

  
## Result
  
```bash
----------------------------------------
FAIL2BAN REPORT - SSHD
----------------------------------------
IPs Banned: 7
Total Bans: 3382

IP Address  Attempts   First Attempt   Last Attempt
----------------------------------------
x.x.x.x     1744       Mar 9 19:24:01  Mar 13 21:54:31
x.x.x.x     359        Mar 9 00:18:55  Mar 13 21:56:27
x.x.x.x     156        Mar 9 03:32:11  Mar 13 22:01:35
x.x.x.x     141        Mar 12 16:55:51 Mar 13 21:57:31
x.x.x.x     136        Mar 9 00:40:27  Mar 13 22:00:03
x.x.x.x     60         Mar 13 12:45:24 Mar 13 21:55:01
x.x.x.x     45         Mar 9 04:03:11  Mar 13 21:59:03

Top 5 Ports and Users
----------------------------------------
Port (Attempts)      User (Attempts)
----------------------------------------
59125 9              root 8346
48703 8              admin 946
31801 8              user 225
53921 7              ubuntu 85
50463 7              test 62

Configuration Fail2ban (jail sshd)
----------------------------------------
Bantime  : 600 sec
Findtime : 600 sec
Maxretry : 5 attempts
```
  
### Troubleshooting

It is possible that if you execute `./fail2ban_status.sh` you might see the following error:

```
bash: ./fail2ban_status.sh: cannot execute: required file not found
```

If you encounter this error, don't worry. Run the following command to change the file encoding so that the script can be executed:

```
dos2unix ./fail2ban_status.sh
```

If you don't have `dos2unix` installed, you can install it with:

```
apt install dos2unix
```

<hr>  
  
### ![Français](https://flagcdn.com/20x15/fr.png) Français

Un tableau de bord moderne et épuré pour surveiller l'état du jail SSH de Fail2ban directement depuis le terminal. Ce dépôt contient un script Bash permettant d'afficher un rapport complet sur Fail2ban, incluant un tableau récapitulatif des IP bannies, le nombre de tentatives et des entrées détaillées des logs—le tout présenté avec un thème bleu uniforme, rappelant les panneaux de contrôle haut de gamme.

## Fonctionnalités

- **Surveillance en temps réel :** Affiche les IP actuellement bannies et le nombre total de bannissements par Fail2ban.
- **Rapports détaillés :** Présente un tableau récapitulatif indiquant le nombre de tentatives par IP, ainsi que les dates de la première et de la dernière tentative échouée.
- **Analyse des logs :** Fournit des détails supplémentaires en listant les 5 entrées de log les plus récentes pour chaque IP bannie.
- **Esthétique moderne :** Sortie propre et stylisée avec un thème bleu pour une expérience terminal professionnelle et agréable.
- **Intégration facile :** Peut être exécuté automatiquement à chaque connexion en le plaçant dans `/etc/profile.d/` pour un suivi instantané.

## Utilisation

1. Copiez le script dans `/root/fail2ban_status.sh`.
2. Rendez-le exécutable :
   ```bash
   sudo chmod +x /root/fail2ban_status.sh
   ```
3. Éditez `/root/.bashrc` et ajoutez la ligne suivante à la fin :
   ```bash
   if [[ $- == *i* ]]; then
       /root/fail2ban_status.sh || echo "⚠️ Erreur lors de l'exécution du script Fail2ban."
   fi
   ```
4. Appliquez les modifications en exécutant :
   ```bash
   source /root/.bashrc
   ```
5. Exécutez le script manuellement si nécessaire :
   ```bash
   /root/fail2ban_status.sh
   ```

## Options d'utilisation supplémentaires

En ajoutant la commande d’exécution à `/root/.bashrc`, le script s'exécutera automatiquement à chaque connexion de l'utilisateur root via SSH. Cette méthode garantit que le script ne s'exécute que dans des sessions interactives, évitant ainsi toute exécution involontaire dans des environnements non interactifs.

Si vous préférez une exécution manuelle, vous pouvez simplement lancer le script au besoin sans modifier `.bashrc`. Cette flexibilité vous permet d'adapter le comportement du script à vos besoins spécifiques.


## Résultat
  
```bash
----------------------------------------
FAIL2BAN REPORT - SSHD
----------------------------------------
IPs Banned: 7
Total Bans: 3382

IP Address  Attempts   First Attempt   Last Attempt
----------------------------------------
x.x.x.x     1744       Mar 9 19:24:01  Mar 13 21:54:31
x.x.x.x     359        Mar 9 00:18:55  Mar 13 21:56:27
x.x.x.x     156        Mar 9 03:32:11  Mar 13 22:01:35
x.x.x.x     141        Mar 12 16:55:51 Mar 13 21:57:31
x.x.x.x     136        Mar 9 00:40:27  Mar 13 22:00:03
x.x.x.x     60         Mar 13 12:45:24 Mar 13 21:55:01
x.x.x.x     45         Mar 9 04:03:11  Mar 13 21:59:03

Top 5 Ports and Users
----------------------------------------
Port (Attempts)      User (Attempts)
----------------------------------------
59125 9              root 8346
48703 8              admin 946
31801 8              user 225
53921 7              ubuntu 85
50463 7              test 62

Configuration Fail2ban (jail sshd)
----------------------------------------
Bantime  : 600 sec
Findtime : 600 sec
Maxretry : 5 attempts
```

### Dépannage

Il est possible que, si vous exécutez `./fail2ban_status.sh` vous rencontriez l'erreur suivante :

```
bash: ./fail2ban_status.sh: cannot execute: required file not found
```

Si vous rencontrez cette erreur, ne vous inquiétez pas. Exécutez la commande suivante pour modifier l'encodage du fichier, afin que le script puisse être exécuté :

```
dos2unix ./fail2ban_status.sh
```

Si vous n'avez pas `dos2unix` installé, vous pouvez l'installer avec :

```
apt install dos2unix
```
