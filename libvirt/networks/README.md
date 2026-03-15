# Libvirt Network Definitions

This directory contains libvirt network XML definitions used to attach virtual machines to Open vSwitch bridges.

The primary network definition in this project is:

- `br-int-net.xml`

This network bridges libvirt to the Open vSwitch integration bridge (`br-int`) and enables VLAN-based tenant isolation through portgroups.

## Tenant VLAN Mapping

The following VLAN IDs are defined:

- vnet-red   → VLAN 50
- vnet-blue  → VLAN 60
- vnet-green → VLAN 70

Each portgroup corresponds to a tenant network and is referenced inside VM domain XML definitions.

Libvirt does not perform switching logic.  
It simply forwards VM interfaces to the `br-int` Open vSwitch bridge with the appropriate VLAN tagging.
