#!/bin/bash

trap ctrl_c INT

function ctrl_c() {
	echo ""
	echo "Exiting..."
	exit
}

function countdown() {
	echo "3..."
	sleep 1
	echo "2..."
	sleep 1
	echo "1..."
	sleep 1
}

function help() {
	echo "Usage"
	echo "update.sh [options]"
	echo "EX:"
	echo "update.sh -yr or update.sh --yes --restart"
	echo ""
	echo "Options:"
	echo "-h, --help: help"
	echo "-y, --yes: yes to all promts"
	echo "-r, --restart: reboot after updating"
	echo "-s, --poweroff: poweroff after updating"
	exit
}

function parseSingleLetterFlags() {

	for((i = 0; i < ${#subflag}; i++))
	do
		case ${subflag:i:1} in

			"h")
				help
			;;
			"y")
				yes=1
			;;
			"r")
				restart=1
			;;
			"p")
				shutdown=1
			;;
			*)
				echo "'$flag' not recognized"
				exit
			;;
		esac
	done
}

yes=0
restart=0
shutdown=0

#parse flags
for flag in "$@"
do
	subflag=${flag:1:100}

	case $subflag in
		"-help")
			help
		;;
		"-yes")
			yes=1
		;;
		"-restart")
			restart=1
		;;
		"-poweroff")
			shutdown=1
		;;
		*)
			parseSingleLetterFlags
		;;
	esac
done

echo "Updating system..."

if(($yes)); then
	sudo dnf update -y
else
	sudo dnf update
fi
if (($?)); then
	echo "DNF Update Failed, Aborting."
	exit
fi

echo "##############################################################################################"
echo "Updating Flatpaks..."

if(($yes)); then
	flatpak update -y
else
	flatpak update
fi
if (($?)); then
	echo "Flatpak Update Failed, Aborting."
	exit
fi

if(($restart));then
echo "##############################################################################################"
	echo "Restarting:"
	countdown && systemctl reboot
fi

if(($shutdown));then
echo "##############################################################################################"
	echo "Shutting Down:"
	countdown && systemctl poweroff
fi
