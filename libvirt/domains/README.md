# Libvirt Domain Definitions

This directory contains all virtual machine domain definitions used in the manual IaaS infrastructure.

Each compute node maintains its own set of VM XML definitions to reflect distributed virtualization across multiple hosts.

## Naming Convention

tcXcolor.xml       → Standard qcow2-backed VM  
tcXcolor-lv.xml    → LVM-backed VM  

Where:
- X = compute node number
- color = tenant network (red, blue, green)

## Network Attachment

All virtual machines are attached to the Open vSwitch integration bridge (`br-int`) through VLAN portgroups defined in:

libvirt/networks/br-int-net.xml

This ensures consistent tenant segmentation across compute nodes.

## Storage Backend Variants

Two storage models are supported:

- File-backed (qcow2)
- Logical Volume-backed (LVM)

This design allows comparison between ephemeral-style disks and block-level persistent storage.
