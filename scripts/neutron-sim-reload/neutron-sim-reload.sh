#!/usr/bin/env bash

# netnode neutron simulation reload
# VLAN 50 -> red tenant network
# VLAN 60 -> blue tenant network
# VLAN 70 -> green tenant network
# External network VLAN: 3


# DHCP namespace - red
ip netns exec qd-vnetred ip link set qd-vnetred-tap netns 1
ip netns del qd-vnetred
ovs-vsctl del-port br-int qd-vnetred-tap

ip netns add qd-vnetred
ovs-vsctl add-port br-int qd-vnetred-tap tag=50 -- set interface qd-vnetred-tap type=internal
ip link set qd-vnetred-tap netns qd-vnetred
ip netns exec qd-vnetred ip link set qd-vnetred-tap up
ip netns exec qd-vnetred ip link set mtu 1450 dev qd-vnetred-tap
ip netns exec qd-vnetred ip a a 192.168.0.2/24 dev qd-vnetred-tap
ip netns exec qd-vnetred dnsmasq -C ./vnetred-dhcp.conf


# DHCP namespace - blue
ip netns exec qd-vnetblue ip link set qd-vnetblue-tap netns 1
ip netns del qd-vnetblue
ovs-vsctl del-port br-int qd-vnetblue-tap

ip netns add qd-vnetblue
ovs-vsctl add-port br-int qd-vnetblue-tap tag=60 -- set interface qd-vnetblue-tap type=internal
ip link set qd-vnetblue-tap netns qd-vnetblue
ip netns exec qd-vnetblue ip link set qd-vnetblue-tap up
ip netns exec qd-vnetblue ip link set mtu 1450 dev qd-vnetblue-tap
ip netns exec qd-vnetblue ip a a 192.168.1.2/24 dev qd-vnetblue-tap
ip netns exec qd-vnetblue dnsmasq -C ./vnetblue-dhcp.conf


# DHCP namespace - green
ip netns exec qd-vnetgrn ip link set qd-vnetgrn-tap netns 1
ip netns del qd-vnetgrn
ovs-vsctl del-port br-int qd-vnetgrn-tap

ip netns add qd-vnetgrn
ovs-vsctl add-port br-int qd-vnetgrn-tap tag=70 -- set interface qd-vnetgrn-tap type=internal
ip link set qd-vnetgrn-tap netns qd-vnetgrn
ip netns exec qd-vnetgrn ip link set qd-vnetgrn-tap up
ip netns exec qd-vnetgrn ip link set mtu 1450 dev qd-vnetgrn-tap
ip netns exec qd-vnetgrn ip a a 192.168.2.2/24 dev qd-vnetgrn-tap
ip netns exec qd-vnetgrn dnsmasq -C ./vnetgreen-dhcp.conf


# Router namespace addressing
GW_ADDR=192.168.96.2
EXT_ADDR=192.168.96.20
RRED_ADDR=192.168.0.1
RBLUE_ADDR=192.168.1.1
RGREEN_ADDR=192.168.2.1


# Router namespace cleanup
ip netns exec qr-vnet ip link set qr-vnetred-tap netns 1
ip netns exec qr-vnet ip link set qr-vnetblue-tap netns 1
ip netns exec qr-vnet ip link set qr-vnetgrn-tap netns 1
ip netns exec qr-vnet ip link set qg-tap netns 1
ip netns del qr-vnet
ovs-vsctl del-port br-int qr-vnetred-tap
ovs-vsctl del-port br-int qr-vnetblue-tap
ovs-vsctl del-port br-int qr-vnetgrn-tap
ovs-vsctl del-port br-int qg-tap

sleep 1
ip netns add qr-vnet


# Internal router port - red
ovs-vsctl add-port br-int qr-vnetred-tap tag=50 -- set interface qr-vnetred-tap type=internal
ip link set qr-vnetred-tap netns qr-vnet
ip netns exec qr-vnet ip link set qr-vnetred-tap up
ip netns exec qr-vnet ip link set mtu 1450 dev qr-vnetred-tap
ip netns exec qr-vnet ip a a $RRED_ADDR/24 dev qr-vnetred-tap

# Internal router port - blue
ovs-vsctl add-port br-int qr-vnetblue-tap tag=60 -- set interface qr-vnetblue-tap type=internal
ip link set qr-vnetblue-tap netns qr-vnet
ip netns exec qr-vnet ip link set qr-vnetblue-tap up
ip netns exec qr-vnet ip link set mtu 1450 dev qr-vnetblue-tap
ip netns exec qr-vnet ip a a $RBLUE_ADDR/24 dev qr-vnetblue-tap

# Internal router port - green
ovs-vsctl add-port br-int qr-vnetgrn-tap tag=70 -- set interface qr-vnetgrn-tap type=internal
ip link set qr-vnetgrn-tap netns qr-vnet
ip netns exec qr-vnet ip link set qr-vnetgrn-tap up
ip netns exec qr-vnet ip link set mtu 1450 dev qr-vnetgrn-tap
ip netns exec qr-vnet ip a a $RGREEN_ADDR/24 dev qr-vnetgrn-tap


# External router port
ovs-vsctl add-port br-int qg-tap tag=3 -- set interface qg-tap type=internal
ip link set qg-tap netns qr-vnet
ip netns exec qr-vnet ip link set qg-tap up
ip netns exec qr-vnet ip link set mtu 1450 dev qg-tap
ip netns exec qr-vnet ip a a $EXT_ADDR/24 dev qg-tap
ip netns exec qr-vnet ip r a default via $GW_ADDR

# Routing and SNAT
ip netns exec qr-vnet bash -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'
ip netns exec qr-vnet iptables -t nat -F
ip netns exec qr-vnet iptables -t nat -A POSTROUTING -o qg-tap -j SNAT --to-source $EXT_ADDR