#!/bin/sh

###################################################################################

#DISCLAIMER: THIS SCRIPT IS FOR MY PERSONAL USE ONLY I WILL NOT TAKE RESPONSIBILITY
#FOR BROKEN SYSTEMS/ LOST CONFIGURATION0S

###################################################################################

USER=$(whoami)


function help {
	printf "
	Usage: setup.sh [OPTION]
	
  	-h, --help		prints this
  	-i, --install		installs files
	-r, --remove		uninstalls files

"
}

function install {
	
	# replacing ~/.config/i3 with i3/
	rm /home/$USER/.config/i3/ -rfv
	cp -rv i3/ /home/$USER/.config/i3
	
	# replacing ~/.bashrc with .bashrc and backing up old .bashrc
	cp -v /home/$USER/.bashrc /home/$USER/.bashrc.old
	cp -v .bashrc /home/$USER/.bashrc
	
	# replacing ~/.config/dmenu-extended/config/dmenuExtended_preferences.txt with dmenuExtended_preferences.txt
	cp -v dmenuExtended_preferences.txt /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt
	
	# copying systemd/* to /etc/systemd/system/ and enabling pac-repos.timer and reflector.timer
	cp -v systemd/* /etc/systemd/system/
	systemctl enable pac-repos.timer
	systemctl enable reflector.timer

	# copying scripts/lol.sh to /usr/local/bin/lol
	cp -v scripts/lol.sh /usr/local/bin/lol

	# copying scripts/updates.sh to /usr/lib/i3blocks/updates
	cp -v scripts/updates.sh /usr/lib/i3blocks/updates

	# copying X11/* to /etc/X11/xorg.conf.d/
	cp -v X11/* /etc/X11/xorg.conf.d/
	

}

function remove {
	
	# removing ~/.config/i3
	rm -v /home/$USER/.config/i3/ -rf
	
	# restoring original .bashrc
	mv -v /home/$USER/.bashrc.old /home/$USER/.bashrc
	
	# removing ~/.config/dmenu-extended/config/dmenuExtended_preferences.txt
	rm -v /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt

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
	sudo rm -v /etc/X11/xorg.conf.d/00-keyboard.conf
	sudo rm -v /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
	
}

if ! [ $(id -u) = 0 ]; then
	printf "Please run this script as root.\n"
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
