#!/bin/sh

official=$(pacman -Qu | wc -l)
aur=$(cower -u | wc -l)


printf "$official ($aur)"
