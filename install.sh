#!/bin/bash
function o1 {
ls ~/.i3 || echo "ye"
echo "Directory ~/.i3 does already exist!"


}



clear
echo "Install i3 config folder to"
echo "1. ~/.i3"
echo "2. ~/.config/i3"
echo "3. cancel"
read -p "Coice(1,2,3) " choice
case $choice in
	1 ) o1;;
	2 ) echo "test";;
	3 ) echo "Exiting..." && exit;;
	* ) echo "Please enter a valid value";;
esac


