#!/bin/sh

#Installs zipped app from a link

APP="ApplicationName" # Enter the .app name that needs to be installed

process="$APP"

PID="" # Clear PIDs to eliminate false positives

PID=`pgrep "$process"` # Get application PID

if [ ! -z "$PID" ] # Detect if application is running
	then
	echo "$process is running, quitting"
    # Ask application to quit
	osascript -e "tell application \"$process\" to quit"
	sleep 5
fi

# Get computers OS X version
osxVersion=$(sw_vers -productVersion | /usr/bin/cut -d . -f 2)

# Check to see if $APP.app is already installed
if [[ -d /Applications/$APP/ ]]; then

    # If app exists, delete the old version
    echo "Deleting old version of TotalPackage"
	rm -rf /Applications/$APP
		if [[ -d /Applications/$APP/ ]]; then
			echo "$APP still exists...exit script"
			exit 2
		fi
fi


# If OS X Version is 10.10.x or greater, install $APP.app
if [[ "$osxVersion" == "13" || "$osxVersion" == "12" || "$osxVersion" == "11" || "$osxVersion" == "10" ]]; then

	echo "Running $APP Install"

	# Create tmp directory
	mkdir /tmp/some_tmp_dir

	# Change directory to some_tmp_dir
	cd /tmp/some_tmp_dir

	# Download .zip file from the link and name it $APP.zip
	curl -sS enterLinkToFileHere > $APP.zip

	# Quietly unzip $APP.zip
	unzip -q $APP.zip

	# move $APP.app to the /Applications folder
	mv /tmp/some_tmp_dir/$APP.app /Applications/

	# Grab the current logged in user
	user=`ls -la /dev/console | cut -d " " -f 4`

	# Change ownership to logged in user
	chown -R $user:admin /Applications/$APP.app
	chmod 755 /Applications/$APP.app

else
	echo "Computer doesn't meet OSX requirements of 10.10.x or greater"
fi

exit 0
