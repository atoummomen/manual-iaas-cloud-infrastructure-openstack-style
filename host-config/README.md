# Host Configuration

This directory contains the base operating system configuration for each node in the manual-iaas-cloud-infrastructure-openstack-style infrastructure.

The purpose of this layer is to establish stable host identity, deterministic underlay networking, and consistent name resolution before introducing virtualization, overlay networking, or storage integration.

Proper host-level configuration is critical because all higher-level mechanisms — including Open vSwitch bridging, VXLAN tunneling, iSCSI storage, and namespace-based routing — depend on a reliable and predictable underlay network.

---

## Infrastructure Nodes

The environment consists of four primary nodes:

- compute-1
- compute-2
- compute-3
- netnode

Each node directory contains its base operating system configuration files.

---

## Files Included Per Node

Each node folder contains:

- `hostname`  
  Defines the system hostname and node identity.

- `hosts`  
  Provides static name resolution across all infrastructure nodes.  
  Ensures deterministic communication without relying on external DNS.

- `netplan.yaml`  
  Defines the network interface configuration for the node, including:

  - Management interface (DHCP-enabled)
  - Underlay interface with static IP assignment
  - MAC-to-interface binding to ensure predictable interface naming

---

## Underlay Network Design

The static underlay network is defined as:

- compute-1 → 192.168.56.101
- compute-2 → 192.168.56.102
- compute-3 → 192.168.56.103
- netnode   → 192.168.56.100

The second interface (`eth1`) on each node is dedicated to infrastructure communication.  
This network serves as the transport layer for:

- VXLAN encapsulated overlay traffic
- East-west traffic between compute nodes
- iSCSI storage communication
- Control-plane simulation traffic

This separation ensures that overlay and virtualization traffic operate on a controlled and isolated underlay network.

---

## Design Principles

- Deterministic interface naming via MAC address matching
- Static IP assignment for predictable node-to-node communication
- Separation of management and infrastructure traffic
- Infrastructure-level name resolution via `/etc/hosts`
- No dependency on external orchestration services

This layer represents the foundational substrate of the entire IaaS environment.
