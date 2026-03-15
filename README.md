# manual-iaas-cloud-infrastructure-openstack-style

Manual implementation of an OpenStack-style IaaS cloud infrastructure built from scratch using Linux, QEMU, Open vSwitch, VXLAN, and network namespaces.

This project reconstructs the core building blocks of a modern Infrastructure-as-a-Service (IaaS) cloud environment without relying on OpenStack itself.  
The objective is to deeply understand how real cloud providers implement compute virtualization, software-defined networking, storage integration, and control-plane and data-plane logic at a low level.

The entire infrastructure is designed and assembled manually to demonstrate architectural clarity, operational control, and technical rigor.

---

## Project Vision

This repository is structured to reflect how a real cloud infrastructure is designed, layered, and evolved.  
Each component is organized according to infrastructure hierarchy — from architectural design to advanced operational capabilities.

The goal is not only functional implementation, but also disciplined organization, documentation quality, and engineering presentation.

---

## Repository Structure

### 1. architecture/
Infrastructure design diagrams and logical system architecture.  
Includes high-level topology, underlay and overlay networking design, compute node layout, and end-to-end packet flow documentation.

### 2. host-config/
Preparation and configuration of physical hosts.  
Includes base networking setup, bridge configuration, kernel settings, and host-level prerequisites for virtualization and networking.

### 3. libvirt/
Virtual machine definitions and hypervisor configuration using QEMU.  
Includes VM XML templates, resource allocation logic, and virtualization management structure.

### 4. scripts/
Infrastructure automation and operational scripts.  
Includes Open vSwitch bridge setup, VXLAN tunnel configuration, namespace preparation, and reload procedures.

### 5. persistent-storage/
Block storage integration and external storage logic.  
Includes iSCSI configuration, storage mapping, and persistent disk attachment workflows.

### 6. floating-ip/
External network exposure and NAT logic.  
Includes IP tables configuration, external bridge mapping, and public-to-private address translation mechanisms.

### 7. vm-migration/
Manual virtual machine migration procedures.  
Includes both ephemeral and persistent storage migration workflows across compute nodes.

---

## Technical Scope

The project covers:

- QEMU-based virtualization
- Software-defined networking using Open vSwitch
- VXLAN overlay networking
- Linux network namespaces
- Manual control-plane logic recreation
- Data-plane packet flow analysis
- Storage abstraction and block-level integration
- Operational procedures such as VM migration

---

## Objective

To understand, build, and document a cloud infrastructure at the infrastructure-engineering level — reproducing the internal mechanics of IaaS platforms rather than using them as black boxes.
