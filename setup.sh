#!/bin/sh

###################################################################################

#DISCLAIMER: THIS SCRIPT IS FOR MY PERSONAL USE ONLY I WILL NOT TAKE RESPONSIBILITY
#FOR BROKEN SYSTEMS/ LOST CONFIGURATION0S

###################################################################################

arg1=$1
USER=$(whoami)


function help {
	printf "
	Usage: install.sh [OPTION]
	
  	-h, --help		prints this menu
  	-i, --install		installs files

"
}

function install {
	
	# touching temporary file to gain sudo priviliges
	sudo touch .tmp
	
	# replacing ~/.config/i3 with i3/
	printf "removing /home/$USER/.config/i3/.. "
	rm /home/$USER/.config/i3/ -rf
	printf "done\n"
	printf "copying i3/ to /home/$USER/.config/i3/.. "
	cp -r i3/ /home/$USER/.config/i3
	printf "done\n"
	
	# replacing ~/.bashrc with .bashrc
	printf "removing /home/$USER/.bashrc.. "
	rm /home/$USER/.bashrc
	printf "done\n"
	printf "copying .bashrc to /home/$USER/.bashrc.. "
	cp .bashrc /home/$USER/.bashrc
	printf "done\n"
	
	# replacing ~/.config/dmenu-extended/config/dmenuExtended_preferences.txt with dmenuExtended_preferences.txt
	printf "removing /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt.. "
	rm /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt
	printf "done\n"
	printf "copying dmenuExtended_preferences.txt to /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt.. " 
	cp dmenuExtended_preferences.txt /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt
	printf "done\n"
	
	# copying systemd/* to /etc/systemd/system/ and enabling pac-repos.timer
	printf "copying systemd/* to /etc/systemd/system/.. "
	sudo cp systemd/* /etc/systemd/system/
	printf "done\n"
	printf "enabling pac-repos.timer.. "
	sudo systemctl enable pac-repos.timer
	printf "done\n"

	# copying scripts/lol.sh to /usr/local/bin/lol
	printf "copying scripts/lol.sh to /usr/local/bin/lol.. "
	sudo cp scripts/lol.sh /usr/local/bin/lol
	printf "done\n"

	# copying scripts/updates.sh to /usr/lib/i3blocks/updates
	printf "copying scripts/updates.sh to /usr/lib/i3blocks/updates.. "
	sudo cp scripts/updates.sh /usr/lib/i3blocks/updates
	printf "done\n"

	# copying X11/* to /etc/X11/xorg.conf.d/
	printf "copying x11/* to /etc/X11/xorg.conf.d/.. "
	sudo cp X11/* /etc/X11/xorg.conf.d/
	printf "done\n"
	
	#removing temporary file
	rm .tmp -f

}

case $arg1 in
	--help|-h )
		help
		;;
	--install|-i) 
		install
		;;
	* )
		help
		;;
esac
