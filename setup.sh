#!/usr/bin/env bash

###################################################################################

#DISCLAIMER: THIS SCRIPT IS FOR MY PERSONAL USE ONLY I WILL NOT TAKE RESPONSIBILITY
#FOR BROKEN SYSTEMS/ LOST CONFIGURATION0S

###################################################################################

USER=$(getent passwd $SUDO_USER | cut -d: -f6)

# source files
source[0]=".config/i3/config"
source[1]=".config/i3/i3blocks.conf"
source[2]=".config/rofi/config"
source[3]=".bashrc"
source[4]=".Xresources"

source[5]="usr/lib/i3blocks/updates"
source[6]="etc/X11/xinit/xinitrc.d/monitorsetup.sh"
source[7]="etc/X11/xorg.conf.d/00-keyboard.conf"
source[8]="etc/X11/xorg.conf.d/50-mouse-acceleration.conf"

# destination files
dest[0]="$HOME/${source[0]}"
dest[1]="$HOME/${source[1]}"
dest[2]="$HOME/${source[2]}"
dest[3]="$HOME/${source[3]}"
dest[4]="$HOME/${source[4]}"

dest[5]="/${source[5]}"
dest[6]="/${source[6]}"
dest[7]="/${source[7]}"
dest[8]="/${source[8]}"

function help {
	printf "
	Usage: setup.sh [OPTION]
	
  	-h, --help		prints this
	-i, --install		installs files (OVERWRITES EXISTING FILES)
	-r, --remove		uninstalls files
"
}

function install {
	
	printf "\nstarted install..\n\n"
	
	
	# copies new files to destination
	i=0
	while [ $i -lt ${#source[*]} ]; do
		rsync -av --delete ${source[$i]} ${dest[$i]}
		i=$(( $i + 1 ));
	done
		


	printf "\nfinished install!\n"
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

#if ! [ $(id -u) = 0 ]; then
#	printf "You cannot perform this operation unless you are root.\n"
#	exit
#fi

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
