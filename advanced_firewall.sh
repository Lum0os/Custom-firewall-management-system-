
#!/bin/bash

# Firewall Manager Script
# This script manages firewall rules using iptables
# It includes the following features:
# - Add and delete rules
# - View current rules
# - View logs
# - View statistics
# - Save/Load rules
# - Notifications and error handling

# Secure the script with password prompt
read -sp "Enter your password to continue: " user_password
echo
echo "Verifying user..."

# Function to check sudo access
check_sudo() {
    echo "$user_password" | sudo -S echo "Sudo access granted" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Incorrect password or no sudo access. Exiting..."
        exit 1
    fi
}

check_sudo

# Function to add a new rule
add_rule() {
    echo "Enter chain (INPUT, OUTPUT, FORWARD): "
    read chain
    echo "Enter IP address (source): "
    read ip
    echo "Enter port: "
    read port
    echo "Enter protocol (tcp/udp): "
    read protocol
    echo "Enter action (ACCEPT/DROP): "
    read action

    sudo iptables -A $chain -s $ip -p $protocol --dport $port -j $action
    if [ $? -eq 0 ]; then
        echo "Rule added successfully."
        # Log to file and send notification
        logger "New rule added: $chain - $ip - $port - $protocol - $action"
        notify-send "New firewall rule added"
    else
        echo "Error adding rule."
    fi
}

# Function to delete a rule
delete_rule() {
    echo "Enter chain (INPUT, OUTPUT, FORWARD): "
    read chain
    sudo iptables -L $chain --line-numbers
    echo "Enter rule number to delete: "
    read rule_number

    sudo iptables -D $chain $rule_number
    if [ $? -eq 0 ]; then
        echo "Rule deleted successfully."
        # Log the action
        logger "Rule deleted from $chain: $rule_number"
        notify-send "Firewall rule deleted"
    else
        echo "Error deleting rule."
    fi
}

# Function to view logs
view_logs() {
    echo "Viewing firewall logs..."
    echo "1. View logs in plaintext (firewall.log)"
    echo "2. View logs in JSON format (firewall.json)"
    echo "Enter option: "
    read option

    if [ "$option" -eq 1 ]; then
        cat /var/log/firewall.log
    elif [ "$option" -eq 2 ]; then
        cat /var/log/firewall.json
    else
        echo "Invalid option selected."
    fi
}

# Function to view statistics
view_statistics() {
    echo "Firewall Statistics:"
    sudo iptables -L -v -n
}

# Function to save rules
save_rules() {
    echo "Saving current rules..."
    sudo iptables-save > /etc/sysconfig/iptables
    echo "Rules saved."
}

# Function to load rules
load_rules() {
    echo "Loading saved rules..."
    sudo iptables-restore < /etc/sysconfig/iptables
    echo "Rules loaded."
}

# Interactive menu
while true; do
    echo "1. Add a new rule"
    echo "2. Delete an existing rule"
    echo "3. View logs"
    echo "4. View firewall statistics"
    echo "5. Save rules"
    echo "6. Load rules"
    echo "7. Exit"
    echo -n "Select an option: "
    read option

    case $option in
        1) add_rule ;;
        2) delete_rule ;;
        3) view_logs ;;
        4) view_statistics ;;
        5) save_rules ;;
        6) load_rules ;;
        7) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option, please try again." ;;
    esac
done
