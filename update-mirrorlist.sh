if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

reflector --verbose --country 'Germany' -l 200 -p https --sort rate --save /etc/pacman.d/mirrorlist
