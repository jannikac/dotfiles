#!/bin/sh

aur=$(cower -u | wc -l)
official=$(checkupdates | wc -l)

printf "$official ($aur)"
