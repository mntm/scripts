#!/usr/bin/env bash

function turn_on () {
	xset s on +dpms
}

function turn_off () {
	xset s off -dpms
}

function check_screensaver () {
	xset q | grep -Po "timeout:\s+0" > /dev/null
}

function check_dpms () {
	xset q | grep -Po "DPMS is Disabled" > /dev/null
}
check_screensaver 
[ $? -eq 0 ] && xset s on ||  xset s off
check_dpms
[ $? -eq 0 ] && xset +dpms || xset -dpms
