# Neutron-Like Simulation Reload

This directory contains the Neutron-like network service simulation layer of the manual-iaas-cloud-infrastructure-openstack-style project.

No OpenStack services are installed.  
Instead, core Neutron L3 and DHCP behavior is reproduced manually using Linux namespaces, Open vSwitch internal ports, and iptables.

---

## Purpose

The files in this directory simulate:

- DHCP service per tenant network
- A router namespace
- Internal routing between tenant VLANs
- External gateway configuration
- IP forwarding
- Source NAT (SNAT)

This reproduces the behavior typically associated with:

- the Neutron DHCP agent
- the Neutron L3 agent

without relying on orchestration services.

---

## Main Reload Script

### `neutronsim-reload.sh`

This script is responsible for:

- Creating DHCP namespaces:
  - `qd-vnetred`
  - `qd-vnetblue`
  - `qd-vnetgrn`

- Creating the router namespace:
  - `qr-vnet`

- Creating internal router interfaces for:
  - VLAN 50
  - VLAN 60
  - VLAN 70

- Creating the external router interface for:
  - VLAN 3

- Assigning IP addresses
- Setting the default route
- Enabling IP forwarding
- Applying SNAT

This script is designed to be re-run to restore namespace state.

---

## DHCP Configuration Files

- `vnetred-dhcp.conf`
- `vnetblue-dhcp.conf`
- `vnetgreen-dhcp.conf`

These are `dnsmasq` configuration files used inside the DHCP namespaces.

They define:

- DHCP address range
- Default gateway
- DNS server
- Lease limits

---

## Dependencies

Before running `neutronsim-reload.sh`, the following must already be in place:

- `br-int` must exist
- VLAN tagging must be operational
- `br-tun` and the VXLAN mesh must already be configured
- `br-tun` OpenFlow rules must already be loaded

This layer depends on:

1. `bridge-init`
2. `br-tun-reload`

---

## VLAN Layout

- VLAN 50 → `192.168.0.0/24`
- VLAN 60 → `192.168.1.0/24`
- VLAN 70 → `192.168.2.0/24`
- External VLAN 3 → `192.168.96.0/24`

---

This directory represents the manual service-plane simulation of Neutron within the IaaS infrastructure.
