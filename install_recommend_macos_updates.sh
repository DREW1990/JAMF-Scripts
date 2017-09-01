#!/bin/bash

# This script will install MacOS recommended updates.

# Log file location
log_file="/Library/Logs/install_recommended_updates.log"

# Redirect output to a log file
exec >> $log_file 2>&1

echo -e "\n$(date)"
echo "Running Apple recommended updates."
sudo softwareupdate -ir --verbose

echo "$(date): Restarting computer..."
sudo shutdown -r now
