#!/bin/bash

locker="swaylock -l -c 5f5f5f --show-failed-attempts --daemonize -i '$1'"

swayidle -w \
	timeout 600 'hyprctl dispatch dpms off' \
	resume 'hyprctl dispatch dpms on' \
	timeout 620 "$locker" \
	#timeout 900 'systemctl suspend' \
	#before-sleep "$locker"
