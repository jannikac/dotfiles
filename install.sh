#!/bin/bash


function o1 {
if [ -d $PATH1 ] 
then
	echo "Directory $PATH1 already exists!"
	read -p "Do you want to overwrite this directory[Yes/No]? " choice
	case $choice in
		Yes|yes|y|Y ) 
			echo "Removing $PATH1"
			rm -rf $PATH1
			echo "done"
			echo "Copying .i3/ to $PATH1"
			cp -r .i3 $PATH1
			echo "done"
			;;
		No|no|n|N ) 
			echo "Exiting.."
			;;
		* ) 
			echo "Exiting.."
			;;
	
	esac
else
	echo "Copying .i3/ to $PATH1.."
	cp -r .i3 $PATH1
	echo "done"
fi

}

function o2 {
if [ ! -d /home/$USER/.config ]
then
	echo "Creating /home/$USER/.config/.."
	mkdir /home/$USER/.config/
	echo "done"
fi
	
	
	
if [ -d $PATH2 ] 
then
	echo "Directory $PATH2 already exists!"
	read -p "Do you want to overwrite this directory[Yes/No]? " choice
	case $choice in
		Yes|yes|y|Y ) 
			echo "Removing $PATH2.."
			rm -rf $PATH2
			echo "done"
			echo "Copying .i3/ to $PATH2.."
			cp -r .i3 $PATH2
			echo "done"
			;;
		No|no|n|N ) 
			echo "Exiting.."
			;;
		* ) 
			echo "Exiting.."
			;;
	
	esac
else
	echo "Copying .i3/ to $PATH2"
	cp -r .i3 $PATH2
	echo "done"
fi

}



# Variables
USER="$(whoami)"
HOME="/home/$USER/"
PATH1="/home/$USER/.i3/"
PATH2="/home/$USER/.config/i3/"

echo "Install i3 directory to:"
echo "1. /home/$USER/.i3/"
echo "2. /home/$USER/.config/i3/"
echo "3. skip"
echo "4. cancel"
read -p "Choice[1,2,3]? " choice
case $choice in
	1 ) 
		o1
		;;
	2 ) 
		o2
		;;
	3 ) 
		echo "Skipping.."
		;;
	4 )	
		echo "Exiting.."
		exit
		;;
	* ) 
		echo "Invalid"
		;;
esac

echo "Replacing .bashrc in $HOME.."
rm -f /home/$USER/.bashrc
cp .bashrc /home/$USER/.bashrc
echo "done"
