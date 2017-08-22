#!/usr/bin/env bash

###################################################################################

#DISCLAIMER: THIS SCRIPT IS FOR MY PERSONAL USE ONLY I WILL NOT TAKE RESPONSIBILITY
#FOR BROKEN SYSTEMS/ LOST CONFIGURATIONS

###################################################################################

# required dependencies
reqdep=(rsync printf)

# optional dependencies
opdep=(rofi i3 i3blocks xrandr xinit firefox feh teamspeak3 xautolock physlock urxvt)

# source files
source[0]=".config/i3/config"
source[1]=".config/i3/i3blocks.conf"
source[2]=".config/rofi/config"
source[3]=".zshrc"
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
	-d, --dependencies	checks for optional and required dependencies
"
}

function isPackageInstalled() {
	which $i &> /dev/null && echo $?

}

function dependencies {
	# checking required dependencies


	printf "Checking required dependencies..\n"

	for i in ${reqdep[@]}
	do
		if [ $(isPackageInstalled '$1') ]; then
			printf "$i..ok\n"
		else
			printf "$i..not found\n"
			printf "ERROR: required package \"$i\" was not found, exiting\n"
			exit
		fi
	done
	
	printf "all reqired dependencies installed!\n"

	# checking optional dependencies
	
	printf "checking optional dependencies..\n"
	
	missingPackage=false
	
	for i in ${opdep[@]}
	do
		if [ $(isPackageInstalled '$1') ]; then
			printf "$i.. ok\n"
		else
			printf "$i.. not found\n"
			missingPackage=true
		fi
	done
	
	if [ "$missingPackage" = false ]; then
			printf "all optional dependencies installed!\n"
		fi
	}

	

function install {
	
	# checks if user is running as root		
	if ! [ $(id -u) = 0 ]; then
		printf "You cannot perform this operation unless you are root.\n"
		exit
	fi
	
	dependencies	

	# informing user about not installed package

	if [ "$missingPackage" = true ]; then
		printf "one or more missing optional dependencies found.\n"
		printf "continue anyway?(N/y) "
		read input
		case $input in
			Y|y|yes )
				;;
			N|n|no )
				exit
				;;
			* )
				exit
				;;
		esac
	fi


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
