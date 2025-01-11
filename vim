#!/bin/bash

if [ -z $VIM_PATH ]; then
	VIM_PATH=/usr/bin/vim
fi

if [ -z $1 ]; then
	$VIM_PATH

elif [ -d $1 ]; then
	echo "Can't vim into a directory!"

else
	if [ ! -f $1 ]; then
		FILE_PATH=$1
		DESTINATION_FOLDER_PATH=${FILE_PATH%/*}
		
		if [ $FILE_PATH == $DESTINATION_FOLDER_PATH ]; then
			DESTINATION_FOLDER_PATH=$PWD
		fi
		
		if [ -w $DESTINATION_FOLDER_PATH ];then
			$VIM_PATH $FILE_PATH

		else
			sudo -E $VIM_PATH $FILE_PATH
		fi
	
	else
		if [ -w $1 ]; then
			$VIM_PATH $1

		else
			sudo -E $VIM_PATH $1
		fi
	fi
fi
