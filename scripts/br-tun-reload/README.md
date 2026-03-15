# br-tun Reload Scripts

This directory contains the OpenFlow reload scripts for the `br-tun` bridge.

These scripts program the VXLAN overlay behavior of the infrastructure by rebuilding the flow rules responsible for VLAN-to-VNI encapsulation, VNI-to-VLAN decapsulation, and dynamic MAC learning.

---

## Purpose

Each script performs the following operations on `br-tun`:

1. Removes existing OpenFlow rules
2. Installs a default drop rule
3. Installs VLAN → VNI mapping rules for traffic coming from `br-int`
4. Installs VNI → VLAN mapping rules for traffic arriving from VXLAN interfaces
5. Applies OpenFlow learning logic for return-path forwarding

These scripts define how tenant traffic is encapsulated and decapsulated across the VXLAN mesh.

---

## What These Scripts Do Not Do

These scripts do not:

- Create `br-tun`
- Create `br-int`
- Create patch ports
- Create VXLAN interfaces
- Configure namespaces
- Configure routing or SNAT

The bridge topology and VXLAN mesh must already exist before these scripts are executed.

---

## Execution Model

These scripts are safe to execute multiple times.

They are intended to:

- Reset OpenFlow state
- Reinstall the correct VLAN ↔ VNI mappings
- Restore overlay behavior after topology or flow changes

---

## VLAN ↔ VNI Mapping

- VLAN 50 → VNI 100 (`0x64`)
- VLAN 60 → VNI 200 (`0xC8`)
- VLAN 70 → VNI 300 (`0x12C`)

VNI assignment is controlled through:

- `set_field:<VNI>->tun_id`
- `options:key=flow` on VXLAN interfaces

---

This directory represents the programmable overlay forwarding layer of the manual IaaS cloud.
