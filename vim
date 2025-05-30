#!/bin/bash

# set path
if [ -z $VIM_PATH ]; then
	VIM_PATH=/usr/bin/vim
fi

if [ -z $1 ]; then
	$VIM_PATH

else
	if [ -d $1 ]; then
		echo "Can't vim into a directory!"

	elif [ ! -f $1 ]; then
		if [ -w $(dirname $1) ]; then
			$VIM_PATH $1

		else
			sudo -E $VIM_PATH $1
		fi
	else
		if [ -w $1 ]; then
			$VIM_PATH $1

		else
			sudo -E $VIM_PATH $1
		fi
	fi
fi
