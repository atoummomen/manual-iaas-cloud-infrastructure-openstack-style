#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# del-floating.sh
#
# Removes a Floating IP and associated NAT rules from the router namespace.
#
# Parameters:
#   $1 - VM private IP address
#   $2 - Floating (external) IP address
#   $3 - Router namespace (e.g., qr-vnet)
#   $4 - External router interface (e.g., qg-tap)
#
# Example:
# ./del-floating.sh "192.168.0.223" "192.168.96.21" "qr-vnet" "qg-tap"
# -----------------------------------------------------------------------------

VM_ADDR=$1
FLOATING_ADDR=$2
NET_NS=$3
QG_INT=$4

# Remove Floating IP from interface
ip netns exec $NET_NS ip addr del $FLOATING_ADDR/24 dev $QG_INT

# Remove SNAT rule
ip netns exec $NET_NS iptables -t nat -D POSTROUTING \
  -o $QG_INT -s $VM_ADDR/32 \
  -j SNAT --to-source $FLOATING_ADDR

# Remove DNAT rule
ip netns exec $NET_NS iptables -t nat -D PREROUTING \
  -i $QG_INT -d $FLOATING_ADDR/32 \
  -j DNAT --to-destination $VM_ADDR