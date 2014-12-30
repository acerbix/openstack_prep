#!/bin/sh
# 
# Openstack file copy helper - helps set up RHEL 7 for openstack
#
# Run as root
#
echo "Setting up subscription-manager..."
subscription-manager attach --pool=8a85f9864a7bffa2014a7e1e28bc39d1

echo "Installing base packages..."
yum install net-tools mlocate vim-enhanced vim-filesystem telnet psmisc bind-utils git screen ntp

echo "Installing vimrc..."
cp vimrc ~/.vimrc

echo "Copying WPA Supplicant files..."
cp wpa_supplicant /etc/sysconfig/wpa_supplicant
cp wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf

echo "Copying the route service..."
cp route.service /usr/lib/systemd/system/route.service

echo "Copying hosts..."
cp hosts /etc/hosts

echo <<EoT
File copying done. 

You should now run the following manually ON THE SYSTEM CONSOLE -

systemctl stop NetworkManager
systemctl disable NetworkManager

systemctl enable wpa_supplicant
systemctl enable route
systemctl enable network

and then reboot
EoT
