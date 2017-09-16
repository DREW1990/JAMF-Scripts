#!/bin/bash

# Used for conference room Macs.
# Check the bluetooth battery level on the connected Magic Keyboard 2 and Magic Trackpad 2.
# If the battery is less than 20%, send an email to the helpdesk team.

# Set helpdesk email
destination_email = 'email@email.com'

# Grab the computer's name
computer_name=`scutil --get ComputerName`

# Get bluetooth information from system_profiler
profile=$( system_profiler SPBluetoothDataType )

# ======== Keyboard Variables ========
# Get connection status of keyboard
keyboard_connection_status=$( awk -F: ' /Magic Keyboard/{x = NR + 3} NR == x {print $2}' <<< "$profile" )

# Get the battery percentage of the Magic Keyboard
keyboard_battery_level=$( awk -F: ' /Magic Keyboard/{x = NR + 5} NR == x {print substr($2, 1, length($2)-1)}' <<< "$profile" )

# ========= Trackpad Variables ========
# Get connection status of trackpad
trackpad_connection_status=$( awk -F: ' /Magic Trackpad 2/{x = NR + 3} NR == x {print $2}' <<< "$profile" )

# Get the battery percentage of the Magic Trackpad 2
trackpad_battery_level=$( awk -F: ' /Magic Trackpad 2/{x = NR + 5} NR == x {print substr($2, 1, length($2)-1)}' <<< "$profile" )

# ======== Check Magic Keyboard ========
# If keyboard battery level is less than or equal to 20% or connection status is "No", submit an email to Help Desk.
if [ $keyboard_connection_status = "Yes" ] && [ $keyboard_battery_level -le 20 ]; then
  # Create temp file that will be used to send an email
  echo "Keyboard battery is low. Sending email notification."

  echo "Subject: Magic Keyboard battery low on $computer_name" > /tmp/keyboard_status.log
  echo  "Please stop by the conference room and take a look." >> /tmp/keyboard_status.log
  echo  "Connection status: $keyboard_connection_status" >> /tmp/keyboard_status.log
  echo  "Battery level: $keyboard_battery_level%." >> /tmp/keyboard_status.log

  # Send email to helpdesk
  /usr/sbin/sendmail -F 'Bluetooth Notification' $destination_email < /tmp/keyboard_status.log

  # Wait 3 seconds
  sleep 3

  # Delete temp file
  rm /tmp/keyboard_status.log
else

  echo "Keyboard is at a sufficient charge or is not connected."
  echo "$computer_name connection status: $keyboard_connection_status"
  echo "$computer_name battery level: $keyboard_battery_level%"

fi

# ======== Check Trackpad Keyboard =========
# If trackpad battery level is less than or equal to 20% or connection status is "No", submit an email to Help Desk.
if [ $trackpad_connection_status = "Yes" ] && [ $trackpad_battery_level -le 20 ]; then
  # Create temp file that will be used to send an email
  echo "Trackpad battery is low. Sending email notification."

  echo "Subject: Magic Trackpad battery low on $computer_name" > /tmp/trackpad_status.log
  echo  "Please stop by the conference room and take a look." >> /tmp/trackpad_status.log
  echo  "Connection status: $trackpad_connection_status" >> /tmp/trackpad_status.log
  echo  "Battery level: $trackpad_battery_level%." >> /tmp/trackpad_status.log

  # Send email to helpdesk
  /usr/sbin/sendmail -F 'Bluetooth Notification' $destination_email < /tmp/trackpad_status.log

  # Wait 3 seconds
  sleep 3

  # Delete temp file
  rm /tmp/trackpad_status.log
else
  echo "Trackpad is at a sufficient charge or is not connected."
  echo "$computer_name connection status: $trackpad_connection_status"
  echo "$computer_name battery level: $trackpad_battery_level%"
fi
