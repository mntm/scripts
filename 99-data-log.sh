#!/usr/bin/env bash

# In order to use this script, NetworkManager-dispatcher.service must be enabled
# (https://wiki.archlinux.org/title/NetworkManager#Network_services_with_NetworkManager_dispatcher)
#
# This scrit launch a systemd timer which is responsible of scrapping http://123.orange.mg in
# order to determine the remaining data available for the account.
# It then write it into /tmp/i3status-d-data.log for i3status to read.


TARGET_HOST="123.orange.mg"
LOGFILE="/tmp/i3status-d-data.log"

interface=$1
status=$2

hwifs=`lshw -C network -short 2>/dev/null | grep -P network | sed "s|\ \ \ |#|g; s|###||g; s|#||g" | cut -f 2 -d\ `

function up_orange_net() {
    systemctl start orange-data.timer
}

function up_other_net () {
    systemctl stop orange-data.timer
	echo "off" > $LOGFILE
}

case $status in
    up|vpn-down)
        ping -W 1 -c 1 $TARGET_HOST 2>&1 >/dev/null
      	if [ $? != 0 ]; then up_other_net ; else up_orange_net; fi
        ;;
    down)
	[[ ${hwifs[@]} =~ $interface ]] && up_other_net && [ -a $LOGFILE ] && rm $LOGFILE || echo "Virtual interface $interface deactivated"
        ;;
esac

