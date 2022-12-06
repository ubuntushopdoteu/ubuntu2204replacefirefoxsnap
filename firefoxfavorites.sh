#!/bin/bash
snap remove --purge firefox
add-apt-repository -y ppa:mozillateam/ppa
apt-get update -y
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' |  tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
apt-get -y  install  firefox --allow-downgrades 
apt-get -y  install  gnome-shell-extension-manager
#su - "$USER" -c "`gsettings set org.gnome.shell favorite-apps "['firefox.desktop', $(gsettings get org.gnome.shell favorite-apps | sed 's/^.//') "`"
RUID=$(who | awk 'FNR == 1 {print $1}')

# Translate Real Username to Real User ID
RUSER_UID=$(id -u ${RUID})

# Set gsettings for the Real User
#sudo -u ${RUID} DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${RUSER_UID}/bus" gsettings set org.gnome.shell favorite-apps "['firefox.desktop', $(gsettings get org.gnome.shell favorite-apps | sed 's/^.//') "
