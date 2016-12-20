#!/usr/bin/env bash

###################################################################################

#DISCLAIMER: THIS SCRIPT IS FOR MY PERSONAL USE ONLY I WILL NOT TAKE RESPONSIBILITY
#FOR BROKEN SYSTEMS/ LOST CONFIGURATION0S

###################################################################################

USER=$(getent passwd $SUDO_USER | cut -d: -f6)


function help {
	printf "
	Usage: setup.sh [OPTION]
	
  	-h, --help		prints this
  	-i, --install		installs files
	-r, --remove		uninstalls files
"
}

function install {
	
	printf "
started install..\n"
	
	# making directories
	if ! [ -d "$USER/.config/" ]; then
		mkdir -v $USER/.config
	fi

	if ! [ -d "/etc/X11/xorg.conf.d/" ]; then
		mkdir -v /etc/X11/xorg.conf.d/
	fi

	# replacing ~/.config/i3 with i3/
	cp -rv --remove-destination i3/ $USER/.config/i3
	
	# replacing ~/.bashrc with .bashrc and backing up old .bashrc
	cp -v --remove-destination $USER/.bashrc $USER/.bashrc.old
	cp -v --remove-destination .bashrc $USER/.bashrc
	
	# replacing ~/.config/dmenu-extended/config/dmenuExtended_preferences.txt with dmenuExtended_preferences.txt
	if ! cp -v --remove-destination dmenuExtended_preferences.txt $USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt; then
	printf "\e[31mError:\e[39m dmenuExtended probrably not installed.\n"
	fi
	
	# copying systemd/* to /etc/systemd/system/ and enabling pac-repos.timer and reflector.timer
	cp -v --remove-destination systemd/* /etc/systemd/system/
	systemctl enable pac-repos.timer
	systemctl enable reflector.timer

	# copying scripts/lol.sh to /usr/local/bin/lol
	cp -v --remove-destination scripts/lol.sh /usr/local/bin/lol

	# copying scripts/updates.sh to /usr/lib/i3blocks/updates
	if ! cp -v --remove-destination scripts/updates.sh /usr/lib/i3blocks/updates; then
	printf "\e[31mError:\e[39m i3blocks probrably not installed.\n"
	fi

	# copying X11/* to /etc/X11/xorg.conf.d/
	cp  -v --remove-destination X11/* /etc/X11/xorg.conf.d/

	printf "finished install!\n
"
}

function remove {
	
	printf "
started remove..\n"
	
	# removing ~/.config/i3
	rm -v $USER/.config/i3/ -rf
	
	# restoring original .bashrc
	mv -v $USER/.bashrc.old $USER/.bashrc
	
	# removing ~/.config/dmenu-extended/config/dmenuExtended_preferences.txt
	rm -v $USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt

	# removing /etc/systemd/system/pac-repos.timer and /etc/systemd/system/reflector.timer and disabling them
	
	systemctl disable pac-repos.timer
	systemctl disable reflector.timer
	
	rm -v /etc/systemd/system/pac-repos.timer
	rm -v /etc/systemd/system/pac-repos.service
	rm -v /etc/systemd/system/reflector.timer
	rm -v /etc/systemd/system/reflector.service

	# removing /usr/local/bin/lol
	rm -v /usr/local/bin/lol

	# removing /usr/lib/i3blocks/updates
	rm -v /usr/lib/i3blocks/updates

	# removing /etc/X11/xorg.conf.d/00-keyboard.conf and /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
	rm -v /etc/X11/xorg.conf.d/00-keyboard.conf
	rm -v /etc/X11/xorg.conf.d/50-mouse-acceleration.conf

	printf "finished remove!\n
"	
}

if ! [ $(id -u) = 0 ]; then
	printf "You cannot perform this operation unless you are root.\n"
	exit
fi

case $1 in
	--help|-h )
		help
		;;
	--install|-i) 
		install
		;;
	--remove|-r)
		remove
		;;
	* )
		help
		;;
esac
