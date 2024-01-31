#!/bin/bash

if [[ $(protonvpn-cli s) == "
No active Proton VPN connection." ]]; then
	kdialog --title "VPN" --yesno "VPN appears to be disconnected. Do you want to connect?" --yes-label "Connect" --no-label "Disconnect"
	
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
	kdialog --title "VPN" --yesno "VPN appears to be connected. Do you want to disconnect?" --yes-label "Disconnect" --no-label "Connect"
	
	if [ $? == 0 ]; then
		protonvpn-cli d

	else
		protonvpn-cli d
		sleep 1
		protonvpn-cli c -f
	fi
fi
