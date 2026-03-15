#!/usr/bin/env bash

# =============================================================================
# DANGER - INITIAL NETWORK BUILD REFERENCE FILE ONLY
# =============================================================================
# This file is NOT a reload script.
# This file is NOT intended to be executed directly.
#
# This file is a reference-only collection of one-time initial network creation
# commands for the nodes of the manual IaaS infrastructure.
#
# Use these commands ONLY when the node does not already have:
# - br-tun
# - patch connections between br-int and br-tun
# - VXLAN mesh interfaces
# - on netnode: br-ex and the br-ex <-> br-int patch
#
# Running these commands on an already prepared node may fail or create
# duplicate/conflicting OVS objects.
#
# Rules:
# - Copy ONLY the block that belongs to the target node
# - Use it as a one-time initial preparation step
# - Do NOT use this file as a reload script
# - Do NOT run these commands again unless the existing connections were removed
# =============================================================================



# =============================================================================
# compute1 - one-time initial network build
# Purpose:
# - create br-tun
# - connect br-tun to br-int using a patch pair
# - create VXLAN mesh links toward compute2, compute3, and netnode
# Run only once on compute1
# =============================================================================

# Create the integration bridge
# ovs-vsctl add-br br-int

# Create the tunnel bridge
# ovs-vsctl add-br br-tun

# Create patch connection between br-tun and br-int
# patch-int  = br-tun side
# patch-tun  = br-int side
# ovs-vsctl add-port br-tun patch-int -- set interface patch-int type=patch options:peer=patch-tun
# ovs-vsctl add-port br-int patch-tun -- set interface patch-tun type=patch options:peer=patch-int

# Create VXLAN tunnel from compute1 to compute2
# compute2="192.168.56.102"
# ovs-vsctl add-port br-tun vxlan12 -- set interface vxlan12 type=vxlan options:{remote_ip=$compute2,key=flow}

# Create VXLAN tunnel from compute1 to compute3
# compute3="192.168.56.103"
# ovs-vsctl add-port br-tun vxlan13 -- set interface vxlan13 type=vxlan options:{remote_ip=$compute3,key=flow}

# Create VXLAN tunnel from compute1 to netnode
# netnode="192.168.56.100"
# ovs-vsctl add-port br-tun vxlan1n -- set interface vxlan1n type=vxlan options:{remote_ip=$netnode,key=flow}



# =============================================================================
# compute2 - one-time initial network build
# Purpose:
# - create br-tun
# - connect br-tun to br-int using a patch pair
# - create VXLAN mesh links toward compute1, compute3, and netnode
# Run only once on compute2
# =============================================================================

# Create the integration bridge
# ovs-vsctl add-br br-int

# Create the tunnel bridge
# ovs-vsctl add-br br-tun

# Create patch connection between br-tun and br-int
# patch-int  = br-tun side
# patch-tun  = br-int side
# ovs-vsctl add-port br-tun patch-int -- set interface patch-int type=patch options:peer=patch-tun
# ovs-vsctl add-port br-int patch-tun -- set interface patch-tun type=patch options:peer=patch-int

# Create VXLAN tunnel from compute2 to compute1
# compute1="192.168.56.101"
# ovs-vsctl add-port br-tun vxlan21 -- set interface vxlan21 type=vxlan options:{remote_ip=$compute1,key=flow}

# Create VXLAN tunnel from compute2 to compute3
# compute3="192.168.56.103"
# ovs-vsctl add-port br-tun vxlan23 -- set interface vxlan23 type=vxlan options:{remote_ip=$compute3,key=flow}

# Create VXLAN tunnel from compute2 to netnode
# netnode="192.168.56.100"
# ovs-vsctl add-port br-tun vxlan2n -- set interface vxlan2n type=vxlan options:{remote_ip=$netnode,key=flow}



# =============================================================================
# compute3 - one-time initial network build
# Purpose:
# - create br-tun
# - connect br-tun to br-int using a patch pair
# - create VXLAN mesh links toward compute1, compute2, and netnode
# Run only once on compute3
# =============================================================================

# Create the integration bridge
# ovs-vsctl add-br br-int

# Create the tunnel bridge
# ovs-vsctl add-br br-tun

# Create patch connection between br-tun and br-int
# patch-int  = br-tun side
# patch-tun  = br-int side
# ovs-vsctl add-port br-tun patch-int -- set interface patch-int type=patch options:peer=patch-tun
# ovs-vsctl add-port br-int patch-tun -- set interface patch-tun type=patch options:peer=patch-int

# Create VXLAN tunnel from compute3 to compute1
# compute1="192.168.56.101"
# ovs-vsctl add-port br-tun vxlan31 -- set interface vxlan31 type=vxlan options:{remote_ip=$compute1,key=flow}

# Create VXLAN tunnel from compute3 to compute2
# compute2="192.168.56.102"
# ovs-vsctl add-port br-tun vxlan32 -- set interface vxlan32 type=vxlan options:{remote_ip=$compute2,key=flow}

# Create VXLAN tunnel from compute3 to netnode
# netnode="192.168.56.100"
# ovs-vsctl add-port br-tun vxlan3n -- set interface vxlan3n type=vxlan options:{remote_ip=$netnode,key=flow}



# =============================================================================
# netnode - one-time initial network build
# Purpose:
# - create br-tun
# - connect br-tun to br-int using a patch pair
# - create VXLAN mesh links toward compute1, compute2, and compute3
# - create br-ex
# - connect br-ex to br-int using a patch pair
# - attach physical external NIC to br-ex
# Run only once on netnode
# =============================================================================

# Create the integration bridge
# ovs-vsctl add-br br-int

# Create the tunnel bridge
# ovs-vsctl add-br br-tun

# Create patch connection between br-tun and br-int
# patch-int  = br-tun side
# patch-tun  = br-int side
# ovs-vsctl add-port br-tun patch-int -- set interface patch-int type=patch options:peer=patch-tun
# ovs-vsctl add-port br-int patch-tun -- set interface patch-tun type=patch options:peer=patch-int

# Create VXLAN tunnel from netnode to compute1
# compute1="192.168.56.101"
# ovs-vsctl add-port br-tun vxlann1 -- set interface vxlann1 type=vxlan options:{remote_ip=$compute1,key=flow}

# Create VXLAN tunnel from netnode to compute2
# compute2="192.168.56.102"
# ovs-vsctl add-port br-tun vxlann2 -- set interface vxlann2 type=vxlan options:{remote_ip=$compute2,key=flow}

# Create VXLAN tunnel from netnode to compute3
# compute3="192.168.56.103"
# ovs-vsctl add-port br-tun vxlann3 -- set interface vxlann3 type=vxlan options:{remote_ip=$compute3,key=flow}

# Create external bridge used to reach the outside network
# ovs-vsctl add-br br-ex

# Attach the external physical NIC to br-ex
# Use the real external interface of the netnode
# Do not use eth0 if it is only a VirtualBox NAT interface
# ovs-vsctl add-port br-ex eth2

# Create patch connection between br-ex and br-int
# phy-br-ex = br-ex side
# int-br-ex = br-int side
# ovs-vsctl add-port br-ex phy-br-ex -- set interface phy-br-ex type=patch options:peer=int-br-ex
# ovs-vsctl add-port br-int int-br-ex -- set interface int-br-ex type=patch options:peer=phy-br-ex
