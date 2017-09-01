#!/bin/bash

# Installs network printer and driver.

oldprintername="Old Printer"
printername="New Printer"
gui_display="New Printer"
address="lpd://ip.add.re.ss"
driver_ppd="/path/to/driver/ppd"
option_1="CNDuplex=None"
option_2="printer-is-shared=false"
option_3="PageSize=Letter"

# ========= Printer Install ========

# Check if the printer is already installed
/usr/bin/lpstat -p $oldprintername

# If installed, remove the printer
if [ $? -eq 0 ]; then
  /usr/sbin/lpadmin -x $oldprintername
fi

# Check for driver
if [ ! -f "$driver_ppd" ]; then

  # If the driver is not installed, stop the install
  echo "The correct driver is not installed."
  echo "Install the following drivers: $driver_ppd"

  exit 1
else

  #Installing the printer
  /usr/sbin/lpadmin -p "$printername" -D "$gui_display" -v "$address" -P "$driver_ppd" -o "$option_1" -o "$option_2" -o "$option_3" -E

  exit 0
fi
