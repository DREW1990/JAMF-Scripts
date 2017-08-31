#!/bin/bash
# Checks if git is installed and returns the version number.
# Only works on MacOS 10.10 and greater.

osx_version=$(sw_vers -productVersion | /usr/bin/cut -d . -f 2)

if [ $osx_version -ge 10 ]; then

	check_xcode_installation=$(xcode-select -p &> /dev/null)

	if [ $? -eq 0 ]; then

	  git_version=$(git --version | cut -d " " -f3-)

	  echo "<result>$git_version</result>"

	else

	  echo "<result>Not installed</result>"

	fi
else
	echo "<result>Cannot be determinded</result>"
fi
