#!/bin/bash

if [[ $(protonvpn-cli s) == "
No active Proton VPN connection." ]]; then
	if [[ $(dpkg -l | grep kdialog) != '' ]]; then
		kdialog --title "VPN" --yesno "VPN appears to be disconnected. Do you want to connect?" --yes-label "Connect" --no-label "Disconnect"

	elif [[ $(dpkg -l | grep zenity) != '' ]]; then
		zenity --question --title=VPN --text="VPN appears to be disconnected. Do you want to connect?" --ok-label "Connect" --cancel-label "Disconnect"

	elif [[ $(dpkg -l | grep yad) != '' ]]; then
		yad --image dialog-question --title VPN --button "Connect" --button "Disconnect" --text "VPN appears to be disconnected. Do you want to connect?"
	fi
	
	if [ $? == 0 ]; then
		# disconnect in case vpn not properly disconnected before
		# connected but no network activity
		protonvpn-cli d
		sleep 1
		protonvpn-cli c -f

	else
		protonvpn-cli d
	fi

else
	if [[ $(dpkg -l | grep kdialog) != '' ]]; then
		kdialog --title "VPN" --yesno "VPN appears to be connected. Do you want to disconnect?" --yes-label "Disconnect" --no-label "Connect"

	elif [[ $(dpkg -l | grep zenity) != '' ]]; then
		zenity --question --title=VPN --text="VPN appears to be connected. Do you want to disconnect?" --ok-label "Disconnect" --cancel-label "Connect"

	elif [[ $(dpkg -l | grep yad) != '' ]]; then
		yad --image dialog-question --title VPN --button "Disconnect" --button "Connect" --text "VPN appears to be connected. Do you want to disconnect?"
	fi

	if [ $? == 0 ]; then
		protonvpn-cli d

	else
		protonvpn-cli d
		sleep 1
		protonvpn-cli c -f
	fi
fi
