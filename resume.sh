#!/bin/bash

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
