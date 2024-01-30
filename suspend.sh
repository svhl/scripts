#!/bin/bash

# check if vpn connected
if [[ $(protonvpn-cli s) == "
No active Proton VPN connection." ]]; then
	# don't disconnect vpn
	# otherwise vpn leak through other network devices
	# after wake before executing resume script
	sed -i "4s/.*/off/" ~/scripts/config

else
	sed -i "4s/.*/on/" ~/scripts/config
fi

# check if wifi enabled
if [[ $(nmcli radio wifi) == "enabled" ]]; then
	# check if unloading module doesn't require password
	if [[ $(sudo -l | grep rtl8xxxu) != '' ]]; then
		sudo modprobe -r rtl8xxxu
	
	# else pipe password & unload module
	elif [[ $(dpkg -l | grep kdialog) != '' ]]; then
		kdialog --title "Suspend" --password "The script is attempting to perform an action that requires privileges. Authentication is required to perform this action." | sudo -S modprobe -r rtl8xxxu

	elif [[ $(dpkg -l | grep zenity) != '' ]]; then
		zenity --password --title="Suspend" | sudo -S modprobe -r rtl8xxxu
	
	elif [[ $(dpkg -l | grep yad) != '' ]]; then
		yad --center --width=300 --image=gnupg --entry --hide-text --button=gtk-ok:0 --button=gtk-cancel:1 --title="Suspend" --text="Type your password" | sudo -S modprobe -r rtl8xxxu
	fi

	nmcli radio wifi off

	# reload module
	sudo modprobe rtl8xxxu

	sed -i "2s/.*/on/" ~/scripts/config

	# otherwise wifi won't connect after wake
	sleep 1

else
	sed -i "2s/.*/off/" ~/scripts/config
fi

# go to sleep
if [[ $(dpkg -l | grep qdbus) != '' ]]; then
	qdbus org.kde.Solid.PowerManagement /org/freedesktop/PowerManagement Suspend

elif [[ $(dpkg -l | grep gnome-core) != '' ]]; then
	dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Manager.Suspend
fi

# show resume dialog on wake
if [[ $(dpkg -l | grep kdialog) != '' ]]; then
	kdialog --title "Resume" --yesno "Restore previous network state?"

elif [[ $(dpkg -l | grep zenity) != '' ]]; then
	zenity --question --title=Resume --text="Restore previous network state?"

elif [[ $(dpkg -l | grep yad) != '' ]]; then
	yad --image dialog-question --title Resume --button=gtk-yes:0 --button=gtk-no:1 --text "Restore previous network state?"
fi

if [ $? == 0 ]; then
	# check wifi status before suspend
	if [[ $(sed -n 2p ~/scripts/config) == "on" ]]; then
		nmcli radio wifi on

		# otherwise vpn connects before wifi
		sleep 1
	fi

	# check vpn status before suspend
	if [[ $(sed -n 4p ~/scripts/config) == "on" ]]; then
		# disconnect from previous session & reconnect
		protonvpn-cli d
		protonvpn-cli c -f
	fi
fi
