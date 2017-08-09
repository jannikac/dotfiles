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
	-i, --install		installs files (OVERWRITES EXISTING FILES)
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

	if ! [ -d "$USER/.local/bin" ]; then
		mkdir -v $USER/.local/bin
	fi

	# installing local/bin
	cp -rv --remove-destination local/bin $USER/.local/bin

	# installing i3/config and i3/i3block.conf
	cp -rv --remove-destination i3/* $USER/.config/i3/
	
	# backing up ~/-bashrc and installing ~/.bashrc
	cp -v --remove-destination $USER/.bashrc $USER/.bashrc.old
	cp -v --remove-destination .bashrc $USER/.bashrc
	
	# installing rofi config
	cp -rv rofi/config $USER/.config/

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
