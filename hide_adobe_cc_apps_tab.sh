#!/bin/bash

# This script will hide the "Apps" tab on the Creative Cloud Desktop app.

#Checks if the ServiceConfig.xml file exists. If it doesn't exist, create the directory and file.
if [ -e /Library/Application\ Support/Adobe/OOBE/Configs/ServiceConfig.xml ]; then
	echo "File and directory exists"

	#Change ServiceConfig.xml file from TRUE to FALSE
	sed -i.bak s/true/false/g /Library/Application\ Support/Adobe/OOBE/Configs/ServiceConfig.xml

else
	echo "File does not exist."

	#Creates Configs directory and XML file
	mkdir /Library/Application\ Support/Adobe/OOBE/Configs/
	touch /Library/Application\ Support/Adobe/OOBE/Configs/ServiceConfig.xml
	echo "<config><panel><name>AppsPanel</name><visible>false</visible></panel></config>" > /Library/Application\ Support/Adobe/OOBE/Configs/ServiceConfig.xml
fi

#Searches for Creative Cloud Process IDs and closes them
echo "Killing Creative Cloud PIDs:$(ps aux | grep 'Creative\ Cloud' | awk '{print $2}')"
kill $(ps aux | grep 'Creative\ Cloud' | awk '{print $2}')

#Searches for Adobe Desktop Service Process IDs and closes them
echo "Killing Adobe Desktop Service PIDs:$(ps aux | grep 'Adobe\ Desktop\ Service' | awk '{print $2}')"
kill $(ps aux | grep 'Adobe\ Desktop\ Service' | awk '{print $2}')

#Waits 5 seconds to give the computer time to close out the processes
sleep 5

#Reopen Creative Cloud Desktop app

echo "Reopening Creative Cloud Desktop App"

#Grabs current user
user=`ls -la /dev/console | cut -d " " -f 4`

#Has current user open Creative Cloud
sudo -u $user open -a Creative\ Cloud
#/Applications/Utilities/Adobe\ Creative\ Cloud/ACC/Creative\ Cloud.app/Contents/MacOS/Creative\ Cloud
