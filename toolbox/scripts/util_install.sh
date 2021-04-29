#!/bin/ksh
# This will install all additional esd files and scripts for the toolbox
# Coded by Olli

#Info
DESCRIPTION="This script will install the MIB2STD Toolbox"

echo $DESCRIPTION
echo
sleep 2

# Is there any SD card inserted?
if [ -d /media/mp000/toolbox ]; then
    echo "Toolbox SD found"
    VOLUME=/media/mp000
elif [ -d /media/mp001/toolbox ]; then
    echo "Toolbox SD found"
    VOLUME=/media/mp001
elif [ -d /media/mp002/toolbox ]; then
    echo "Toolbox USB found"
    export VOLUME=/media/mp002
elif [ -d /media/mp003/toolbox ]; then
    echo "Toolbox USB found"
    export VOLUME=/media/mp003
elif [ -d /media/mp004/toolbox ]; then
    echo "Toolbox USB found"
    export VOLUME=/media/mp004
else 
    echo "No toolbox SD card found"
    exit 0
fi

# Mount system as read/write
echo "Mounting system volume read/write"
mount -t qnx6 -o remount,rw /dev/hd0t177 /
sleep 1

# Copy GreenMenu screens
echo "Installing GreenMenu screens"
cp -r $VOLUME/toolbox/esd/*.esd /tsd/etc/persistence/esd
sleep 1

# Copy scripts
echo "Installing scripts"
if [ -d /tsd/etc/persistence/esd/scripts ]; then
	cp -r $VOLUME/toolbox/scripts/*.sh /tsd/etc/persistence/esd/scripts
else
	mkdir -p /tsd/etc/persistence/esd/scripts
	cp -r $VOLUME/toolbox/scripts/*.sh /tsd/etc/persistence/esd/scripts
fi	
chmod a+rwx /tsd/etc/persistence/esd/scripts/*.sh
sleep 1

# Check for old script folder
OLD_SCRIPTS_FOLDER=/tsd/scripts

if [ -d $OLD_SCRIPTS_FOLDER ]; then
	echo "Old script folder found in /tsd/scripts. Removing it..."
	rm -r /tsd/scripts
fi
sleep 1

echo "Installation done. Please restart GreenMenu!"

exit 0