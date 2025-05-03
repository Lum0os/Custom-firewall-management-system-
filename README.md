
# 🔥 Custom Firewall Management System - Shell Script Project (Advanced)

## 📌 Project Description
This is an **advanced** custom firewall management system written in **Bash**, designed to provide a full-featured interface for managing Linux `iptables` firewall rules through a command-line interactive menu. It supports real-time rule management, structured logging, statistics, chain selection (INPUT/OUTPUT/FORWARD), and secure execution.

---

## 🎯 Project Goals
- Provide a professional-grade CLI interface to `iptables`.
- Allow users to:
  - Add/Delete firewall rules (based on IP, port, protocol).
  - Choose chain (INPUT, OUTPUT, FORWARD).
  - View logs (plaintext and JSON).
  - Filter logs by IP.
  - See real-time statistics.
  - Secure access with a password prompt.
- Persist rules across reboots.
- Optional: Trigger alerts/notifications.

---

## ⚙️ Tools & Technologies Used
- Bash (Shell scripting)
- iptables (Firewall)
- logger / echo for logging
- Linux (Tested on Red Hat)
- `systemctl`, `iptables-save`, `iptables-restore`

---

## 🛠️ Implementation Steps

### 1. Environment Setup
- Ensure iptables is installed and enabled:
  ```bash
  sudo dnf install iptables-services -y
  sudo systemctl start iptables
  sudo systemctl enable iptables
  ```

### 2. Secure Script Entry
- Prompt for a password at script start.
- Exit if incorrect.

### 3. Add Rule Function
- User selects:
  - Chain (INPUT, OUTPUT, FORWARD)
  - IP Address
  - Port
  - Protocol
  - Action (ACCEPT, DROP)
- Then applies rule:
  ```bash
  sudo iptables -A <CHAIN> -s <IP> -p <protocol> --dport <port> -j <ACTION>
  ```
- Logs it in plaintext and JSON format.

### 4. Delete Rule Function
- Show numbered rules for a chain.
- User selects rule number to delete.
  ```bash
  sudo iptables -L <CHAIN> --line-numbers
  sudo iptables -D <CHAIN> <RULE_NUMBER>
  ```

### 5. View Logs
- Display `firewall.log`.
- Display `firewall.json`.
- Optional: Filter by IP.

### 6. Statistics
- Count of:
  - Rules per chain
  - Rules per action (ACCEPT, DROP)
  - Protocol usage
  - Log entries

### 7. Save/Load Rules (Persistence)
- Save current rules:
  ```bash
  sudo iptables-save > /etc/sysconfig/iptables
  ```
- Load on reboot using systemd service.

### 8. Notifications (Optional)
- On new rule:
  ```bash
  notify-send "New firewall rule added"
  # or
  echo "Rule added" | mail -s "Firewall Notification" user@example.com
  ```

### 9. Interactive Menu
- Menu options:
  - Add rule
  - Delete rule
  - View current rules
  - View logs
  - View statistics
  - Save rules
  - Exit

---

## 📈 Future Improvements
- Centralized rule repository (per user or project).
- Rule rollback.
- JSON-based config for pre-defined templates.
- Integration with fail2ban.

---

## 📎 Notes
- Make scripts executable: `chmod +x firewall.sh`
- Run as root: `sudo ./firewall.sh`
- Make sure `iptables` service is active: `sudo systemctl status iptables`

---

## 👨‍💻 Authors
- Loay 
- Mohamed abbas 

---

## 📁 Project Structure
```
firewall-project/
│
├── firewall.sh              # Main all-in-one script
├── firewall.log             # Log file (plaintext)
├── firewall.json            # Log file (JSON format)
├── saved_rules.conf         # Backup of rules for restore
└── README.md
```
