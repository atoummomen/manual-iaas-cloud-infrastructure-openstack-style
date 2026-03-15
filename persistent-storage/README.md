# Persistent Storage Layer – iSCSI + LVM

This module documents the implementation of persistent block storage for the manual-iaas-cloud-infrastructure-openstack-style infrastructure.

Unlike qcow2 file-backed disks, this layer provides remote, persistent block devices exported over iSCSI and consumed directly by virtual machines.

The storage architecture is based on:

- LVM on the netnode
- iSCSI Target (netnode)
- iSCSI Initiator (compute nodes)
- Libvirt integration using raw block devices

This simulates a Cinder-like block storage backend without deploying OpenStack services.

---

## Architectural Flow

Netnode:

Physical Disk → LVM (VG: `cinder-volumes`) → Logical Volume → iSCSI Target → LUN

Compute Nodes:

iSCSI Discovery → Login → Remote Block Device (`/dev/disk/by-path/`)

Virtual Machine:

Libvirt `<disk type='block'>` → Raw block device → Direct boot from remote LV

---

## Execution Model

The workflow is divided into four phases:

1. Base environment preparation (one-time per node)
2. Logical Volume creation (per VM)
3. iSCSI export and initiator login
4. Libvirt VM integration

Each phase is isolated to preserve architectural clarity.

---

## Persistence Model

What persists:

- Logical Volume data
- Filesystem
- Installed operating system

What may require re-initialization after reboot:

- iSCSI target binding (if not configured persistent)
- LUN export (if not persistent)
- Initiator login

---

## Warning

This layer manipulates raw block devices.

It must be executed only in isolated lab environments.  
Incorrect commands may permanently destroy data.
