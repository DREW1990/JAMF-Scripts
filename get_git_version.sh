#!/bin/bash
# Checks if git is installed and returns the version number.
# Only works on MacOS 10.10 and greater.

# Grabs OS X version
osx_version=$(sw_vers -productVersion | /usr/bin/cut -d . -f 2)

# If OS X version is 10.10 or greater, continue with grabbing the version of git.
# Otherwise, return 'Cannot be determined'
if [ $osx_version -ge 10 ]; then

	# Checks if X-Code Command Line Tools were installed
	check_xcode_installation=$(xcode-select -p &> /dev/null)

	# If running 'xcode-select -p' returned with 0, continue with grabbing the version of git.
	if [ $? -eq 0 ]; then

		# Get git version installed
	  git_version=$(git --version | cut -d " " -f3-)

	  echo "<result>$git_version</result>"

	else

		# If 'xcode-select -p' doesn't return 0, echo "Not Installed"
	  echo "<result>Not installed</result>"

	fi
else
	echo "<result>Cannot be determinded</result>"
fi
