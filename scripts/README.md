# Scripts Layer

This directory contains the infrastructure control scripts used in the manual-iaas-cloud-infrastructure-openstack-style project.

These scripts implement the network behavior and control logic of a fully manual, OpenStack-style IaaS cloud infrastructure without deploying OpenStack services themselves.

All behavior is reproduced manually using:

- QEMU-based virtualization
- Open vSwitch (OVS)
- VLAN segmentation
- VXLAN overlay networking (`key=flow`)
- Linux network namespaces
- iptables-based SNAT

---

## Script Categories

The scripts in this directory are organized into the following logical groups:

1. Bridge and tunnel initialization
2. `br-tun` OpenFlow reload
3. Neutron-like namespace and routing simulation
4. DHCP configuration files

Each group is responsible for a specific infrastructure function and is separated to preserve clarity and operational control.

---

## Execution Model

This project follows a strict separation between:

- Static infrastructure wiring  
  (bridges, patch ports, VXLAN interfaces)

- Flow programming  
  (OpenFlow rules on `br-tun` and related bridges)

- Namespace-based service simulation  
  (DHCP, routing, and SNAT)

Not all scripts are intended to be executed repeatedly.

Some files are one-time infrastructure preparation references, while others are safe to re-run to restore or reload operational state.

---

## Infrastructure Scope

Nodes:
- compute1
- compute2
- compute3
- netnode

Bridges:
- `br-int`
- `br-tun`
- `br-ex` (netnode only)

Overlay design:
- Full VXLAN mesh
- `key=flow`
- VNI assigned via OpenFlow

VLAN ↔ VNI mapping:
- VLAN 50 → VNI 100 (`0x64`)
- VLAN 60 → VNI 200 (`0xC8`)
- VLAN 70 → VNI 300 (`0x12C`)

External network:
- VLAN 3

---

This directory represents the programmable control layer of the manual IaaS infrastructure.
