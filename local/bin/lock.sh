#!/usr/bin/env bash


#Take a screenshot
scrot /tmp/screen_locked.png

#Pixelate it 10x
mogrify -blur 0x8 /tmp/screen_locked.png
#mogrify -scale 10% -scale 1000% /tmp/screen_locked.png

#Lock screen displaying image
i3lock -i /tmp/screen_locked.png

#turn screen off
sleep 60; pgrep i3lock && xset dpms force off
