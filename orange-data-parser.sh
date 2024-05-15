#!/usr/bin/env bash

curl -s http://123.orange.mg/Infoconso/ | \
	grep -m 1 "valable jusqu" | \
	grep -Po "[\d\.]+\s+(T|G|M|K|k)?o" | \
	xargs | \
	sed 's#o #o/#;s/ //g' \
	> /tmp/i3status-d-data.log
