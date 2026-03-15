# LVM Layer (Netnode)

This directory documents the Logical Volume Manager (LVM) configuration used to provide persistent block devices for virtual machines.

The netnode acts as the storage backend for all persistent VMs.

---

## Role in Architecture

Physical Disk → Physical Volume (PV) → Volume Group (VG) → Logical Volume (LV) → iSCSI → Compute → VM

Where:

- PV = /dev/sdb
- VG = cinder-volumes
- LV = One per virtual machine

Each persistent VM receives its own Logical Volume.

---

## One-Time Setup (Per Lab)

Install LVM:

sudo apt update
sudo apt install lvm2 -y

Create Physical Volume:

sudo pvcreate /dev/sdb

Create Volume Group:

sudo vgcreate cinder-volumes /dev/sdb

These steps are executed only once.

---

## Per-VM Logical Volume Creation

Example:

sudo lvcreate --name tc1blue-lvm --size 2G cinder-volumes

LV path:

/dev/cinder-volumes/tc1blue-lvm

Removal:

sudo lvremove /dev/cinder-volumes/tc1blue-lvm

---

## OS Image Preparation

Because iSCSI exports raw block devices, a raw OS image must be written into the LV.

Example:

qemu-img convert alpine.img alpine.raw
sudo dd if=alpine.raw of=/dev/cinder-volumes/tc1blue-lvm

---

## Persistence Behavior

The Logical Volume persists:

- Filesystem
- Installed operating system
- VM data

Even if compute nodes reboot, the storage remains on the netnode.
