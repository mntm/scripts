#!/usr/bin/sh

# Script that execute xboxdrv for a given gamepad.
#
# Dependency: xboxdrv

usage ()
{
    echo "$0 devinfo [config]"
    echo "devinfo :== <#event>-<vendor>-<model>"
    echo "#event  :== [0-9]+: as in /dev/input/eventX"
    echo "vendor  :== [0-9]{4}"
    echo "model   :== [0-9]{4}"
    echo "config  config file (default: /etc/default/xboxdrv)"
    exit 1
}

[ $# -ne 2 ] && usage

pid="/run/xboxdrv-$1.pid"
event=`echo $1 | cut -f 1 -d\-`
devname="/dev/input/event$event"
config=${2:-/etc/default/xboxdrv}

#/usr/bin/xboxdrv --daemon --detach --pid-file $pid -c $config --detach-kernel-driver --evdev $devname
/usr/bin/xboxdrv  --detach-kernel-driver -c $config --evdev $devname

