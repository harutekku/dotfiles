#!/bin/bash

# Note: Aliases, functions and prompt
# settings should go here

# Not running interactively - do nothing
[ -z "$PS1" ] && return

[ -r ~/.bash_aliases ] && source ~/.bash_aliases

# Colors
RED="\[\e[38;5;1m\]"
WHITE="\[\e[38;5;15m\]"
AQUA="\[\e[38;5;14m\]"
YELLOW="\[\e[38;5;11m\]"
GREEN="\[\e[38;5;10m\]"
BLUE="\[\e[38;5;12m\]"
PINK="\[\e[38;5;13m\]"

# Font effects
BOLD="\[\e[1;32m\]"
RESET="\[\e[0;32m\]"

promptSymbol='$'
[ $(id -u) -eq 0 ] && promptSymbol='#'

export PS1="${RED}[${WHITE}\u ${AQUA}\W${RED}]${YELLOW}${promptSymbol} ${WHITE}"

export HISTCONTROL=ignoredups

export EDITOR=vim

shopt -s checkwinsize

function d2h {
    [ $# -ne 1 ] && echo "usage: d2h DECIMAL-NUMBER" && return
    [ ! $(grep -E '^([0-9]|[1-9]\d*)$' <<< "$1") ] && echo "error: invalid argument - $1" && return 1
    echo "obase=16; $1" | bc
}

# NOTE: This is extremely primitive way to do this
function list-pkgs {
    [ ! -f /etc/os-release ] && echo -e "${RED}error${WHITE}: can't read /etc/os-release" && return 1

	source /etc/os-release

	[ ${ID} == "debian" ] && apt list 2>/dev/null | grep '\[installed\]' | cut -d',' -f1 && return 0
	
	[ ${ID} == "alpine" ] && apk list -I | cut -d' ' -f1 | sort && return 0

	[ ${ID} == "artix" ]  && pacman -Qe && return 0

	echo "${RED}error${WHITE}: unknown system (I can't be bothered)" && return 1
}

[ -r /etc/bash_completion ] && source /etc/bash_completion
