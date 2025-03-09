# fail2ban-report-panel

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
