# iSCSI Layer

This directory documents the iSCSI configuration used to export LVM logical volumes from the netnode to compute nodes.

In this architecture:

- The netnode acts as the iSCSI Target
- Compute nodes act as iSCSI Initiators
- Each Logical Volume is exported as a LUN
- Each LUN becomes a remote block device on compute nodes

---

## Architectural Flow

Netnode:

Logical Volume → iSCSI Target → LUN

Compute Node:

iSCSI Discovery → Login → Remote Block Device

Virtual Machine:

Libvirt references the remote block device using `<disk type='block'>`.

---

## Execution Model

The iSCSI workflow is divided into:

1. Target creation (netnode)
2. LUN export (per Logical Volume)
3. Initiator discovery and login (compute node)

---

## LUN Management

Each Logical Volume must be exported with a unique LUN ID.

Example mapping:

- LUN 1 → tc1red-lvm
- LUN 2 → tc1blue-lvm
- LUN 3 → tc1green-lvm
- LUN 4 → tc2red-lvm
- LUN 5 → tc2blue-lvm
- LUN 6 → tc3blue-lvm
- LUN 7 → tc3green-lvm

LUN numbering must remain consistent with VM disk definitions.

---

## Reboot Considerations

If persistence is not configured at the service level, the following may need to be re-run:

- Target binding
- LUN export
- Initiator login
