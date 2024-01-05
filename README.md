# svhl/scripts

## How to use

Some scripts use the home directory as a reference path, so clone the repo to it.

```
cd
git clone https://github.com/svhl/scripts.git
cd scripts/
sudo chmod u+x *.sh
mv *.desktop ~/.local/share/applications/
```

Run a script by searching for it using a launcher or search, or using a custom shortcut.

## Scripts

### [suspend.sh](https://github.com/svhl/scripts/blob/main/suspend.sh) & [resume.sh](https://github.com/svhl/scripts/blob/main/resume.sh)

**Requires permission to run the modprobe commands without password, KDialog on KDE, or Zenity/YAD on GNOME.** For use with TP-Link external Wi-Fi adapters with module `rtl8xxxu` and Proton VPN CLI. Use if Wi-Fi doesn't connect after waking up from suspend or if the system doesn't wake up at all, and for reconnecting VPN after waking up. Run before & after suspend.

#### Install TP-Link driver

```
sudo apt install make gcc linux-headers-$(uname -r) build-essential
git clone https://github.com/lwfinger/rtl8188eu.git
cd rtl8188eu
make all
sudo make install
sudo modprobe -r rtl8xxxu
```

#### Install Proton VPN

Visit the [website](https://protonvpn.com/support/linux-vpn-tool/).

#### Disable built-in Wi-Fi

Avoid automatically reconnecting using the built-in Wi-Fi instead of the external adapter. Add the following lines to `/etc/network/interfaces`

```
iface wlan0 inet manual
iface wlan1 inet manual
```

#### Avoid password prompt

Allow the modprobe commands to run without password to avoid the password prompt. All the following lines to `/etc/sudoers`

```
[user]	ALL=NOPASSWD: /sbin/modprobe -r rtl8xxxu
[user]	ALL=NOPASSWD: /sbin/modprobe rtl8xxxu
```

where `[user]` is your username.

### [vpn.sh](https://github.com/svhl/scripts/blob/main/vpn.sh)

Connect & disconnect from Proton VPN.
