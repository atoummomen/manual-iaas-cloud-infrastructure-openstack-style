# Architecture Overview

This directory documents the architectural design of the manual OpenStack-style IaaS infrastructure implemented in this project.

The purpose of these diagrams is to clearly illustrate how compute virtualization, software-defined networking, tenant isolation, routing, and storage integration are manually constructed using:

- Linux
- QEMU-based virtualization
- Open vSwitch (OVS)
- VXLAN overlay networking
- VLAN segmentation
- Linux network namespaces
- L3 routing and NAT
- iSCSI-based persistent storage

The architecture is intentionally layered to reflect how a real cloud infrastructure is designed and analyzed from abstraction to implementation.

## Architectural Abstraction Layers

1. High-Level Architecture  
2. Underlay Network Design  
3. Overlay Tenant Architecture  
4. Compute Node Internal Design  
5. Network Node Internal Design  
6. End-to-End IaaS Flow  

Each diagram represents a progressively deeper level of infrastructure analysis.  
They should be reviewed in numerical order to understand the transition from physical topology to full packet traversal across compute and network nodes.

This section focuses strictly on architectural clarity and infrastructure logic, without relying on automated orchestration services.
