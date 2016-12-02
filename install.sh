#!/bin/sh

# Variables
USER="$(whoami)"
PATH1="/home/$USER/.i3/"
PATH2="/home/$USER/.config/i3/"

function o1 {
if [ -d $PATH1 ] 
then
	printf "\e[1m\e[31m:: \e[39mDirectory $PATH1 already exists!\e[0m\n"
	printf "\e[1m\e[34m:: \e[39mDo you want to overwrite this directory? [y/N] \e[0m"
	read choice
	case $choice in
		Yes|yes|y|Y ) 
			printf "Removing $PATH1.. "
			rm -rf $PATH1
			printf "done\n"
			printf "Copying .i3/ to $PATH1.. "
			cp -r i3 $PATH1
			printf "done\n"
			;;
		No|no|n|N ) 
			printf "Skipping..\n"
			;;
		* ) 
			printf "Skipping..\n"
			;;
	
	esac
else
	printf "Copying .i3/ to $PATH1.. "
	cp -r i3 $PATH1
	printf "done\n"
fi

}

function o2 {
if [ ! -d /home/$USER/.config ]
then
	printf "Creating /home/$USER/.config/.. "
	mkdir /home/$USER/.config/
	printf "done\n"
fi
	
	
	
if [ -d $PATH2 ] 
then
	printf "\e[1m\e[31m:: \e[39mDirectory $PATH2 already exists!\e[0m\n"
	printf "\e[1m\e[34m:: \e[39mDo you want to overwrite this directory? [y/N] \e[0m"
	read choice
	case $choice in
		Yes|yes|y|Y ) 
			printf "Removing $PATH2.. "
			rm -rf $PATH2
			printf "done\n"
			printf "Copying .i3/ to $PATH2.. "
			cp -r i3 $PATH2
			printf "done\n"
			;;
		No|no|n|N ) 
			printf "Skipping..\n"
			;;
		* ) 
			printf "Skipping..\n"
			;;
	
	esac
else
	printf "Copying .i3/ to $PATH2.. "
	cp -r i3 $PATH2
	printf "done\n"
fi

}

function i3Diag {
printf "\e[94m\e[1m:: \e[39mInstall i3 directory to:\e[0m\n"
printf "   1. /home/$USER/.i3/\n"
printf "   2. /home/$USER/.config/i3/\n"
printf "   3. skip\n"
printf "   4. cancel\n"
printf "\e[94m\e[1m:: \e[39mEnter a selection (1-4): \e[0m"
read choice
case $choice in
	1 ) 
		o1
		;;
	2 ) 
		o2
		;;
	3 ) 
		printf "Skipping..\n"
		;;
	4 )	
		printf "Exiting..\n"
		exit
		;;
	* ) 
		printf "Invalid\n"
		i3Diag
		;;
esac
}

function bashrc {
printf "Removing /home/$USER/.bashrc.. " 
rm -f /home/$USER/.bashrc
printf "done\n"
printf "Copying .bashrc to /home/$USER/.bashrc.. "
cp .bashrc /home/$USER/.bashrc
printf "done\n"
}

i3Diag
bashrc


