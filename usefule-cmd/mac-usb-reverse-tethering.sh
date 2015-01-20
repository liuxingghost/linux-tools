#!/bin/sh

#################################################################################
# PC host																		#
#################################################################################

# Get the MAC-OS's IP address & Network name
pc_net=`ifconfig | awk -F":" '/^[a-z]/{str=$1}/192/{print str;exit}'`

# Get the root permission of "adb shell"
adb -d root
sleep 5

# Switch to USB Tethering mode (rndis,adb)
adb -d shell 'setprop sys.usb.config rndis,adb'
sleep 4

# Get the name of USB network device of PC side (often be "en?")
usb_net=`ifconfig | grep flags | tail -1 | cut -d":" -f 1`

# Open the IP forward function of PC side
sysctl -w net.inet.ip.forwarding=1
sysctl -w net.inet.ip.fw.enable=1
sysctl -w net.link.ether.inet.proxyall=1

# Creat a new bridge of PC side
ifconfig bridge121 destroy
ifconfig bridge121 create

# Config the IP address & network, and then add the member to this bridge
ifconfig bridge121 192.168.2.1 netmask 255.255.255.0
ifconfig bridge121 addm $usb_net
ifconfig bridge121 up

#################################################################################
# Android device																#
#################################################################################
adb -d shell 'ifconfig wlan0 down'

# Set the IP address & Netmask of device node
adb -d shell 'ifconfig rndis0 192.168.2.2 netmask 255.255.255.0'

# Set the gareway of "rndis0" device node
adb -d shell 'route add default gw 192.168.2.1 dev rndis0'

# Start the Web Server
#adb -d shell 'am start -n org.mortbay.ijetty/.IJetty'

# Open the snat & dnat
cat > /tmp/usb-tether.conf <<EOF
nat on $pc_net from 192.168.2.0/24 to any -> $pc_net
rdr pass on $pc_net inet proto {tcp,udp} from any to $pc_net port 8080 ->192.168.2.2 port 8888
EOF

pfctl -e -f /tmp/usb-tether.conf
