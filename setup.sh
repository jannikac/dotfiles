#!/usr/bin/env bash

# Variables
dir=~/dotfiles
olddir=~/dotfiles-old

# optional dependencies
opdep=(rofi i3 i3blocks xrandr xinit feh teamspeak3 xautolock physlock urxvt zsh upgrade_oh_my_zsh)

# source files
source[0]="i3/config"
source[1]="i3/i3blocks.conf"
source[2]="rofi"
source[3]="Xresources"
source[4]="zshrc"

#source[5]="usr/lib/i3blocks/updates"
#source[6]="etc/X11/xinit/xinitrc.d/monitorsetup.sh"
#source[7]="etc/X11/xorg.conf.d/00-keyboard.conf"
#source[8]="etc/X11/xorg.conf.d/50-mouse-acceleration.conf"

# destination files
dest[0]="~/.config/$source[1]"
dest[1]="~/.config/$source[2]"
dest[2]="~/.config/rofi/config"
dest[3]="~/.Xresources"
dest[4]="~/.zshrc"

#dest[5]="/${source[5]}"
#dest[6]="/${source[6]}"
#dest[7]="/${source[7]}"
#dest[8]="/${source[8]}"

function help {
	printf "
	Usage: setup.sh [OPTION]
	
  	-h, --help		prints this
	-i, --install		installs files (OVERWRITES EXISTING FILES)
	-r, --remove		uninstalls files
"
}

	

function install {
	
	# checks if user is running as root		
	#if ! [ $(id -u) = 0 ]; then
	#	printf "You cannot perform this operation unless you are root.\n"
	#	exit
	#fi
	
	# Move any existing dotfiles to $olddir
	prinff "Moving any existing dotfiles to $olddir\n"
	mkdir $olddir
	for i in ${dest[@]}
	do
		mv $i ~/dotifles-old
	done

	
	printf "Started install..\n"

	# symlinking files
	i=0
	while [ $i -lt ${#source[*]} ]; do
		ln -sv ${source[$i]} ${dest[$i]}
		i=$(( $i + 1 ));
	done


	printf "Finished install\n"
}

function remove {
	
	printf "\nstarted remove..\n\n"
	

	### waiting for rewrite

	printf "\nfinished remove!\n"	
}



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
	--depcheck|-d)
		dependencies
		;;
	* )
		help
		;;
esac
