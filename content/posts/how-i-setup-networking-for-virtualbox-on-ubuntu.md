---
title: "How I setup networking for VirtualBox on Ubuntu"
description: "How I setup networking for VirtualBox on Ubuntu"
slug: how-i-setup-networking-for-virtualbox-on-ubuntu
date: 2008-08-22 23:16:00
draft: false
summary: "Just a quick note: I use VirtualBox daily at work. It provides excellent emulation for my original XP install (the one that came pre-installed on my Dell box!) while my main OS is Ubuntu. Setting up networking is not as straightforward as with VMWare, so here is what I had to do:"
---


Just a quick note: I use VirtualBox daily at work. It provides excellent
emulation for my original XP install (the one that came pre-installed on my
Dell box!) while my main OS is Ubuntu. Setting up networking is not as
straightforward as with VMWare, so here is what I had to do:

First, edit _/etc/udev/rules.d/20-names.rules_ and make sure this line exists:  

```plaintext
KERNEL="tun", NAME="net/%k"  
```

Then create this script - you will run it whenever you wish to reconfigure
your network:  

```bash
#!/bin/bash  
echo "Erasing old configuration"  
sudo route del default  
sudo ifconfig tap0 down  
sudo ifconfig eth0 down  
sudo ifconfig br0 down  
sudo brctl delbr br0  
sleep 1

echo "Creating virtual interface"  
sudo chown chris /dev/sdc1  
sudo tunctl -t tap0 -u chris  
sleep 1  
echo "Creating bridge interface"  
sudo brctl addbr br0  
sleep 1  
echo "Making physical interface promiscuous"  
sudo ifconfig eth0 0.0.0.0 promisc  
sleep 1  
echo "Binding bridge to physical interface"  
sudo brctl addif br0 eth0  
sleep 1  
#sudo ifconfig br0 10.255.203.34 netmask 255.255.255.0  
echo "Configuring IP address"  
sudo ifconfig br0 198.206.186.210 netmask 255.255.255.0  
# sudo dhclient br0 # The new way!  
sleep 1  
echo "Binding bridge to virtual interface"  
sudo brctl addif br0 tap0  
sleep 1  
echo "Enabling virtual interface"  
sudo ifconfig tap0 up  
sleep 1  
#sudo route add default gw 10.255.203.254  
echo "Adding default route"  
sudo route add default gw 198.206.186.254  
echo "All done!"  
```

What's that, then?  
We start by getting rid of any existing configuration; then I change my
virtual interface device's owner to my own user, since I am logged in as a
non-root user. Obviously you need to replace 'chris' with your own user name.
From now on, **tap0** will be the virtual interface seen by VirtualBox.  
I make sure that my real interface is in promiscuous mode, which then allows
me to bind it with a bridge interface.  
All that is left to do it configure my bridge interface so that it can take
over communicating with the rest of the world!

