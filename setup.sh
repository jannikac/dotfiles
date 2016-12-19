#!/bin/sh

###################################################################################

#DISCLAIMER: THIS SCRIPT IS FOR MY PERSONAL USE ONLY I WILL NOT TAKE RESPONSIBILITY
#FOR BROKEN SYSTEMS/ LOST CONFIGURATION0S

###################################################################################

arg1=$1
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
	
	# touching temporary file to gain sudo priviliges
	sudo touch .tmp
	
	# replacing ~/.config/i3 with i3/
	printf "removing /home/$USER/.config/i3/.. "
	rm /home/$USER/.config/i3/ -rf
	printf "done\n"
	printf "copying i3/ to /home/$USER/.config/i3/.. "
	cp -r i3/ /home/$USER/.config/i3
	printf "done\n"
	
	# replacing ~/.bashrc with .bashrc and backing up old .bashrc
	printf "backing up /home/$USER/.bashrc.."
	cp /home/$USER/.bashrc /home/$USER/.bashrc.old
	printf "done\n"
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
	
	# copying systemd/* to /etc/systemd/system/ and enabling pac-repos.timer and reflector.timer
	printf "copying systemd/* to /etc/systemd/system/.. "
	sudo cp systemd/* /etc/systemd/system/
	printf "done\n"
	printf "enabling pac-repos.timer.. "
	sudo systemctl enable pac-repos.timer
	printf "done\n"
	printf "enabling reflector.timer.. "
	sudo systemctl enable reflector.timer
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

function remove {
	# touching temporary file to gain sudo priviliges
	sudo touch .tmp
	
	# removing ~/.config/i3
	printf "removing /home/$USER/.config/i3/.. "
	rm /home/$USER/.config/i3/ -rf
	printf "done\n"
	
	# restoring original .bashrc
	printf "restoring original .bashrc"
	mv /home/$USER/.bashrc.old /home/$USER/.bashrc
	printf "done\n"
	
	# removing ~/.config/dmenu-extended/config/dmenuExtended_preferences.txt
	printf "removing /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt.. "
	rm /home/$USER/.config/dmenu-extended/config/dmenuExtended_preferences.txt
	printf "done\n"

	# removing /etc/systemd/system/pac-repos.timer and /etc/systemd/system/reflector.timer and disabling them
	
	printf "disabling pac-repos.timer and reflector.timer"
	sudo systemctl disable pac-repos.timer
	sudo systemctl disable reflector.timer
	printf "done\n"
	
	printf "removing /etc/systemd/system/pac-repos.timer and /etc/systemd/system/reflector.timer and their service files"
	sudo rm /etc/systemd/system/pac-repos.timer
	sudo rm /etc/systemd/system/pac-repos.service
	sudo rm /etc/systemd/system/reflector.timer
	sudo rm /etc/systemd/system/reflector.service
	printf "done\n"

	# removing /usr/local/bin/lol
	printf "removing /usr/local/bin/lol.. "
	sudo rm /usr/local/bin/lol
	printf "done\n"

	# removing /usr/lib/i3blocks/updates
	printf "removing /usr/lib/i3blocks/updates.. "
	sudo rm /usr/lib/i3blocks/updates
	printf "done\n"

	# removing /etc/X11/xorg.conf.d/00-keyboard.conf and /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
	printf "removing /etc/X11/xorg.conf.d/00-keyboard.conf and /etc/X11/xorg.conf.d/50-mouse-acceleration.conf"
	sudo rm /etc/X11/xorg.conf.d/00-keyboard.conf
	sudo rm /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
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
	--remove|-r)
		remove
		;;
	* )
		help
		;;
esac
