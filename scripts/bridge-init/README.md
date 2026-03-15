# Bridge Initialization Reference

This directory contains the one-time bridge and tunnel initialization reference for the manual-iaas-cloud-infrastructure-openstack-style project.

The script in this directory documents how the static network topology of each node is created before dynamic flow programming or namespace-based services are introduced.

---

## Purpose

The initialization process prepares:

- `br-int` (integration bridge)
- `br-tun` (tunnel bridge)
- Patch connection between `br-int` and `br-tun`
- Full VXLAN mesh between:
  - compute1
  - compute2
  - compute3
  - netnode

On `netnode` only, it also prepares:

- `br-ex` (external bridge)
- Patch connection between `br-ex` and `br-int`
- Physical external NIC attachment

This layer defines the static wiring of the infrastructure data plane.

---

## Execution Rules

- This is not a reload script
- It should be used only during initial infrastructure preparation
- It should be applied only on a node that does not already contain the required bridges, patch ports, and VXLAN interfaces
- Re-running the commands may create duplicate or conflicting OVS objects

---

## Scope Boundary

This layer is independent from:

- OpenFlow rule programming  
  (handled in `br-tun-reload`)

- Namespace-based DHCP and routing  
  (handled in `neutron-sim-reload`)

- SNAT and external service behavior

Its responsibility is limited to preparing the static OVS topology.

---

This directory represents the fixed underlay and bridge wiring layer of the manual IaaS cloud.
