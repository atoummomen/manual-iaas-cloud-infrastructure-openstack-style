# Libvirt Layer

This directory contains the libvirt configuration layer for the manual OpenStack-style IaaS infrastructure.

Libvirt is used as the virtualization control interface for QEMU-based virtual machines.  
This layer defines how virtual machines are instantiated, attached to Open vSwitch bridges, and connected to storage backends.

The directory is intentionally structured to separate:

- Network definitions
- Domain (VM) definitions
- Storage configuration and documentation

This separation mirrors how production cloud environments logically isolate virtualization, networking, and storage responsibilities.

Libvirt is used strictly as a virtualization interface.  
All switching, VLAN tagging, and VXLAN encapsulation are handled externally by Open vSwitch.
