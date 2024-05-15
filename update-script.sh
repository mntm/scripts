#!/usr/bin/env bash

MIRRORLIST="/etc/pacman.d/mirrorlist"
LOGFILE="/var/log/update-script.log"




# Log header
echo "" >> $LOGFILE
echo "#################################################################################" >> $LOGFILE
echo -n "Update started at: " >> $LOGFILE
date >> $LOGFILE
echo "" >> $LOGFILE
echo "#################################################################################" >> $LOGFILE

# backup the current mirrorlist
echo "Backup the current mirrorlist:" >> $LOGFILE
cat $MIRRORLIST >> $LOGFILE
mv $MIRRORLIST $MIRRORLIST.bak


echo "" >> $LOGFILE

# run reflector to refresh mirrorlist
echo "Build mirrorlist with reflector" >> $LOGFILE
reflector --threads 9  --protocol https --sort rate --age 24 --fastest 10 --save $MIRRORLIST 2>&1 >> $LOGFILE

echo "" >> $LOGFILE


# run the upgrade
echo "Running pacman -Syu $*" >> $LOGFILE
pikaur -Suy $* --noconfirm --noprogressbar 2>&1 >> $LOGFILE

# enable Lenovo ideapad battery conservation mode (charges the battery up to ~60%)
#echo "Enabling Lenovo ideapad battery conservation mode (charges the battery up to ~60%)"
#echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode

echo "Updating hosts file from SteveBlack's github repo"
wget https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts -O /etc/hosts
chmod 0644 /etc/hosts

echo "" >> $LOGFILE
echo "" >> $LOGFILE
echo "" >> $LOGFILE
