#!/bin/bash

if [[ $(protonvpn-cli s) == "
No active Proton VPN connection." ]]
then
	protonvpn-cli c -f
else
	protonvpn-cli d
fi
