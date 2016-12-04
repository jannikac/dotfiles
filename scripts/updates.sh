#!/bin/sh

official=$(sudo pacman -Sy | pacman -Qu | wc -l)
aur=$(cower -u | wc -l)


printf "$official ($aur)"
