🔥 Custom Firewall Management System - Shell Script Project

📌 Project Description

This project is a custom firewall management system implemented using a Bash shell script. It allows users to interactively manage firewall rules on a Linux system using iptables. Users can add or remove rules, view logs, and display statistics about the firewall operations — all through a simple interactive menu interface.

🎯 Project Goals

Simplify the process of managing firewall rules.

Provide a user-friendly menu-driven interface.

Allow blocking/allowing traffic based on:

IP address

Port number

Protocol (TCP/UDP)

Log every operation in a structured JSON format.

Generate basic and advanced statistics from the firewall and log data.

Enable persistent firewall rule storage.

Provide filterable log viewing.

Notify on rule changes.

⚙️ Tools & Technologies Used

Bash (Shell scripting)

iptables (Firewall)

dialog (for UI)

jq (for JSON log filtering)

systemd (for persistence)

Linux environment (Red Hat / Ubuntu)

🛠️ Implementation Steps

1. Environment Setup

Install and enable iptables:

sudo dnf install iptables -y
sudo systemctl enable iptables
sudo systemctl start iptables

Install required tools:

sudo dnf install dialog jq -y

2. Script to Add Rules (add_rule.sh)

Use dialog to prompt user for:

IP

Port

Protocol

Direction (INPUT/OUTPUT/FORWARD)

Execute iptables rule and log to firewall.log.json.

3. Script to Delete Rules (delete_rule.sh)

Show all rules with line numbers (grouped by chain).

Let user select chain and rule number to delete.

Log deletion action to firewall.log.json.

4. Logging System (log.sh)

Append structured log with timestamp, user, action, rule details:

{
  "timestamp": "2025-05-01T15:30:00Z",
  "user": "root",
  "action": "ADD",
  "chain": "INPUT",
  "rule": {
    "ip": "192.168.1.10",
    "port": 22,
    "protocol": "tcp"
  }
}

5. Display & Filter Logs (view_logs.sh)

Use jq to filter logs by IP, action, port, protocol, etc.

Allow saving filtered logs to a file.

6. Statistics Script (stats.sh)

Count rules by chain.

Count ACCEPT/DROP rules.

Count log actions by type.

Show top IPs interacted with.

7. Rule Persistence (persist.sh)

Save current rules to /etc/firewall.rules:

iptables-save > /etc/firewall.rules

On system startup, restore using:

iptables-restore < /etc/firewall.rules

Add to /etc/rc.d/rc.local or use systemd service.

8. Notification System (notify.sh)

Use logger or mail to notify about rule changes.

Example:

logger "Firewall rule added: IP 192.168.1.10 blocked on port 22"

9. Interactive Menu Interface (menu.sh)

Use dialog to create a menu:

Add rule

Delete rule

View logs

Filter logs

Show stats

Save/Restore rules

Exit

10. Final Testing

Ensure rules are correctly applied/deleted.

Validate logs, stats, persistence, and UI functionality.

📈 Future Improvements

GUI using Zenity or GTK

Remote firewall management

Auto-detection of suspicious IPs using AI

Export logs as PDF/CSV

📎 Notes

All scripts should be executable: chmod +x *.sh

Run as superuser: sudo ./menu.sh

👨‍💻 Authors

Task division and contributions mentioned in the report section.

📁 Project Structure

firewall-project/
│
├── add_rule.sh
├── delete_rule.sh
├── log.sh
├── view_logs.sh
├── stats.sh
├── persist.sh
├── notify.sh
├── menu.sh
├── firewall.log.json
├── /etc/firewall.rules
└── README.md

