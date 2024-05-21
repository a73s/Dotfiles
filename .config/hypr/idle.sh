#!/bin/bash

locker="swaylock -l -c 5f5f5f --show-failed-attempts --daemonize -i '$1'"

swayidle -w timeout 600 'swaymsg "output * power off"' \
	resume 'swaymsg "output * power on"' \
	timeout 620 "$locker" \
	timeout 900 'systemctl suspend' \
	before-sleep "$locker"
