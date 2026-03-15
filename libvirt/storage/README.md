# Libvirt Storage Layer

This directory documents the storage configurations used by libvirt domain definitions in the manual IaaS infrastructure.

It describes how virtual machine disks are attached and managed, but does not contain actual disk image files.

## Supported Storage Models

### 1. qcow2 File-Backed Disks
Virtual machines use disk image files stored on the host filesystem.

These are typically used for:

- Ephemeral-style deployments
- Lab experimentation
- Non-persistent workloads

### 2. LVM-Backed Logical Volumes
Virtual machines use logical volumes exposed as block devices to libvirt.

This model simulates persistent block storage and enables:

- Better I/O performance
- Snapshot capability
- Realistic cloud-style storage behavior

## Design Principle

Storage artifacts are not versioned in this repository.  
Only configuration and structural definitions are tracked to maintain reproducibility without committing binary disk data.
