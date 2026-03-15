# Manual IaaS Cloud Infrastructure – Project Overview

## 1. Project Purpose

This project is a full manual implementation of a cloud Infrastructure-as-a-Service (IaaS) environment built from first principles.

The objective was not to deploy OpenStack itself, but to understand and reconstruct the fundamental building blocks that make a cloud infrastructure work:

- Compute virtualization
- Overlay networking
- Software-defined switching
- Virtual routing and NAT
- Persistent block storage
- Floating IP exposure
- Live and offline migration workflows

Everything in this repository was implemented manually without orchestration frameworks in order to deeply understand the internal mechanics of cloud systems.

---

## 2. Architectural Philosophy

The project is structured in clearly separated layers to mirror real cloud provider architecture:

- **Architecture Layer** – Infrastructure design and abstraction models
- **Host Configuration Layer** – Node identity and underlay networking
- **Virtualization Layer (Libvirt/QEMU/KVM)** – VM lifecycle management
- **Overlay Networking (OVS + VXLAN)** – Tenant isolation and L2 extension
- **Control Simulation (Neutron-like namespaces)** – Routing, NAT, DHCP
- **Persistent Storage (LVM + iSCSI)** – Remote block storage backend
- **Floating IP Layer** – External reachability through NAT
- **Migration Layer** – Offline and live VM migration scenarios

This layered separation reflects real-world cloud design patterns.

---

## 3. What This Project Demonstrates

This repository demonstrates practical implementation of:

### Compute
- QEMU/KVM virtualization
- Libvirt domain management
- Multi-node distributed compute setup

### Networking
- Open vSwitch bridge architecture
- VXLAN overlay tunnels
- Patch ports and flow-based forwarding
- Namespace-based virtual routing
- iptables NAT and floating IP exposure

### Storage
- LVM logical volume management
- iSCSI target configuration
- iSCSI initiator attachment on compute nodes
- Block-device integration into libvirt VMs

### Migration
- Offline migration (ephemeral and persistent storage)
- Live migration with shared storage
- Storage copy workflows for local disks

---

## 4. Design Goals

This project was built with the following goals:

- Understand cloud internals beyond orchestration tools
- Separate control-plane logic from data-plane forwarding
- Simulate Neutron-style networking manually
- Reproduce cloud storage attachment mechanisms
- Validate live migration behaviors
- Maintain clean infrastructure layering and documentation

The focus was educational depth and architectural clarity.

---

## 5. What This Project Is Not

- It is not a production-ready cloud platform
- It is not an automated OpenStack deployment
- It does not use orchestration engines

It is a controlled, fully manual cloud infrastructure simulation designed to understand the mechanics behind modern cloud providers.

---

## 6. Key Takeaways

Through this implementation, the following concepts were deeply explored:

- Overlay vs underlay separation
- Data plane vs control plane responsibilities
- VXLAN encapsulation and forwarding behavior
- Block storage decoupling from compute nodes
- VM lifecycle and migration internals
- Namespace-based virtual networking design

---

## 7. Possible Extensions

Future evolution of this work could include:

- Integration with OpenStack services
- Kubernetes networking integration
- SDN controller implementation
- Automation using Ansible or Terraform
- Monitoring and observability stack

---

## 8. Conclusion

This project represents a ground-up reconstruction of cloud infrastructure fundamentals.

By manually building each component, the internal behavior of compute, networking, storage, and migration mechanisms becomes transparent and fully understood.

The result is a structured, layered IaaS simulation that mirrors real-world cloud architecture while remaining fully controllable and inspectable.
