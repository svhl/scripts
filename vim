#!/bin/bash

# set path
if [ -z $VIM_PATH ]; then
	VIM_PATH=/usr/bin/vim
fi

if [ -z $1 ]; then
	$VIM_PATH

elif [ -d "$1" ]; then
	echo "Can't vim into a directory!"

else
	if [ ! -f "$1" ]; then
		if [ "$1" == "${1%/*}" ]; then
			if [ -w $PWD ];then
				$VIM_PATH "${1}"

			else
				sudo -E $VIM_PATH "${1}"
			fi
		fi
	
	else
		if [ -w "$1" ]; then
			$VIM_PATH "$1"

		else
			sudo -E $VIM_PATH "$1"
		fi
	fi
fi
