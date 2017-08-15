#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Custom bash prompt
PS1="\[\033[38;5;10m\]\u@\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;12m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \\$ \[$(tput sgr0)\]"

# Aliases
alias ls='ls --color=auto'
alias vim='nvim'
alias sshmount='sshfs jannik@jannik-steinbach.de:files ~/mnt/sshfs'
alias sshunmount='fusermount -u ~/mnt/sshfs'

#Keychain initialize
/usr/bin/keychain $HOME/.ssh/jannik_key
source $HOME/.keychain/$HOSTNAME-sh
