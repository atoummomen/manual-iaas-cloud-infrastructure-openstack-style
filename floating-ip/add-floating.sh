#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# add-floating.sh
#
# Adds a Floating IP to a VM by configuring NAT rules inside the router
# namespace.
#
# Parameters:
#   $1 - VM private IP address
#   $2 - Floating (external) IP address
#   $3 - Router namespace (e.g., qr-vnet)
#   $4 - External router interface (e.g., qg-tap)
#
# Example:
# ./add-floating.sh "192.168.0.223" "192.168.96.21" "qr-vnet" "qg-tap"
# -----------------------------------------------------------------------------

VM_ADDR=$1
FLOATING_ADDR=$2
NET_NS=$3
QG_INT=$4

# Assign Floating IP to external interface
ip netns exec $NET_NS ip addr add $FLOATING_ADDR/24 dev $QG_INT

# SNAT: VM → Floating IP
ip netns exec $NET_NS iptables -t nat -I POSTROUTING 1 \
  -o $QG_INT -s $VM_ADDR/32 \
  -j SNAT --to-source $FLOATING_ADDR

# DNAT: Floating IP → VM
ip netns exec $NET_NS iptables -t nat -A PREROUTING \
  -i $QG_INT -d $FLOATING_ADDR/32 \
  -j DNAT --to-destination $VM_ADDR